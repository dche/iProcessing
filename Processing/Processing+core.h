//
//  Processing.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-05.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PGraphics.h"

/// A Processing implementation for Cocoa Touch.
///  
@interface Processing : PGraphics {
    
@private
    /// Weak reference to the container of the view.
    UIView *container_;
    /// Loop flag.
    BOOL loop_;
    /// If the associated view is visible. Changed by viewWillAppear and viewWillDisappear.
    BOOL visible_;
    /// Current frameRate
    NSUInteger frameRate_;
    /// Timer for restart draw()
    NSTimer *loopTimer_;
    /// Number of frames since setup() is called.
    NSUInteger frameCount_;
    
    /// Origin matrix. 
    /// This matrix should be restored after each draw().
    Matrix3D matrix_;
                
    /// Mouse input states
    BOOL mousePressed_;
    float mouseX_;
    float mouseY_;
    float pMouseX_;
    float pMouseY_;
    
    /// For computing |millis|
    NSDate *startTime_;
    
    /// For debugging FPS.
    BOOL showFPS_;
    NSTimer *fpsTimer_;
    NSUInteger prevFrameCount_;
    NSUInteger curFPS_;
}

/// Control if measure real FPS. Default is NO.
@property (nonatomic, assign) BOOL showFPS;

- (id)initWithContainer:(UIView *)containerView;

#pragma mark -
#pragma mark Methods supposed to be implemented by subclass.
#pragma mark -

- (void)setup;
- (void)draw;

- (void)mouseClicked;
- (void)mouseMoved;
- (void)mouseDragged;
- (void)mousePressed;
- (void)mouseReleased;

#pragma mark -
#pragma mark Environment
#pragma mark -

/// change cursor shape and position. Does nothing.
- (void)cursor;
/// if can receive input. Allways YES.
- (BOOL)focused;
/// returns the display frame rate.
- (NSUInteger)frameRate;
/// set the frame rate.
- (void)frameRate:(NSUInteger)rate;
/// frame number since the program starts.
- (NSUInteger)frameCount;
/// show cursor. Not implemented.
- (void)noCursor;
/// if run within a Browser. Always NO.
- (BOOL)online;
/// screen size.
- (CGSize)screen;

#pragma mark -
#pragma mark Structure
#pragma mark -

/// Called by render when render is ready to draw.
- (void)guardedDraw;

/// stop execution for +ms+ milliseconds
- (void)delay:(NSUInteger)ms;
/// quit gracefully
- (void)exit;
/// enable loop
- (void)loop;
/// disable loop
- (void)noLoop;
/// executes the code within draw() one time
- (void)redraw;
/// set the size. 
- (void)size:(float)width :(float)height;
- (void)size:(float)width :(float)height :(int)mode;

#pragma mark -
#pragma mark Rendering
#pragma mark -

- (PGraphics *)createGraphics:(float)width :(float)height :(int)render;

#pragma mark -
#pragma mark Input - Mouse
#pragma mark -

- (int)mouseButton;
- (BOOL)isMousePressed;

@property (readonly) float mouseX;
@property (readonly) float mouseY;
@property (readonly) float pmouseX;
@property (readonly) float pmouseY;

#pragma mark -
#pragma mark Input - Keyboard
#pragma mark Not implemented
#pragma mark -
#pragma mark Input - Web
#pragma mark Not implemented
#pragma mark -
#pragma mark Input - File
#pragma mark Not implemented
#pragma mark -

- (NSData *)loadBytes:(NSURL*)url;
- (NSArray *)loadStrings:(NSURL*)url;

#pragma mark Input - Time

/// Returns the milliseconds since the ViewController is initialized.
@property (readonly) int millis;

@end

