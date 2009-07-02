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

@interface PGraphics3D ()

- (void)setupGLView;
- (BOOL) createFramebuffer;
- (void) destroyFramebuffer;

@end


@implementation PGraphics3D

+ (Class)layerClass 
{
    return [CAEAGLLayer class];
}

- (id)initWithController:(Processing *)p width:(NSUInteger)w height:(NSUInteger)h
{
    if (self = [super init]) {
        // Get the layer
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        
        eaglLayer.opaque = YES;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
        
        context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        if (!context) {
            context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        }
        
        if (!context || ![EAGLContext setCurrentContext:context]) {
            [self release];
            return nil;
        }        

        p_ = p;        
    }
    return self;
}

- (void)dealloc {    
    if ([EAGLContext currentContext] == context) {
        [EAGLContext setCurrentContext:nil];
    }    
    [context release];  

    [super dealloc];
}

- (void)draw
{
    if (!p_) return;
    
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
    [p_ guardedDraw];
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

- (void)layoutSubviews
{
    [EAGLContext setCurrentContext:context];
    [self destroyFramebuffer];
    [self createFramebuffer];
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
}

- (void)noFill
{
    doFill_ = NO;
}

- (void)fill:(float)red :(float)green :(float)blue :(float)alpha
{

}

- (void)noStroke
{
    doStroke_ = NO;
}

- (void)stroke:(float)red :(float)green :(float)blue :(float)alpha
{
    
}

- (void)strokeCap:(int)mode
{/* N/A in OpenGL mode */}

- (void)strokeJoin:(int)mode
{/* N/A in OpenGL mode */}

- (void)strokeWeight:(float)pixel
{
    
}

- (void)noTint
{
    
}

- (void)tint:(float)red :(float)green :(float)blue :(float)alpha
{
    
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
    
}

- (void)ellipse:(float)ox 
               :(float)oy 
               :(float)width 
               :(float)height
{
    
}

- (void)rect:(float)ox 
            :(float)oy 
            :(float)width 
            :(float)height
{
    
}

- (void)drawShapeWithVertices:(const PVertex *)v 
                      indices:(const Byte *)i 
                 vertexNumber:(NSUInteger)n
                         mode:(int)m 
                        close:(BOOL)toClose
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
    
}

- (void)scale:(float)x :(float)y :(float)z
{
    
}

- (void)translate:(float)x :(float)y :(float)z
{
    
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

@end
