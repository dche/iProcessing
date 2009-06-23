//
//  Processing.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-05.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Processing.h"
#import "PGraphics.h"
#import "PGraphics3D.h"

@interface Processing ()

- (void)setDefaults;
- (void)startLoop;
- (void)stopLoop;
- (void)drawView;

- (void)drawFPS;

@end

@implementation Processing

@synthesize showFPS = showFPS_;

#pragma mark -
#pragma mark GLViewController methods
#pragma mark -

- (id)initWithContainer:(UIView *)containerView
{
    if (self = [super init]) {
        container_ = [containerView retain];
        
        mode_ = P2D;
        loop_ = YES;
        smooth_ = YES;
        frameRate_ = kDefaultFrameRate;
        rectMode_ = CORNER;
        ellipseMode_ = CENTER;

        [self colorMode:RGB];        
        startTime_ = [NSDate date];
        
        showFPS_ = YES;
        
        [self setup];
    }
    return self;
}

/// Execute a Processing code.
///
/// This method will create a subview in the containerView. 
+ (void)execute:(NSString *)code inContainer:(UIView *)containerView
{
    // TBD.
}

- (void)dealloc
{
    [graphics_ release];
    [container_ release];
    [startTime_ release];
    
    [super dealloc];
}

- (void)drawView
{
    if (self.view) {
        frameCount_ += 1;
        [graphics_ draw];
    }
}

#pragma mark -
#pragma mark UIViewController methods
#pragma mark -

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startLoop];    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
- (void)mosueReleased
{}

- (void)startLoop
{
    if (loop_) {
        loopTimer_ = [NSTimer scheduledTimerWithTimeInterval:1.0f/frameRate_ 
                                                      target:self 
                                                    selector:@selector(drawView) 
                                                    userInfo:nil 
                                                     repeats:YES];
        fpsTimer_ = [NSTimer scheduledTimerWithTimeInterval:1 
                                                     target:self 
                                                   selector:@selector(drawFPS) 
                                                   userInfo:nil 
                                                    repeats:YES];
    }
}

- (void)stopLoop
{
    if (loopTimer_) {
        [loopTimer_ invalidate];
        loopTimer_ = nil;
        
        [fpsTimer_ invalidate];
        fpsTimer_ = nil;
    }
}

// Called in |size()| after the graphics object is created.
- (void)setDefaults
{
    if (graphics_ == nil) return;
    
    // fill color, stroke color, stroke cap, join and weight
    [self background:51];
    [self fill:[self color:251]];
    [self stroke:[self color:0]];
    [self strokeCap:ROUND];
    [self strokeJoin:MITER];
    [self strokeWeight:1];    
}

- (void)drawFPS
{
    NSUInteger fps = frameCount_ - prevFrameCount_;
    prevFrameCount_ = frameCount_;
    
    // TODO: draw on the canvas after text support is done.
    NSLog(@"FPS: %d", fps);
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

// quit gracefully
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
    
}

// save current style
- (void)pushStyle
{
    
}

// executes the code within draw() one time
- (void)redraw
{
    if (!loop_) {
        [self draw];
    }
}

// set the size.
- (void)size:(float)width :(float)height
{
    [self size:width :height :QUARTZ2D];
}

- (void)size:(float)width :(float)height :(int)mode
{
    mode_ = mode;
    
    switch (mode_) {
        case OPENGL:
            self.view = [[PGraphics3D alloc] initWithController:self width:width height:height];
            break;
        case QUARTZ2D:
            self.view = [[PGraphics2D alloc] initWithController:self width:width height:height];
            break;
        default:
            break;
    }
    float cw, ch, w, h;
    
    cw = container_.bounds.size.width;
    ch = container_.bounds.size.height;
    w = [self constrain:width :0 :cw];
    h = [self constrain:height :0 :ch];
    
    CGRect frame = CGRectMake(0, 0, w, h);
    frame = CGRectOffset(frame, (cw-w)/2.0f, (ch-h)/2.0f);
    self.view.frame = frame;
    [container_ addSubview:self.view];

    // put mouse in the center of the view;
    mouseX_ = w / 2.0f;
    mouseY_ = h / 2.0f;
    
    self.view.userInteractionEnabled = YES;
    graphics_ = self.view;
    [self setDefaults];    
}

@end
