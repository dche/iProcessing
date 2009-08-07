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

static const int kTextImageCacheSize = 16;

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
- (void)removeAmbientColorFromLight:(GLenum)light;
- (void)setAttenuationForLight:(GLenum)light;

- (void)drawTexture:(GLuint)texObj inRect:(CGRect)rect;

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
        
        // CHECK: Do we need a version using GLES2?
        context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        if (!context || ![EAGLContext setCurrentContext:context]) {
            [self release];
            return nil;
        }        
        
        p_ = p;
        
        vertices_ = [[NSMutableData alloc] initWithCapacity:kDefaultIndicesNumber * sizeof(PVertex)];
        indices_ = [[NSMutableData alloc] initWithCapacity:kDefaultIndicesNumber * sizeof(GLuint)];
        colors_ = [[NSMutableData alloc] initWithCapacity:kDefaultIndicesNumber * sizeof(PColor)];
        normals_ = [[NSMutableData alloc] initWithCapacity:kDefaultIndicesNumber * sizeof(PVector)];
        texCoords_ = [[NSMutableData alloc] initWithCapacity:kDefaultIndicesNumber * sizeof(PTextureCoord)];
        unitCircleCache_ = [[NSMutableData alloc] initWithCapacity:kDefaultIndicesNumber * sizeof(PVector)];
        
        // Defaults
        sphereURes_ = sphereVRes_ = 30.0f;
        lightSpecular_ = PColorMake(PWhiteColor);
        lightAttenuationConst_ = 1.0f;
        textureMode_ = IMAGE;
        
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
    if (pixels_ != NULL) {
        free(pixels_);
    }
    
    [curFont_ release];
    [textImageCache_ release];
    
    [vertices_ release];
    [indices_ release];
    [colors_ release];
    [normals_ release];
    [texCoords_ release];
    [unitCircleCache_ release];
    
    [super dealloc];
}

- (BOOL)threeD
{
    return (p_.mode == P3D);
}

- (void)textureMode:(int)mode
{
    switch (mode) {
        case IMAGE:
        case NORMAL:
            textureMode_ = mode;
            break;
        default:
            break;
    }
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
        glShadeModel(GL_SMOOTH);
        
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
    if ([self threeD] && curLights_ > 0) {
        [self noLights];
    }
    [p_ guardedDraw];
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
    
    CHECK_GL_ERROR();
}

- (void)layoutSubviews
{
    if (!inInit_) {
        // GL has been initialized in setup().
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
    
    if ([self threeD]) {
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    } else {
        glClear(GL_COLOR_BUFFER_BIT);
    }
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
{/* N/A on iPhone */}

- (void)noSmooth
{/* N/A on iPhone */}

#pragma mark -
#pragma mark Shape
#pragma mark -

- (void)boxWithWidth:(float)w height:(float)h depth:(float)d
{
    float x = w/2.0f;
    float y = h/2.0f;
    float z = d/2.0f;
    
    if (doFill_) {
        [self useColor:fillColor_];
        
        GLfloat vertices[] = {
            // Up
            x, -y, -z, -x, -y, -z, x, -y, z,
            x, -y, z, -x, -y, -z, -x, -y, z,
            // Front
            x, -y, z, -x, -y, z, x, y, z,
            x, y, z, -x, -y, z, -x, y, z,
            // Bottom
            x, y, z, -x, y, z, x, y, -z,
            x, y, -z, -x, y, z, -x, y, -z,
            // Back
            x, y, -z, -x, y, -z, -x, -y, -z,
            -x, -y, -z, x, -y, -z, x, y, -z,
            // Left
            -x, -y, -z, -x, y, -z, -x, -y, z,
            -x, -y, z, -x,  y, -z, -x, y, z,
            // Right
            x, -y, z, x, y, z, x, -y, -z,
            x, -y, -z, x, y, z, x, y, -z,
        };
        GLfloat normals[] = {
            0, -1, 0, 0, -1, 0, 0, -1, 0, 0, -1 ,0, 0, -1, 0, 0, -1, 0,
            0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1,
            0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 
            0, 0, -1, 0, 0, -1, 0, 0, -1, 0, 0, -1, 0, 0, -1, 0, 0, -1, 
            -1, 0, 0, -1, 0, 0, -1, 0, 0, -1, 0, 0, -1, 0, 0, -1, 0, 0, 
            1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 
        };
        
        glVertexPointer(3, GL_FLOAT, 0, vertices);
        glEnableClientState(GL_NORMAL_ARRAY);
        glNormalPointer(GL_FLOAT, 0, normals);
        glDrawArrays(GL_TRIANGLES, 0, 36);
        glDisableClientState(GL_NORMAL_ARRAY);
    }
    
    if (doStroke_) {
        [self useColor:strokeColor_];
        
        GLfloat vertices[] = {
            x, -y, -z,
            -x, -y, -z,
            x, -y, z,
            -x, -y, z,
            x, y, z,
            -x, y, z,
            x, y, -z,
            -x, y, -z,
        };
        GLushort indices[] = {
            0,1, 2,3, 4,5, 6,7,
            0,2, 1,3, 4,6, 5,7,
            0,6, 1,7, 2,4, 3,5,
        };
        
        glVertexPointer(3, GL_FLOAT, 0, vertices);
        glDrawElements(GL_LINES, 24, GL_UNSIGNED_SHORT, indices);
    }
}

- (void)sphereWithRadius:(float)r
{
    float unit_flat = TWO_PI / sphereURes_;
    float unitz = PI / sphereVRes_;
    
    // Get the unit circle
    GLsizei nv = [unitCircleCache_ length] / sizeof(PVector);
    if (nv == 0 || nv != sphereURes_) {
        PVector v = PVertexMake(1, 0, 0);
        [unitCircleCache_ appendBytes:&v length:sizeof(PVector)];
        
        for (float theta = unit_flat; theta < TWO_PI - EPSILON; theta += unit_flat) {
            v = PVertexMake(cosf(theta), sinf(theta), 0);
            [unitCircleCache_ appendBytes:&v length:sizeof(PVector)];
        }
        nv = [unitCircleCache_ length] / sizeof(PVector);
    }    
    
    PVertex *unitVertices = (PVertex *)[unitCircleCache_ bytes];
    
    [vertices_ setLength:2 * nv * sizeof(PVertex)];
    [normals_ setLength:2 * nv * sizeof(PVertex)];
    [indices_ setLength:11 * nv * sizeof(GLushort)];

    PVertex *pv = (PVertex *)[vertices_ mutableBytes];
    PVector *pn = (PVector *)[normals_ mutableBytes];
    GLushort *pi = (GLushort *)[indices_ mutableBytes];
    
    // Add north pole
    PVertexSet(pv, 0, 0, 1);
    PVertexSet(pn, 0, 0, 1);
    
    PVertex *tier1Vector = pv;
    PVector *tier1Normal = pn;
    GLsizei tier1Length = 1;
    PVertex *tier2Vector = pv+nv;
    PVector *tier2Normal = pn+nv;
    GLsizei tier2Length = 0;
    
    // Pre-build indices, since we have known the number of vertices.
    // 6 types of indices should be built.
    // TODO: move indices to a cache.
    int pip = 0;
    // 1. north pole for fill
    pi[pip++] = 0;
    for (int i = 0; i < nv; i++) {
        pi[pip++] = nv+i;
    }
    pi[pip++] = nv;
    // 2. north pole for stroke
    for (int i = 0; i < nv; i++) {
        pi[pip++] = 0;
        pi[pip++] = nv+i;
    }
    // 3. south pole for fill
    pi[pip++] = nv;
    for (int i = 0; i < nv; i++) {
        pi[pip++] = i;
    }
    pi[pip++] = 0;
    // 4. south pole for stroke
    for (int i = 0; i < nv; i++) {
        pi[pip++] = i;
        pi[pip++] = nv;
    }
    // 5. tier1 first
    for (int i = 0; i < nv; i++) {
        pi[pip++] = i;
        pi[pip++] = nv+i;
    }
    pi[pip++] = 0;
    pi[pip++] = nv;
    // 6. tier2 first
    for (int i = 0; i < nv; i++) {
        pi[pip++] = nv+i;
        pi[pip++] = i;
    }
    pi[pip++] = nv;
    pi[pip++] = 0;
    
    glPushMatrix();
    glScalef(r, r, r);
    for (float theta = HALF_PI-unitz; theta > -HALF_PI-EPSILON; theta -= unitz) {        
        float h = sinf(theta);
        float flat_r = cosf(theta);
        
        // Build new tier
        if (theta < -HALF_PI + EPSILON) {
            PVertexSet(tier2Vector, 0, 0, -1);
            PVertexSet(tier2Normal, 0, 0, -1);
            tier2Length = 1;
        } else {
            tier2Length = nv;            
            for (int i = 0; i < nv; i++) {
                PVertex v = unitVertices[i];
                PVertexSet(tier2Normal + i, v.x * flat_r, v.y * flat_r, h);
                PVectorNormalize(tier2Normal + i);
                PVertexSet(tier2Vector+i, v.x * flat_r, v.y *flat_r, h);
            }
        }
        
        GLushort *pindex;
        glVertexPointer(3, GL_FLOAT, 0, pv);
        if (doFill_) {
            [self useColor:fillColor_];
            glEnableClientState(GL_NORMAL_ARRAY);
            glNormalPointer(GL_FLOAT, 0, pn);
            
            if (tier1Length == 1 || tier2Length == 1) {
                pindex = (tier2Vector - pv == 0 || tier1Length == 1) ? (pi) : (pi + nv * 3 + 2);
                glDrawElements(GL_TRIANGLE_FAN, nv+2, GL_UNSIGNED_SHORT, pindex);
            } else {
                pindex = (tier1Vector - pv == 0) ? (pi + nv * 6 + 4) : (pi + nv * 8 + 6);
                glDrawElements(GL_TRIANGLE_STRIP, nv*2 +2, GL_UNSIGNED_SHORT, pindex);
            }
            glDisableClientState(GL_NORMAL_ARRAY);
        }
        
        if (doStroke_) {
            [self useColor:strokeColor_];
            
            if (tier2Length != 1) {
                glDrawArrays(GL_LINE_LOOP, tier2Vector - pv, nv);
            }            
            
            if (tier1Length == 1 || tier2Length == 1) {
                pindex = (tier2Vector - pv == 0 || tier1Length == 1) ? (pi + nv + 2) : (pi + nv * 4 + 4);
            } else {
                pindex = (tier1Vector - pv == 0) ? (pi + nv * 6 + 4) : (pi + nv * 8 + 6);
            }
            glDrawElements(GL_LINES, nv * 2, GL_UNSIGNED_SHORT, pindex);
        }
        
        // set tier2 to tier1
        tier1Vector = tier2Vector;
        tier1Normal = tier2Normal;
        tier1Length = tier2Length;
        
        if (tier1Vector > pv) {
            tier2Vector = pv;
            tier2Normal = pn;
        } else {
            tier2Vector = pv+tier1Length;
            tier2Normal = pn+tier1Length;
        }
        tier2Length = 0;
    }
    glPopMatrix();
}

- (void)sphereDetailWithUres:(float)u vres:(float)v
{
    if (u < 1 || v < 1) return;
    
    if (sphereURes_ != u) {
        sphereURes_ = u;
        [unitCircleCache_ setLength:0];
    }
    sphereVRes_ = v;
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
    
    if ([self threeD] && doFill_) {
        glNormal3f(0.0f, 0.0f, 1.0f);
    }

    PVertex p = PVertexMake(xc, yc, 0);
    [vertices_ appendBytes:&p length:sizeof(PVertex)];
    
    int i = 1;
    GLfloat theta = theta1;
    for (; i < nTriangles; i++) {
        // TODO: fast sine/cosine, or LUT.
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
        ox, oy, ox + width, oy, ox + width, oy + height, ox, oy + height,
    };
    
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    
    if ([self threeD] && doFill_) {
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
    [vertices_ setLength:0];
    [indices_ setLength:0];

    [colors_ setLength:0];
    [normals_ setLength:0];
    
    [texCoords_ setLength:0];
}

- (PVector)normalForTriangle:(const PVertex *)v
                            :(GLushort)p1 :(GLushort)p2 :(GLushort)p3 
{
    // Note the parameter order of PVectorCross here.
    PVector vn = PVectorCross(PVertexSub(v[p2], v[p1]), PVertexSub(v[p3], v[p1]));
    PVectorNormalize(&vn);
    return vn;
}

- (void)addNormal:(PVector)n
{
    [normals_ appendBytes:&n length:sizeof(PVector)];
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
                        texture:(const NSObject<PTexture> *)t
             perVertexFillColor:(BOOL)useFillColorArray 
           perVertexStrokeColor:(BOOL)useStrokeColorArray 
                   customNormal:(BOOL)normalProvided
                           mode:(int)m 
                          close:(BOOL)toClose
{
    if (n == 0) return;
    
    [self resetDrawingData];
    
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
                    default:    // PVetexNormal
                        if (useFillColorArray) {
                            [colors_ appendBytes:curClr length:sizeof(PColor)];
                        }
                        
                        if (normalProvided) {
                            [normals_ appendBytes:curNormal length:sizeof(PVector)];
                        }
                        
                        if (t != nil) {
                            PTextureCoord tc = *(PTextureCoord *)(a + p);
                            if (textureMode_ == IMAGE) {
                                tc.u = [p_ constrain:[p_ norm:tc.u :0 :[t width]] :0 :1];
                                tc.v = [p_ constrain:[p_ norm:tc.v :0 :[t height]] :0 :1];
                            }
                            [texCoords_ appendBytes:&tc length:sizeof(PTextureCoord)];
                        }
                        p += sizeof(PTextureCoord);
                        break;
                }
            }
        }
        
        if (useFillColorArray) {
            glEnableClientState(GL_COLOR_ARRAY);
            glColorPointer(4, GL_FLOAT, 0, [colors_ bytes]);
        } else {
            [self useColor:fillColor_];
        }
        
        if (t != nil) {
            glEnable(GL_TEXTURE_2D);
            if ([t textureObject] == 0) {
                [t createTextureObject];
            } else {
                glBindTexture(GL_TEXTURE_2D, [t textureObject]);
            }
            
            glEnableClientState(GL_TEXTURE_COORD_ARRAY);
            glTexCoordPointer(2, GL_FLOAT, 0, [texCoords_ bytes]);
            
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, [t mipmap] ? GL_NEAREST_MIPMAP_NEAREST : GL_NEAREST);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
            glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAX_ANISOTROPY_EXT, 1.0f);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);            
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
                    PVector *normalBytes = (PVector *)[normals_ mutableBytes];
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
            glNormalPointer(GL_FLOAT, 0, [normals_ bytes]);
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
            if ([colors_ length] > 0) [colors_ setLength:0];
            
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
                        [colors_ appendBytes:curClr length:sizeof(PColor)];
                        p += sizeof(PTextureCoord);
                        break;
                }
            }
            glColorPointer(4, GL_FLOAT, 0, [colors_ bytes]);
            glEnableClientState(GL_COLOR_ARRAY);
            
        } else {
            [self useColor:strokeColor_];
        }
        
        if ([indices_ length] > 0) [indices_ setLength:0];
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
    if (t != nil) {
        glDisableClientState(GL_TEXTURE_COORD_ARRAY);
        glDisable(GL_TEXTURE_2D);
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
    Matrix3D m;
    Matrix3DSet(&m, n00, n01, n02, n03, 
                n04, n05, n06, n07, 
                n08, n09, n10, n11, 
                n12, n13, n14, n15);
    glMultMatrixf((const GLfloat *)&m);
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
    glGetFloatv(GL_MODELVIEW_MATRIX, (GLfloat *)&m);
    
    return m;
}

- (void)loadMatrix:(Matrix3D)m
{
    glLoadMatrixf((const GLfloat *)&m);
}

#pragma mark -
#pragma mark Typography
#pragma mark -

- (void)textFont:(UIFont *)font
{
    if (curFont_ != font) {
        [curFont_ release];
        curFont_ = [font retain];
    }
}

- (PTexture *)textureForText:(NSString *)str
{
    // key = text + font name + font size + color
    NSString *key = [NSString stringWithFormat:@"%@+%@+%f+%d", str, [curFont_ fontName], [curFont_ pointSize], fillColor_];
    
    PTexture *tex = nil;
    if (textImageCache_ == nil) {
        textImageCache_ = [[NSMutableDictionary alloc] initWithCapacity:kTextImageCacheSize];
    } else {
        tex = [textImageCache_ objectForKey:key];
    }
    
    if (tex == nil) {
        PImage *img = [PImage textureOfString:str withFont:curFont_ inColor:fillColor_];
        [img createTextureObject];
        tex = [PTexture textureFromPImage:img];
        
        if ([textImageCache_ count] == kTextImageCacheSize) {
            // TODO: Randomly remove a image. 
            [textImageCache_ removeObjectForKey:[[textImageCache_ allKeys] objectAtIndex:0]];
        }
        [textImageCache_ setObject:tex forKey:key];
    }
    return tex;
}

- (void)showText:(NSString *)str :(float)x :(float)y :(float)z
{    
    PTexture *tex = [self textureForText:str];
    [self drawTexture:tex.textureObject inRect:CGRectMake(x, y, tex.width, tex.height)];
}

#pragma mark -
#pragma mark Pixel
#pragma mark -

- (color)getPixelAtPoint:(CGPoint)p
{
    if (pixels_ == NULL) {
        [self loadPixels];        
    }
    return pixels_[cordsToIndex(p.x, p.y, p_.width, p_.height, NO)];
}

- (void)setPixel:(color)clr atPoint:(CGPoint)p
{/* N/A in OpenGL ES. Use pixels[] instead. */}

- (color *)loadPixels
{
    if (pixels_ == NULL) {
        pixels_ = malloc(p_.width * p_.height * sizeof(color));
    }
    // BUG: wrong data are read.
    glReadPixels(0, 0, p_.width, p_.height, GL_RGBA, GL_UNSIGNED_BYTE, pixels_);
    return pixels_;
}

- (void)updatePixels
{
    if (pixels_ != NULL) {
        GLuint texObj;
        glGenTextures(1, &texObj);
        glBindTexture(GL_TEXTURE_2D, texObj);
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, p_.width, p_.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, pixels_);
        
        [self drawTexture:texObj inRect:CGRectMake(0, 0, p_.width, p_.height)];
        
        glDeleteTextures(1, &texObj);
        [self releasePixels];
    }
}

- (void)releasePixels
{
    if (pixels_ != NULL) {
        free(pixels_);
        pixels_ = NULL;
    }
}

#pragma mark -
#pragma mark Image
#pragma mark -

- (void)drawTexture:(GLuint)texObj inRect:(CGRect)rect
{
    if (![self threeD]) {
        GLfloat x = rect.origin.x;
        GLfloat y = rect.origin.y;
        GLfloat w = rect.size.width;
        GLfloat h = rect.size.height;
        
        GLfloat vertices[] = {
            x, y, x+w, y, x+w, y+h, x, y+h,
        };
        GLfloat texCoords[] = {
            0, 0, 1, 0, 1, 1, 0, 1,
        };
        
        glEnable(GL_TEXTURE_2D);
        glBindTexture(GL_TEXTURE_2D, texObj);
        
        glVertexPointer(2, GL_FLOAT, 0, vertices);
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        glTexCoordPointer(2, GL_FLOAT, 0, texCoords);
        
        // No fancy settings. Use the simplest.
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
        glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAX_ANISOTROPY_EXT, 1.0f);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        
        glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
        
        glDisableClientState(GL_TEXTURE_COORD_ARRAY);
        glDisable(GL_TEXTURE_2D);
    }
}

- (void)drawImage:(PImage *)image atPoint:(CGPoint)point
{
    [self drawImage:image inRect:CGRectMake(point.x, point.y, image.width, image.height)];
}

- (void)drawImage:(PImage *)image inRect:(CGRect)rect
{
    if ([image textureObject] == 0) {
        [image createTextureObject];
    }
    [self drawTexture:[image textureObject] inRect:rect];
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
    }    
    curLights_ += 1;    
    glEnable([self currentLight]);
    
    return YES;
}

- (GLenum)currentLight
{
    return GL_LIGHT0 + curLights_ - 1;
}

- (void)removeAmbientColorFromLight:(GLenum)light
{
    GLfloat none[] = {
        0, 0, 0, 1.0f,
    };
    glLightfv(light, GL_AMBIENT, none);
}

- (void)setAttenuationForLight:(GLenum)light
{
    glLightf(light, GL_CONSTANT_ATTENUATION, lightAttenuationConst_);
    glLightf(light, GL_LINEAR_ATTENUATION, lightAttenuationLinear_);
    glLightf(light, GL_QUADRATIC_ATTENUATION, lightAttenuationQuardratic_);
}

- (void)addAmbientLightWithColor:(PColor)pc atPosition:(PVector)pos
{
    if ([self enableLight]) {
        GLenum light = [self currentLight];
        
        GLfloat wpos[] = {
            pos.x, pos.y, pos.z, 1.0f,
        };
        
        glLightfv(light, GL_AMBIENT, (const GLfloat *)&pc);
        glLightfv(light, GL_DIFFUSE, (const GLfloat *)&pc);
        glLightfv(light, GL_POSITION, wpos);
        [self setAttenuationForLight:light];
    }    
}

- (void)addDirectionalLightWithColor:(PColor)pc toDirection:(PVector)dir
{
    if ([self enableLight]) {
        GLenum light = [self currentLight];
        
        GLfloat wpos[] = {
            -dir.x, -dir.y, -dir.z, 0.0f,
        };
        
        [self removeAmbientColorFromLight:light];
        glLightfv(light, GL_POSITION, wpos);
        glLightfv(light, GL_DIFFUSE, (const GLfloat *)&pc);
        glLightfv(light, GL_SPECULAR, (const GLfloat *)&lightSpecular_);
        [self setAttenuationForLight:light];
    }
}

- (void)addPointLightWithColor:(PColor)pc atPosition:(PVector)pos
{
    if ([self enableLight]) {
        GLenum light = [self currentLight];
        
        GLfloat wpos[] = {
            pos.x, pos.y, pos.z, 1.0f,
        };
        
        [self removeAmbientColorFromLight:light];
        glLightfv(light, GL_POSITION, wpos);
        glLightfv(light, GL_DIFFUSE, (const GLfloat *)&pc);
        glLightfv(light, GL_SPECULAR, (const GLfloat *)&lightSpecular_);
        [self setAttenuationForLight:light];
    }
}

- (void)addSpotLightWithColor:(PColor)pc 
                        angle:(float)a 
                concentration:(float)c 
                   atPosition:(PVector)pos 
                  toDirection:(PVector)dir
{
    if ([self enableLight]) {
        GLenum light = [self currentLight];
        
        GLfloat wpos[] = {
            pos.x, pos.y, pos.z, 1.0f,
        };
        
        [self removeAmbientColorFromLight:light];
        glLightfv(light, GL_POSITION, wpos);
        glLightfv(light, GL_SPOT_DIRECTION, (const GLfloat *)&dir);
        glLightfv(light, GL_DIFFUSE, (const GLfloat *)&pc);
        [self setAttenuationForLight:light];
        glLightf(light, GL_SPOT_CUTOFF, a * RAD_TO_DEG);
        glLightf(light, GL_SPOT_EXPONENT, c);
    }
}


- (void)noLights
{
    glDisable(GL_LIGHTING);    
    while (curLights_ > 0) {
        glDisable([self currentLight]);
        curLights_--;
    }
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

#pragma mark -
#pragma mark Materials
#pragma mark -

- (void)ambient:(PColor)pc
{
    glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, (const GLfloat *)&pc);
}

- (void)emissive:(PColor)pc
{
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, (const GLfloat *)&pc);
}

- (void)shininess:(float)shine
{
    glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, shine);
}

- (void)specular:(PColor)pc
{
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, (const GLfloat *)&pc);
}

#pragma mark -
#pragma mark Camera
#pragma mark -


@end
