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

#define kFPSSampleRate                  3
#define kDefaultVerticesArrayLength     30
#define kDefaultFrameRate               60

@interface Processing ()

- (void)applyCurrentStyle;
- (void)startLoop;
- (void)stopLoop;
- (void)drawView;

- (void)sampleFPS;

@end

@implementation Processing

@synthesize showFPS = showFPS_;
@synthesize pixels = pixels_;
@dynamic width, height;

#pragma mark -
#pragma mark GLViewController methods
#pragma mark -

- (id)initWithContainer:(UIView *)containerView
{
    if (self = [super init]) {
        container_ = [containerView retain];
        shapeBegan_ = NO;
        
        mode_ = P2D;
        loop_ = YES;
        frameRate_ = kDefaultFrameRate;
        startTime_ = [[NSDate date] retain];        
        showFPS_ = YES;
        
        styleStack_ = [[NSMutableArray alloc] init];
        curStyle_ = [[PStyle alloc] init];
        
        // init the vertex array, used by beginShape().
        vertices_ = [[NSMutableData alloc] initWithCapacity:kDefaultVerticesArrayLength * sizeof(PVertex)];
        indices_ = [[NSMutableData alloc] initWithCapacity:kDefaultVerticesArrayLength];
        
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
    [curStyle_ release];
    [styleStack_ release];
    
    [vertices_ release];
    [indices_ release];
    
    [super dealloc];
}

- (void)drawView
{
    frameCount_ += 1;    
    [graphics_ draw];
}

- (void)guardedDraw
{
    [self pushMatrix];
    [self draw];    
    // BUG: if user code pushMatrix but did not pop it, we got a wrong matrix.            
    [self popMatrix];
    
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

- (void)startLoop
{
    if (loop_ && visible_ && loopTimer_ == nil) {
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

// quit gracefully
- (void)exit
{
    [self viewWillDisappear:NO];
    [self.view removeFromSuperview];
    [self viewDidDisappear:NO];
    
    self.view = nil;
    graphics_ = nil;
}

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

// save current style
- (void)pushStyle
{
    PStyle *style = [curStyle_ copy];
    [styleStack_ addObject:style];
    [style release];
}

// executes the code within draw() one time
- (void)redraw
{
    if (!loop_) {
        [self drawView];
    }
}

// set the size.
- (void)size:(float)width :(float)height
{
    [self size:width :height :P2D];
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
    mouseX_ = pMouseX_ = w / 2.0f;
    mouseY_ = pMouseY_ = h / 2.0f;
    
    self.view.userInteractionEnabled = YES;
    graphics_ = self.view;
    
    // Set the default background color, which is not part of style.
    [self background:[self color:51]];
    // Disable smooth by default.
    [self noSmooth];
    // Apply default style.
    [self applyCurrentStyle];    
}

@end
