//
//  Processing.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-05.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Processing.h"
#import "PGraphics2D.h"
#import "PGraphics3D.h"

#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-class.h>
#endif

#define kFPSSampleRate                  3
#define kDefaultFrameRate               60

@interface Processing ()

- (BOOL)overridedMethod:(SEL)meth;

- (void)applyCurrentStyle;
- (void)startLoop;
- (void)stopLoop;
- (void)drawView;

- (void)sampleFPS;

@end

@implementation Processing

@synthesize showFPS = showFPS_;

@synthesize mode = mode_;
@synthesize pixels = pixels_;
@dynamic width, height;

@synthesize mouseX = mouseX_, mouseY = mouseY_, pmouseX = pMouseX_, pmouseY = pMouseY_;
@dynamic day, month, year, hour, minute, second, millis;

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
        
        // Detault noise parameters
        [self noiseDetail:8 :0.5f];
        [self noiseSeed:1];
        
        styleStack_ = [[NSMutableArray alloc] init];
        curStyle_ = [[PStyle alloc] init];
        
        [self setup];
        
        if (nil == graphics_) {
            [self release];
            return nil;
        }
        
        matrix_ = [graphics_ matrix];
    }
    return self;
}

/// Execute a Processing code.
///
+ (void)execute:(NSString *)code inContainer:(UIView *)containerView
{
    // TBD.
}

- (void)dealloc
{
    [graphics_ release];
    [container_ release];
    [startTime_ release];
    [curStyle_ release];
    [styleStack_ release];
    
    [vertices_ release];
    [indices_ release];
    
    if (self.mode == P3D) {
        [accessories_ release];
    }
    
    [super dealloc];
}

- (void)drawView
{
    frameCount_ += 1;    
    [graphics_ draw];
}

- (void)guardedDraw
{
    [self draw];
    
    [graphics_ loadMatrix:matrix_];
    
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

- (void)observeValueForKeyPath:(NSString *)keyPath 
                      ofObject:(id)object 
                        change:(NSDictionary *)change 
                       context:(void *)context
{
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

- (void)applyCurrentStyle
{
    if (graphics_ == nil) return;
    
    // Only apply styles that affect state of graphics_.    
    // fill color, stroke color, stroke cap, join and weight
    BOOL doFill, doStroke, doTint;
    
    doFill = curStyle_.doFill;
    doStroke = curStyle_.doStroke;
    doTint = curStyle_.doTint;
    
    [self fill:curStyle_.fillColor];
    [self stroke:curStyle_.strokeColor];
    [self strokeCap:curStyle_.strokeCap];
    [self strokeJoin:curStyle_.strokeJoin];
    [self strokeWeight:curStyle_.strokeWeight];
    [self tint:curStyle_.tintColor];
    
    if (!doFill) [self noFill];
    if (!doStroke) [self noStroke];
    if (!doTint) [self noTint];
    
    // font
    [self textFont:curStyle_.curFont];
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

// height of the view
- (float)height
{
    return self.view.frame.size.height;
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

// width of the view.
- (float)width
{
    return self.view.frame.size.width;
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

// restore original style
- (void)popStyle
{
    if ([styleStack_ count] < 1) return;
    [curStyle_ release];
    curStyle_ = [styleStack_ objectAtIndex:[styleStack_ count] - 1];
    [curStyle_ retain];
    [styleStack_ removeLastObject];
    
    [self applyCurrentStyle];
}

/// save current style
- (void)pushStyle
{
    PStyle *style = [curStyle_ copy];
    [styleStack_ addObject:style];
    [style release];
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
    if (width < 1 || height < 1 || (mode != P2D && mode != P3D && mode != QUARTZ2D)) {
        return;
    }
    
    mode_ = mode;
    
    float cw, ch;    
    cw = container_.bounds.size.width;
    ch = container_.bounds.size.height;    
    CGRect frame = CGRectMake(0, 0, width, height);
    frame = CGRectOffset(frame, (cw-width)/2.0f, (ch-height)/2.0f);
    
    switch (mode_) {
        case QUARTZ2D:
            self.view = [[PGraphics2D alloc] initWithFrame:frame controller:self];
            break;
        case OPENGL:
            textureMode_ = IMAGE;
        case P2D:
        default:
            self.view = [[PGraphics3D alloc] initWithFrame:frame controller:self];
            break;
    }
    [container_ addSubview:self.view];

    // put mouse in the center of the view;
    mouseX_ = pMouseX_ = width / 2.0f;
    mouseY_ = pMouseY_ = height / 2.0f;
    
    self.view.userInteractionEnabled = YES;
    graphics_ = (id<PGraphics>)self.view;
    
    // Set the default background color, which is not part of style.
    [self background:[self color:51]];
    // Disable smooth by default.
    [self noSmooth];
    // Apply default style.
    [self applyCurrentStyle];    
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

- (int)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dc = [calendar components:NSDayCalendarUnit fromDate:[NSDate date]];
    return [dc day];
}

- (int)month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dc = [calendar components:NSMonthCalendarUnit fromDate:[NSDate date]];
    return [dc month];
}

- (int)year
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dc = [calendar components:NSYearCalendarUnit fromDate:[NSDate date]];
    return [dc year];
}

- (int)hour
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dc = [calendar components:NSHourCalendarUnit fromDate:[NSDate date]];
    return [dc hour];
}

- (int)minute
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dc = [calendar components:NSMinuteCalendarUnit fromDate:[NSDate date]];
    return [dc minute];
}

- (int)second
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dc = [calendar components:NSSecondCalendarUnit fromDate:[NSDate date]];
    return [dc second];
}

// Returns the milliseconds since the view loaded.
- (int)millis
{
    NSTimeInterval ti = -[startTime_ timeIntervalSinceNow];
    return (int)floor(ti * 1000);
}

@end
