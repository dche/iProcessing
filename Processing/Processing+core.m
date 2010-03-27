//
//  Processing.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-05.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Processing.h"

#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-class.h>
#endif

#define kFPSSampleRate                  3
#define kDefaultFrameRate               60

@interface Processing ()

- (BOOL)overridedMethod:(SEL)meth;

- (void)startLoop;
- (void)stopLoop;
- (void)drawView;

- (void)sampleFPS;

@end

@implementation Processing

@synthesize showFPS = showFPS_;

@synthesize mouseX = mouseX_, mouseY = mouseY_, pmouseX = pMouseX_, pmouseY = pMouseY_;
@dynamic millis;

#pragma mark -
#pragma mark GLViewController methods
#pragma mark -

- (id)initWithContainer:(UIView *)containerView
{
    if (self = [super init]) {
        container_ = [containerView retain];
        
        loop_ = YES;
        showFPS_ = NO;
        frameRate_ = kDefaultFrameRate;
        startTime_ = [[NSDate date] retain];
                
        [self setup];
        
        if (nil == self.view) {
            [self release];
            return nil;
        }
        
        matrix_ = [self currentMatrix];
    }
    return self;
}

- (void)dealloc
{
    [container_ release];
    [startTime_ release];
    
    [super dealloc];
}

- (void)drawView
{
    frameCount_ += 1;
    [super drawView];
}

- (void)guardedDraw
{
    [self draw];
    
    [self applyMatrix:matrix_];
    
    if (showFPS_) {
        [self pushStyle];
        [self textFont:[UIFont boldSystemFontOfSize:16]];
        [self textAlign:LEFT :BASELINE];
        [self colorMode:RGB];
        [self fill:246 :184 :45];
        [self text:[NSString stringWithFormat:@"%d/%d", curFPS_, frameRate_] :10 :[self height] - 10];
        [self popStyle];
    }    
}

#pragma mark -
#pragma mark UIViewController methods
#pragma mark -

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    visible_ = YES;
    [self startLoop];    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    visible_ = NO;
    [self stopLoop];
}

#pragma mark -
#pragma mark Helpers
#pragma mark -

- (void)setup
{}
- (void)draw
{}

- (void)mouseClicked
{}
- (void)mouseMoved
{}
- (void)mouseDragged
{}
- (void)mousePressed
{}
- (void)mouseReleased
{}

- (BOOL)overridedMethod:(SEL)meth
{
    IMP superImp = class_getMethodImplementation_stret([Processing class], meth);
    IMP selfImp = class_getMethodImplementation_stret([self class], meth);
    
    return (selfImp != superImp);
}

- (void)startLoop
{
    if (loop_ && visible_ && loopTimer_ == nil && [self overridedMethod:@selector(draw)]) {
        loopTimer_ = [NSTimer scheduledTimerWithTimeInterval:1.0f/frameRate_ 
                                                      target:self 
                                                    selector:@selector(drawView) 
                                                    userInfo:nil 
                                                     repeats:YES];
        if (showFPS_) {
            fpsTimer_ = [NSTimer scheduledTimerWithTimeInterval:1.0f/kFPSSampleRate
                                                         target:self 
                                                       selector:@selector(sampleFPS) 
                                                       userInfo:nil 
                                                        repeats:YES];
        }
    }
}

- (void)stopLoop
{
    if (loopTimer_) {
        [loopTimer_ invalidate];
        loopTimer_ = nil;        
    }
    
    if (fpsTimer_) {
        [fpsTimer_ invalidate];
        fpsTimer_ = nil;        
    }
}

- (void)sampleFPS
{
    curFPS_ = (frameCount_ - prevFrameCount_) * kFPSSampleRate;
    prevFrameCount_ = frameCount_;
}

#pragma mark -
#pragma mark Environment
#pragma mark -

// change cursor shape and position. Does nothing.
- (void)cursor
{}

// if can receive input. Allways YES.
- (BOOL)focused
{
    return YES;
}

// returns the display frame rate.
- (NSUInteger)frameRate
{
    return frameRate_;
}

// set the frame rate.
- (void)frameRate:(NSUInteger)fps
{
    frameRate_ = fps;
    [self stopLoop];
    [self startLoop];
}

// frame number since the program starts.
- (NSUInteger)frameCount
{
    return frameCount_;
}

// show cursor. Does nothing.
- (void)noCursor
{}

// returns YES if run within a Browser. Always NO.
- (BOOL)online
{
    return NO;
}

// screen size.
- (CGSize)screen
{
    return [UIScreen mainScreen].bounds.size;
}

#pragma mark -
#pragma mark Structure
#pragma mark -

// stop execution for +ms+ milliseconds
- (void)delay:(NSUInteger)ms
{
    if (loop_) {
        [self stopLoop];
        [NSTimer scheduledTimerWithTimeInterval:ms/1000.0f
                                         target:self 
                                       selector:@selector(startLoop) 
                                       userInfo:nil 
                                        repeats:NO];
    }
}

// quit gracefully. Do nothing.
- (void)exit
{}

// enable loop
- (void)loop
{
    loop_ = YES;
    if (self.view) {
        [self startLoop];        
    }
}

// disable loop
- (void)noLoop
{
    loop_ = NO;
    [self stopLoop];
}

/// Executes the draw() once. If in loop, does nothing.
- (void)redraw
{
    if (!loop_) {
        [self drawView];
    }
}

// Set the size, and initialize Processing.
- (void)size:(float)width :(float)height
{
    // By default, use the OpenGL backed render, but for 2D drawing.
    [self size:width :height :P2D];
}

- (void)size:(float)width :(float)height :(int)mode
{    
    float cw, ch;    
    cw = container_.bounds.size.width;
    ch = container_.bounds.size.height;    
    CGRect frame = CGRectMake(0, 0, width, height);
    frame = CGRectOffset(frame, (cw-width)/2.0f, (ch-height)/2.0f);
    
    [super createRenderWithMode:mode frame:frame];
    [container_ addSubview:self.view];

    // put mouse in the center of the view;
    mouseX_ = pMouseX_ = width / 2.0f;
    mouseY_ = pMouseY_ = height / 2.0f;
    
    self.view.userInteractionEnabled = YES;
    
    // Set the default background color, which is not part of style.
    [self background:[self color:51]];
    // Disable smooth by default.
    [self noSmooth];
}

- (PGraphics *)createGraphics:(float)width :(float)height :(int)render
{
    PGraphics *pg = [[PGraphics alloc] initWithWidth:width height:height];
    return [pg autorelease];
}

#pragma mark -
#pragma mark Touch
#pragma mark -

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // mousePressed, mouseX, mouseY.
    UITouch *touch = [[event touchesForView:self.view] anyObject];
    
    mousePressed_ = YES;
    pMouseX_ = mouseX_;
    pMouseY_ = mouseY_;
    
    CGPoint pos = [touch locationInView:self.view];
    mouseX_ = [self constrain:pos.x :0 :[self width]];
    mouseY_ = [self constrain:pos.y :0 :[self height]];
    
    [self mousePressed];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // mouseDragged = YES and mouseMoved = YES
    UITouch *touch = [[event touchesForView:self.view] anyObject];
    
    pMouseX_ = mouseX_;
    pMouseY_ = mouseY_;
    
    CGPoint pos = [touch locationInView:self.view];
    mouseX_ = [self constrain:pos.x :0 :[self width]];
    mouseY_ = [self constrain:pos.y :0 :[self height]];
    
    [self mouseMoved];
    [self mouseDragged];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event touchesForView:self.view] anyObject];
    
    mousePressed_ = NO;
    [self mouseReleased];
    if (touch.tapCount > 0) {
        [self mouseClicked];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{}

#pragma mark -
#pragma mark Input - Mouse
#pragma mark -

// Does nothing.
- (int)mouseButton
{
    return 0;
}

- (BOOL)isMousePressed
{
    return mousePressed_; 
}

#pragma mark -
#pragma mark Input - File
#pragma mark -

// TODO: Input - File
- (NSData *)loadBytes:(NSURL*)url
{
    return nil;
}

- (NSArray *)loadStrings:(NSURL*)url
{
    return nil;
}

#pragma mark -
#pragma mark Input - Time
#pragma mark -

// Returns the milliseconds since the view loaded.
- (int)millis
{
    NSTimeInterval ti = -[startTime_ timeIntervalSinceNow];
    return (int)floor(ti * 1000);
}

@end
