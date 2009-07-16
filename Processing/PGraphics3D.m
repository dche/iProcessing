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

static const NSUInteger kDefaultIndicesNumber = 64;
static const float kFieldOfView = PI/3.0f;  // 60 du.
static const int kMaxLights = 8;

@interface PGraphics3D ()

- (BOOL)threeD;

- (void)setupGLView;
- (BOOL)createFramebuffer;
- (void)destroyFramebuffer;

- (void)useColor:(PColor)pc;

- (void)drawEllipseAtX:(float)ox 
                     y:(float)oy 
                 width:(float)w 
                height:(float)h 
                 start:(float)theta1 
                  stop:(float)theta2;

- (void)resetDrawingData;
- (void)addTriangle:(const PVertex *)v 
                   :(GLushort)p1 :(GLushort)p2 :(GLushort)p3 
                   :(BOOL)normalProvided;
- (PVector)normalForTriangle:(const PVertex *)v
                            :(GLushort)p1 :(GLushort)p2 :(GLushort)p3;
- (void)addNormal:(PVector)n;
- (void)addLineFrom:(GLushort)p1 to:(GLushort)p2;
- (void)addPoint:(GLushort)p;

- (BOOL)enableLight;
- (GLenum)currentLight;

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
        
        vertices_ = [[NSMutableData alloc] initWithCapacity:kDefaultIndicesNumber * sizeof(PVertex)];
        indices_ = [[NSMutableData alloc] initWithCapacity:kDefaultIndicesNumber * sizeof(GLuint)];
        fillColorList_ = [[NSMutableData alloc] initWithCapacity:kDefaultIndicesNumber * sizeof(PColor)];
        strokeColorList_ = [[NSMutableData alloc] initWithCapacity:kDefaultIndicesNumber *sizeof(PColor)];
        normalList_ = [[NSMutableData alloc] initWithCapacity:kDefaultIndicesNumber *sizeof(PVector)];
        
        // Defaults
        sphereURes_ = sphereVRes_ = 30.0f;
        
        // Set up environment for drawing code in +Processing#setup()+.
        [EAGLContext setCurrentContext:context];
        [self createFramebuffer];        
        [self setupGLView];
        
        inInit_ = YES;
    }
    return self;    
}

- (void)dealloc {    
    if ([EAGLContext currentContext] == context) {
        [EAGLContext setCurrentContext:nil];
    }    
    [context release];
    
    [curFont_ release];
    
    [vertices_ release];
    [indices_ release];
    [fillColorList_ release];
    [strokeColorList_ release];
    [normalList_ release];
    
    [super dealloc];
}

- (BOOL)threeD
{
    return (p_.mode == P3D);
}

- (void)setupGLView
{
    GLsizei w = (GLsizei)(self.bounds.size.width);
    GLsizei h = (GLsizei)(self.bounds.size.height);
    
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_BLEND);
    
    if ([self threeD]) {
        glEnable(GL_DEPTH_TEST);
        glDepthFunc(GL_LEQUAL);
        
        glFrontFace(GL_CW); // Because we flip the Y-axis.
        
        glEnable(GL_COLOR_MATERIAL);
        
        // glEnable(GL_NORMALIZE);
        glEnable(GL_RESCALE_NORMAL);        
    }
    
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
    if (!inInit_) {
        // GL has been initialized for size() to draw.
        [EAGLContext setCurrentContext:context];
        [self destroyFramebuffer];
        [self createFramebuffer];
        
        [self setupGLView];
    } else {
        inInit_ = NO;
    }
    // Anyway, call draw() at least once.
    [self draw];
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

- (void)boxWithWidth:(float)w height:(float)h depth:(float)d
{
    
}

- (void)sphereWithRadius:(float)r
{
    // Construct vertices for two triangle fan and some triangle strip
    // if Fill
        // Add triangles, compute normal and draw
    // if stroke
        // Add lines, draw the lines.
}

- (void)sphereDetailWithUres:(float)u vres:(float)v
{
    sphereURes_ = u; sphereVRes_ = v;
}

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
    [vertices_  setLength:0];
    
    if (lightEnabled_ && doFill_) {
        glNormal3f(0.0f, 0.0f, 1.0f);
    }

    PVertex p = PVertexMake(xc, yc, 0);
    [vertices_ appendBytes:&p length:sizeof(PVertex)];
    
    // TODO: rewrite with midpoint algorithm.
    int i = 1;
    GLfloat theta = theta1;
    for (; i < nTriangles; i++) {
        p = PVertexMake(xc + a * cosf(theta), yc + b * sinf(theta), 0);
        [vertices_ appendBytes:&p length:sizeof(PVertex)];
        theta += delta;
    }
    glVertexPointer(3, GL_FLOAT, 0, vertices_.bytes);
    if (doFill_) {
        [self useColor:fillColor_];
        glDrawArrays(GL_TRIANGLE_FAN, 0, i);
    }        
    if (doStroke_) {
        [self useColor:strokeColor_];
        glDrawArrays(GL_LINE_STRIP, 1, i - 1);
    }
}

- (void)rect:(float)ox 
            :(float)oy 
            :(float)width 
            :(float)height
{
    const GLfloat vertices[] = {
        ox, oy, 0, ox + width, oy, 0, ox + width, oy + height, 0, ox, oy + height, 0,
    };
    
    glVertexPointer(3, GL_FLOAT, 0, vertices);
    
    if (lightEnabled_ && doFill_) {
        glNormal3f(0.0f, 0.0f, 1.0f);
    }
    
    if (doFill_) {
        [self useColor:fillColor_];
        glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
    }
    if (doStroke_) {
        [self useColor:strokeColor_];
        glDrawArrays(GL_LINE_LOOP, 0, 4);
    }
}

- (void)useColor:(PColor)pc
{
    glColor4f(pc.red, pc.green, pc.blue, pc.alpha);
}

- (void)resetDrawingData
{
    [indices_ setLength:0];

    [fillColorList_ setLength:0];
    [strokeColorList_ setLength:0];
    [normalList_ setLength:0];
}

- (PVector)normalForTriangle:(const PVertex *)v
                            :(GLushort)p1 :(GLushort)p2 :(GLushort)p3 
{
    // Note the parameter order of PVectorCross here.
    PVector vn = PVectorCross(PVertexSub(v[p3], v[p1]), PVertexSub(v[p2], v[p1]));
    PVectorNormalize(&vn);
    return vn;
}

- (void)addNormal:(PVector)n
{
    [normalList_ appendBytes:&n length:sizeof(PVector)];
}

- (void)addTriangle:(const PVertex *)v 
                   :(GLushort)p1 :(GLushort)p2 :(GLushort)p3 
                   :(BOOL)normalProvided
{
    [indices_ appendBytes:&p1 length:sizeof(GLushort)];
    [indices_ appendBytes:&p2 length:sizeof(GLushort)];
    [indices_ appendBytes:&p3 length:sizeof(GLushort)];
    
    if (!normalProvided && [self threeD]) {
        PVector n = [self normalForTriangle:v :p1 :p2 :p3];
        [self addNormal:n];
        [self addNormal:n];
        [self addNormal:n];
    }
}

- (void)addLineFrom:(GLushort)p1 to:(GLushort)p2
{
    [indices_ appendBytes:&p1 length:sizeof(GLushort)];
    [indices_ appendBytes:&p2 length:sizeof(GLushort)];
}

- (void)addPoint:(GLushort)p
{
    [indices_ appendBytes:&p length:sizeof(GLushort)];
}

// FIXME: need a good API to be called by Processing.
- (void)draw3DShapeWithVertices:(const PVertex *)v 
                   vertexNumber:(NSUInteger)n
                        indices:(const Byte *)i 
                    indexNumber:(NSUInteger)ni
                    accessories:(const Byte *)a 
                        texture:(const PImage *)t
             perVertexFillColor:(BOOL)useFillColorArray 
           perVertexStrokeColor:(BOOL)useStrokeColorArray 
                   customNormal:(BOOL)normalProvided
                           mode:(int)m 
                          close:(BOOL)toClose
{
    if (n == 0) return;
    
    [self resetDrawingData];
    
    if (m == PATH) {
        // TODO: finish Polygon drawing.
        // Add necessary vertices for bezier and curves.
        // re-build indices and accessories too.
        
        // Now we have data that match vertex numbers.
    }
    
    glVertexPointer(3, GL_FLOAT, 0, v);
    if (doFill_) {
        if (useFillColorArray || normalProvided || t != nil) {
            NSUInteger p = 0;   // The accessories pointer.
            PColor *curClr = &fillColor_;
            PVector defaultNormal = PVertexMake(0, 0, 1);
            PVector *curNormal = &defaultNormal;
            
            for (int j = 0; j < ni; j++) {
                Byte accessoryType = i[j];
                switch (accessoryType) {
                    case PColorFill:
                        if (useFillColorArray) {
                            curClr = (PColor *)(a + p);
                        }
                    case PColorStroke:
                        p += sizeof(PColor);
                        break;
                    case PNormalVector:
                        if (normalProvided) {
                            curNormal = (PVector *)(a + p);
                        }
                        p += sizeof(PVector);
                        break;
                    default:
                        if (useFillColorArray) {
                            [fillColorList_ appendBytes:curClr length:sizeof(PColor)];
                        }
                        
                        if (normalProvided) {
                            [normalList_ appendBytes:curNormal length:sizeof(PVector)];
                        }
                        
                        if (t != nil) {
                            // TODO: texture map.
                        }
                        p += sizeof(PTextureCord);
                        break;
                }
            }
        }
        
        if (useFillColorArray) {
            glEnableClientState(GL_COLOR_ARRAY);
            glColorPointer(4, GL_FLOAT, 0, [fillColorList_ bytes]);
        } else {
            [self useColor:fillColor_];
        }
        
        GLenum drawingMode = GL_TRIANGLE_STRIP;
        GLsizei indexNumber = 0;
        switch (m) {
            case TRIANGLES:
                if (!normalProvided && [self threeD]) {
                    for (GLushort j = 0; j < n/3; j++) {
                        PVector nm = [self normalForTriangle:v :j*3 :j*3+1 :j*3+2];
                        [self addNormal:nm];
                        [self addNormal:nm];
                        [self addNormal:nm];
                    }
                }
                drawingMode = GL_TRIANGLES;
                indexNumber = n/3 * 3;
                break;
            case TRIANGLE_FAN:
                if (!normalProvided && [self threeD]) {
                    PVector zeroNormal = PVertexMake(0, 0, 0);
                    [self addNormal:zeroNormal];
                    
                    for (GLushort j = 1; j < n-1; j++) {
                        if (!normalProvided && [self threeD]) {
                            PVector nm = [self normalForTriangle:v :0 :j :j+1];
                            [self addNormal:nm];
                            PVectorAdd(&zeroNormal, &nm);
                            
                            // Add normal of the last vertex, which shares 
                            // the normal with the second last vertex.
                            if (j == n-2) {
                                [self addNormal:nm];
                            }
                        }
                    }
                    PVectorNormalize(&zeroNormal);
                    PVector *normalBytes = (PVector *)[normalList_ mutableBytes];
                    normalBytes[0] = zeroNormal;
                }
                drawingMode = GL_TRIANGLE_FAN;
                indexNumber = n;
                break;
            case QUAD_STRIP:
            case TRIANGLE_STRIP:
                if (!normalProvided && [self threeD]) {
                    for (GLushort j = 0; j < n-2; j++) {
                        PVector nm;
                        if (j & 1 == 0) {
                            nm = [self normalForTriangle:v :j :j+1 :j+2];
                        } else {
                            nm = [self normalForTriangle:v :j+1 :j :j+2];
                        }
                        [self addNormal:nm];
                        // Add normals for last two vertices.
                        if (j == n-3) {
                            [self addNormal:nm];
                            [self addNormal:nm];
                        }
                    }
                }
                indexNumber = n;
                break;
            case QUADS:
                // How can we ensure four vertices of a quad in same plane? 
                // We can't, and we shouldn't.
                for (GLushort j = 0; j < n/4; j++) {
                    GLushort basep = j*4;
                    [self addPoint:basep];
                    [self addPoint:basep+1];
                    [self addPoint:basep+3];
                                        
                    [self addPoint:basep+3];
                    [self addPoint:basep+1];
                    [self addPoint:basep+2];
                    
                    if (!normalProvided && [self threeD]) {
                        PVector nm = [self normalForTriangle:v :basep :basep+1 :basep+3];
                        [self addNormal:nm];
                        // TODO: Average normal for p1 and p3?
                        [self addNormal:nm];
                        [self addNormal:nm];
                        [self addNormal:nm];
                    }
                }
                drawingMode = GL_TRIANGLES;
                indexNumber = n/4 * 6;
                break;
            case PATH:
                break;
            default:
                break;
        }
        if ([self threeD]) {
            glEnableClientState(GL_NORMAL_ARRAY);
            glNormalPointer(GL_FLOAT, 0, [normalList_ bytes]);
        }
        // For some shapes, we need not re-construct vertex sequence.
        // Just draw original vertex list is enough.
        if ([indices_ length] > 0) {
            glDrawElements(drawingMode, indexNumber, GL_UNSIGNED_SHORT, [indices_ bytes]);
        } else {
            glDrawArrays(drawingMode, 0, indexNumber);
        }
    }
    if (doStroke_) {
        if (useStrokeColorArray) {
            PColor *curClr = &strokeColor_;
            NSUInteger p = 0;
            
            for (int j = 0; j < ni; j++) {
                Byte accessoryType = i[j];
                
                switch (accessoryType) {
                    case PColorStroke:
                        curClr = (PColor *)(a + p);
                    case PColorFill:
                        p += sizeof(PColor);
                        break;
                    case PNormalVector:
                        p += sizeof(PVector);
                        break;
                    default:
                        [strokeColorList_ appendBytes:curClr length:sizeof(PColor)];
                        p += sizeof(PTextureCord);
                        break;
                }
            }
            glEnableClientState(GL_COLOR_ARRAY);
            
        } else {
            [self useColor:strokeColor_];
        }
        
        [indices_ setLength:0]; // Clear indices add in Fill.
        switch (m) {
            case POINTS:
                glDrawArrays(GL_POINTS, 0, n);
                break;
            case LINES:
                glDrawArrays(GL_LINES, 0, n);
                break;
            case TRIANGLES:
                for (GLushort j = 0; j < n/3; j++) {
                    GLushort p1 = j * 3;
                    
                    [self addLineFrom:p1 to:p1 + 1];
                    [self addLineFrom:p1 + 1 to:p1 + 2];
                    [self addLineFrom:p1+2 to:p1];
                }
                glDrawElements(GL_LINES, n/3 * 6, GL_UNSIGNED_SHORT, [indices_ bytes]);
                break;
            case TRIANGLE_FAN:
                for (GLushort j = 1; j < n-1; j++) {
                    [self addLineFrom:0 to:j];
                    if (j < n-1) {
                        [self addLineFrom:j to:j+1];
                    } else {
                        [self addLineFrom:j to:1];
                    }
                }
                glDrawElements(GL_LINES, 4 * n - 6, GL_UNSIGNED_SHORT, [indices_ bytes]);
                break;
            case TRIANGLE_STRIP:
                for (GLushort j = 0; j < n - 2; j++) {
                    [self addLineFrom:j to:j+1];
                    [self addLineFrom:j to:j+2];
                }
                [self addLineFrom:n-2 to:n-1];
                glDrawElements(GL_LINES, 4 * n - 6, GL_UNSIGNED_SHORT, [indices_ bytes]);
                break;
            case QUADS:
                for (GLushort j = 0; j < n/4; j++) {
                    GLushort p1 = j * 4;
                    [self addLineFrom:p1 to:p1 + 1];
                    [self addLineFrom:p1 + 1 to:p1 + 2];
                    [self addLineFrom:p1 + 2 to:p1 + 3];
                    [self addLineFrom:p1 + 3 to:p1];
                }
                glDrawElements(GL_LINES, n/4 * 8, GL_UNSIGNED_SHORT, [indices_ bytes]);
                break;
            case QUAD_STRIP:
                for (GLushort j = 0; j < n/2; j++) {
                    GLushort p1 = j * 2;
                    [self addLineFrom:p1 to:p1 + 1];
                    if (p1 + 2 < n) {
                        [self addLineFrom:p1 to:p1 + 2];
                        [self addLineFrom:p1 + 1 to:p1 + 3];
                    }
                }
                glDrawElements(GL_LINES, n/2 * 6 - 4, GL_UNSIGNED_SHORT, [indices_ bytes]);
                break;
            case PATH:
                for (GLushort j = 0; j < n; j++) {
                    [self addPoint:j];
                }
                if (toClose) {
                    [self addPoint:0];
                }
                glDrawElements(GL_LINE_STRIP, (toClose) ? (n + 1) : (n), GL_UNSIGNED_SHORT, [indices_ bytes]);
                break;
            default:
                break;
        }        
    }
    
    if (useFillColorArray || useStrokeColorArray) {
        glDisableClientState(GL_COLOR_ARRAY);
    }
    if ([self threeD]) {
        glDisableClientState(GL_NORMAL_ARRAY);
    }
}

#pragma mark -
#pragma mark Transformation
#pragma mark -

- (void)multMatrix:(float)n00 :(float)n01 :(float)n02 :(float)n03
                  :(float)n04 :(float)n05 :(float)n06 :(float)n07
                  :(float)n08 :(float)n09 :(float)n10 :(float)n11
                  :(float)n12 :(float)n13 :(float)n14 :(float)n15
{
    Matrix3D m = [self matrix];
    // TODO: Mult
    [self loadIdentity];    // Is this step necessary?
    [self loadMatrix:m];
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

- (Matrix3D)matrix
{
    Matrix3D m;
    glGetFloatv(GL_MODELVIEW_MATRIX, &m);
    
    return m;
}

- (void)loadMatrix:(Matrix3D)m
{
    glLoadMatrixf(&m);
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

- (BOOL)enableLight
{
    if (curLights_ == kMaxLights) {
        return NO;
    }
    
    if (curLights_ == 0) {
        glEnable(GL_LIGHTING);
        lightEnabled_ = YES;

        CHECK_GL_ERROR();
    }    
    curLights_ += 1;    
    glEnable([self currentLight]);
    
    return YES;
}

- (GLenum)currentLight
{
    GLenum light;
    switch (curLights_) {
        case 1:
            light = GL_LIGHT0;
            break;
        case 2:
            light = GL_LIGHT1;
            break;
        case 3:
            light = GL_LIGHT2;
            break;
        case 4:
            light = GL_LIGHT3;
            break;
        case 5:
            light = GL_LIGHT4;
            break;
        case 6:
            light = GL_LIGHT5;
            break;
        case 7:
            light = GL_LIGHT6;
            break;
        case 8:
            light = GL_LIGHT7;
            break;
        default:
            break;
    }
    return light;
}

- (void)enableGlobalAmbientLight:(PColor)pc
{
    if (!glIsEnabled(GL_LIGHTING)) {
        glEnable(GL_LIGHTING);
        lightEnabled_ = YES;
    }
    glLightModelfv(GL_LIGHT_MODEL_AMBIENT, &pc);
}

- (void)addAmbientLightWithColor:(PColor)pc atPosition:(PVector)pos
{
    if ([self enableLight]) {
        GLenum light = [self currentLight];
        
        glLightfv(light, GL_AMBIENT, &pc);
        glLightfv(light, GL_POSITION, &pos);
    }    
}

- (void)addDirectionalLightWithColor:(PColor)pc toDirection:(PVector)dir
{
    if ([self enableLight]) {
        GLenum light = [self currentLight];
        
        glLightfv(light, GL_DIFFUSE, &pc);
        glLightfv(light, GL_SPOT_DIRECTION, &dir);
        glLightf(light, GL_SPOT_CUTOFF, 180.0f);
    }
}

- (void)addPointLightWithColor:(PColor)pc atPosition:(PVector)pos
{
    if ([self enableLight]) {
        
    }
}

- (void)addSpotLightWithColor:(PColor)pc 
                        angle:(float)a 
                concentration:(float)c 
                   atPosition:(PVector)pos 
                  toDirection:(PVector)dir
{
    if ([self enableLight]) {
        
    }
}


- (void)noLights
{
    glDisable(GL_LIGHTING);
    lightEnabled_ = NO;
    curLights_ = 0;
}


- (void)lightAttenuationConst:(float)c linear:(float)l quardratic:(float)q
{
    lightAttenuationConst_ = c;
    lightAttenuationLinear_ = l;
    lightAttenuationQuardratic_ = q;
}

- (void)lightSpecular:(PColor)pc
{
    lightSpecular_ = pc;
}

@end
