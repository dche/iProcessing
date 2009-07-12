//
//  PGraphics3D.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-16.
//  Copyright 2009 campl software. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "PGraphics3D.h"
#import "Processing.h"

static const float kFieldOfView = PI/3.0f;
static const int kMaxLights = 8;

@interface PGraphics3D ()

- (void)setupGLView;
- (BOOL) createFramebuffer;
- (void) destroyFramebuffer;

- (void)drawPointsWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n;
- (void)drawLinesWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n;
- (void)drawTrianglesWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n;
- (void)drawTriangleSripWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n;
- (void)drawTriangleFanWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n;
- (void)drawQuadsWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n;
- (void)drawQuadStripWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n;
- (void)drawPathWithVertices:(const PVertex *)v indices:(const Byte *)i vertexNumber:(NSUInteger)n;

- (void)useColor:(PColor)pc;

- (void)drawEllipseAtX:(float)ox y:(float)oy width:(float)w height:(float)h start:(float)theta1 stop:(float)theta2;

@end


@implementation PGraphics3D

+ (Class)layerClass 
{
    return [CAEAGLLayer class];
}

- (id)initWithFrame:(CGRect)frame controller:(Processing *)p
{
    if (self = [super initWithFrame:frame]) {
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        
        eaglLayer.opaque = YES;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
        
//        context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        if (!context) {
            context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        }
        
        if (!context || ![EAGLContext setCurrentContext:context]) {
            [self release];
            return nil;
        }        
        
        p_ = p;
        
        // Set up environment for drawing code in +Processing#setup()+.
        [EAGLContext setCurrentContext:context];
        [self createFramebuffer];        
        [self setupGLView];    
    }
    return self;    
}

- (void)dealloc {    
    if ([EAGLContext currentContext] == context) {
        [EAGLContext setCurrentContext:nil];
    }    
    [context release];
    
    [curFont_ release];
    [super dealloc];
}

- (void)swapBuffer
{
    if ([EAGLContext currentContext] == context) {
        glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
        [context presentRenderbuffer:GL_RENDERBUFFER_OES];        
    }
}

- (void)setupGLView
{
    GLsizei w = (GLsizei)(self.bounds.size.width);
    GLsizei h = (GLsizei)(self.bounds.size.height);
    
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_BLEND);
    
    glEnable(GL_DEPTH_TEST);
    
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    
    GLfloat near = h/(2.0f*tanf(kFieldOfView/2.0f));
    glFrustumf(-w/20.0f, w/20.0f, -h/20.0f, h/20.0f, near/10.0f, near * 100);
    glViewport(0, 0, w, h);
        
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glScalef(1.0f, -1.0f, 1);
    glTranslatef(-w/2.0f, -h/2.0f, -near);
    
    glEnableClientState(GL_VERTEX_ARRAY);
}

- (void)draw
{
    if (!p_) return;
    
    [EAGLContext setCurrentContext:context];
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
    [p_ guardedDraw];
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
    
    CHECK_GL_ERROR();
}

- (void)layoutSubviews
{
    [EAGLContext setCurrentContext:context];
    [self destroyFramebuffer];
    [self createFramebuffer];
    
    [self setupGLView];
}

#pragma mark -
#pragma mark OpenGL Setup
#pragma mark -

- (BOOL) createFramebuffer
{
    glGenFramebuffersOES(1, &viewFramebuffer);
    glGenRenderbuffersOES(1, &viewRenderbuffer);
    
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(CAEAGLLayer*)self.layer];
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, viewRenderbuffer);
    
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
    
    glGenRenderbuffersOES(1, &depthRenderbuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
    glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);
    
    if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES) {
        NSLog(@"failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
    
    return YES;    
}

- (void) destroyFramebuffer
{
    glDeleteFramebuffersOES(1, &viewFramebuffer);
    viewFramebuffer = 0;
    glDeleteRenderbuffersOES(1, &viewRenderbuffer);
    viewRenderbuffer = 0;
    
    if(depthRenderbuffer) {
        glDeleteRenderbuffersOES(1, &depthRenderbuffer);
        depthRenderbuffer = 0;
    }
}

#pragma mark -
#pragma mark Drawing
#pragma mark -

- (void)background:(float)red :(float)green :(float)blue :(float)alpha;
{
    glClearColor(red, green, blue, alpha);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    CHECK_GL_ERROR();
}

- (void)noFill
{
    doFill_ = NO;
}

- (void)fill:(float)red :(float)green :(float)blue :(float)alpha
{
    PColorSet(&fillColor_, red, green, blue, alpha);
    doFill_ = YES;
}

- (void)noStroke
{
    doStroke_ = NO;
}

- (void)stroke:(float)red :(float)green :(float)blue :(float)alpha
{
    PColorSet(&strokeColor_, red, green, blue, alpha); 
    doStroke_ = YES;
}

- (void)strokeCap:(int)mode
{/* N/A in OpenGL mode */}

- (void)strokeJoin:(int)mode
{/* N/A in OpenGL mode */}

- (void)strokeWeight:(float)w;
{
    glLineWidth(w);
}

- (void)noTint
{
    doTint_ = NO;
}

- (void)tint:(float)red :(float)green :(float)blue :(float)alpha
{
    PColorSet(&tintColor_, red, green, blue, alpha);
    doTint_ = YES;
}

- (void)smooth
{
    glEnable(GL_LINE_SMOOTH);
    glHint(GL_LINE_SMOOTH_HINT, GL_NICEST);
}

- (void)noSmooth
{
    glDisable(GL_LINE_SMOOTH);
}

#pragma mark -
#pragma mark Shape
#pragma mark -

- (void)arc:(float)ox 
           :(float)oy 
           :(float)width 
           :(float)height
           :(float)start 
           :(float)stop
{
    [self drawEllipseAtX:ox y:oy width:width height:height start:start stop:stop];
}

- (void)ellipse:(float)ox 
               :(float)oy 
               :(float)width 
               :(float)height
{
    [self drawEllipseAtX:ox y:oy width:width height:height start:0 stop:TWO_PI];
}

- (void)drawEllipseAtX:(float)ox y:(float)oy width:(float)w height:(float)h start:(float)theta1 stop:(float)theta2;
{
    GLfloat a = w / 2.0f;
    GLfloat b = h / 2.0f;
    GLfloat xc = ox + a;
    GLfloat yc = oy + b;
    
    float delta = asinf(1 / MAX(a, b)) * 2;
    GLsizei nTriangles = floorf((theta2 - theta1) / delta) + 3;
    PVertex *vertices = malloc(nTriangles * sizeof(PVertex));
    if (vertices == NULL) {
        return;
    }
    
    vertices[0] = PVertexMake(xc, yc, 0);
    
    int i = 1;
    GLfloat theta = theta1;
    for (; i < nTriangles; i++) {
        vertices[i] = PVertexMake(xc + a * cosf(theta), yc + b * sinf(theta), 0);
        theta += delta;
    }
    glVertexPointer(3, GL_FLOAT, 0, vertices);
    if (doFill_) {
        [self useColor:fillColor_];
        glDrawArrays(GL_TRIANGLE_FAN, 0, i);
    }        
    if (doStroke_) {
        [self useColor:strokeColor_];
        glDrawArrays(GL_LINE_STRIP, 1, i - 1);
    }
    
    free(vertices);
}

- (void)rect:(float)ox 
            :(float)oy 
            :(float)width 
            :(float)height
{
    const GLfloat vertices[] = {
        ox, oy, 0, ox + width, oy, 0, ox + width, oy + height, 0, ox, oy + height, 0,
    };
    
    [self drawQuadsWithVertices:vertices vertexNumber:4];
}

- (void)drawShapeWithVertices:(const PVertex *)v 
                      indices:(const Byte *)i 
                 vertexNumber:(NSUInteger)n
                         mode:(int)m 
                        close:(BOOL)toClose
{
    switch (m) {
        case LINES:
            [self drawLinesWithVertices:v vertexNumber:n];
            break;
        case TRIANGLES:
            [self drawTrianglesWithVertices:v vertexNumber:n];
            break;
        case TRIANGLE_STRIP:
            [self drawTriangleSripWithVertices:v vertexNumber:n];
            break;
        case TRIANGLE_FAN:
            [self drawTriangleFanWithVertices:v vertexNumber:n];
            break;
        case POINTS:
            [self drawPointsWithVertices:v vertexNumber:n];
            break;
        case QUADS:
            [self drawQuadsWithVertices:v vertexNumber:n];
            break;
        case QUAD_STRIP:
            [self drawQuadStripWithVertices:v vertexNumber:n];
            break;
        case PATH:
            [self drawPathWithVertices:v indices:i vertexNumber:n];
        default:
            break;
    }
}

- (void)useColor:(PColor)pc
{
    glColor4f(pc.red, pc.green, pc.blue, pc.alpha);
}

- (void)drawPointsWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n
{
    if (!doStroke_) return;
    
    glVertexPointer(3, GL_FLOAT, 0, v);
    [self useColor:strokeColor_];
    glDrawArrays(GL_POINTS, 0, n);
}

- (void)drawLinesWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n
{
    if (!doStroke_) return;

    glVertexPointer(3, GL_FLOAT, 0, v);
    [self useColor:strokeColor_];
    glDrawArrays(GL_LINES, 0, n);
}

- (void)drawTrianglesWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n
{
    glVertexPointer(3, GL_FLOAT, 0, v);
    if (doFill_) {
        [self useColor:fillColor_];
        glDrawArrays(GL_TRIANGLES, 0, n);
    }
    if (doStroke_) {
        GLushort indices[3] = {
            0, 0, 0
        };
        for (int i = 0; i < n / 3; i++) {
            indices[0] = i * 3;
            indices[1] = i * 3 + 1;
            indices[2] = i * 3 + 2;
            
            [self useColor:strokeColor_];
            glDrawElements(GL_LINE_LOOP, 3, GL_UNSIGNED_SHORT, indices);
        }        
    }
}

- (void)drawTriangleSripWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n
{
    glVertexPointer(3, GL_FLOAT, 0, v);
    if (doFill_) {
        [self useColor:fillColor_];
        glDrawArrays(GL_TRIANGLE_STRIP, 0, n);
    }
    if (doStroke_) {
        GLushort indices[3] = {
            0, 0, 0
        };
        for (int i = 0; i < n - 2; i++) {
            indices[0] = i;
            indices[1] = i + 1;
            indices[2] = i + 2;
            
            [self useColor:strokeColor_];
            glDrawElements(GL_LINE_LOOP, 3, GL_UNSIGNED_SHORT, indices);
        }
    }
}

- (void)drawTriangleFanWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n
{
    glVertexPointer(3, GL_FLOAT, 0, v);
    if (doFill_) {
        [self useColor:fillColor_];
        glDrawArrays(GL_TRIANGLE_FAN, 0, n);
    }
    if (doStroke_) {
        GLushort indices[3] = {
            0, 0, 0
        };
        for (int i = 1; i < n; i++) {
            indices[1] = i;
            indices[2] = i + 1;
            
            [self useColor:strokeColor_];
            glDrawElements(GL_LINE_LOOP, 3, GL_UNSIGNED_SHORT, indices);
        }
    }
}

- (void)drawQuadsWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n
{
    glVertexPointer(3, GL_FLOAT, 0, v);
    
    GLushort indices[4] = {
        0, 0, 0, 0,
    };
    for (int i = 0; i < n / 4; i++) {
        indices[0] = i * 4;
        indices[1] = i * 4 + 1;
        indices[2] = i * 4 + 2;
        indices[3] = i * 4 + 3;
        
        if (doFill_) {
            [self useColor:fillColor_];
            glDrawElements(GL_TRIANGLE_FAN, 4, GL_UNSIGNED_SHORT, indices);
        }
        if (doStroke_) {
            [self useColor:strokeColor_];
            glDrawElements(GL_LINE_LOOP, 4, GL_UNSIGNED_SHORT, indices);
        }
    }    
}

- (void)drawQuadStripWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n
{
    glVertexPointer(3, GL_FLOAT, 0, v);
    
    GLushort indices[4] = {
        0, 0, 0, 0,
    };
    // 0---2---4
    // |   |   |
    // 1---3---5    
    for (int i = 0; i < n - 3; i += 2) {
        indices[0] = i;
        indices[1] = i + 1;
        indices[2] = i + 3;
        indices[3] = i + 2;
        
        if (doFill_) {
            [self useColor:fillColor_];
            glDrawElements(GL_TRIANGLE_FAN, 4, GL_UNSIGNED_SHORT, indices);
        }
        if (doStroke_) {
            [self useColor:strokeColor_];
            glDrawElements(GL_LINE_LOOP, 4, GL_UNSIGNED_SHORT, indices);
        }
    }        
}

- (void)drawPathWithVertices:(const PVertex *)v indices:(const Byte *)i vertexNumber:(NSUInteger)n
{
    
}

#pragma mark -
#pragma mark Transformation
#pragma mark -

- (void)multMatrix:(float)n00 :(float)n01 :(float)n02 :(float)n03
                  :(float)n04 :(float)n05 :(float)n06 :(float)n07
                  :(float)n08 :(float)n09 :(float)n10 :(float)n11
                  :(float)n12 :(float)n13 :(float)n14 :(float)n15
{
    Matrix3D m;
    m[0] = n00;  m[1] = n01;  m[2] = n02;  m[3] = n03;
    m[4] = n04;  m[5] = n05;  m[6] = n06;  m[7] = n07;
    m[8] = n08;  m[9] = n09;  m[10] = n10; m[11] = n11;
    m[12] = n12; m[13] = n13; m[14] = n14; m[15] = n15;
    
    glLoadMatrixf(m);
}

- (void)pushMatrix
{
    glPushMatrix();
}

- (void)popMatrix
{
    glPopMatrix();
}

- (void)loadIdentity
{
    glLoadIdentity();
}

- (void)rotate:(float)theta :(float)x :(float)y :(float)z
{
    glRotatef(theta * RAD_TO_DEG, x, y, z);
}

- (void)scale:(float)x :(float)y :(float)z
{
    glScalef(x, y, z);
}

- (void)translate:(float)x :(float)y :(float)z
{
    glTranslatef(x, y, z);
}

#pragma mark -
#pragma mark Typography
#pragma mark -

- (void)textFont:(UIFont *)font
{
    
}

- (void)showText:(NSString *)str :(float)x :(float)y :(float)z
{
    NSLog(@"%@", str);
}

#pragma mark -
#pragma mark Pixel
#pragma mark -
- (color)getPixelAtPoint:(CGPoint)p
{
    return 0;
}

- (void)setPixel:(color)clr  atPoint:(CGPoint)p
{
    
}

#pragma mark -
#pragma mark Image
#pragma mark -
- (void)drawImage:(CGImageRef)image atPoint:(CGPoint)point
{
    
}

- (void)drawImage:(CGImageRef)image inRect:(CGRect)rect
{
    
}

#pragma mark -
#pragma mark Lighting
#pragma mark -

- (void)addAmbientLightWithColor:(PColor)pc
{
    
}

- (void)addAmbientLightWithColor:(PColor)pc atPosition:(PVector)pos
{
    
}

- (void)addDirectionalLightWithColor:(PColor)pc toDirection:(PVector)dir
{
    
}

- (void)addPointLightWithColor:(PColor)pc atPosition:(PVector)pos
{
    
}

- (void)addSpotLightWithColor:(PColor)pc angle:(float)a concentration:(float)c atPosition:(PVector)pos toDirection:(PVector)dir
{
    
}


- (void)noLights
{
    
}


- (void)lightAttenuationConst:(float)c linear:(float)l quardratic:(float)q
{
    
}

- (void)lightSpecular:(PColor)pc
{
    
}

@end
