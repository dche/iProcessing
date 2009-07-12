//
//  Processing.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-05.
//  Copyright 2009 campl software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProcessingFunctions.h"
#import "PGraphicsProtocol.h"
#import "PStyle.h"

@class PGraphics;

/// A Processing implementation for Cocoa Touch.
///  
@interface Processing : UIViewController {
    
@private
    UIView *container_;
    id<PGraphics> graphics_;
    
    /// QUARTZ2D, P2D or P3D (OPENGL)
    int mode_;
    /// Loop flag.
    BOOL loop_;
    /// If the associated view is visible. Changed by viewWillAppear and viewWillDisappear.
    BOOL visible_;
    /// Current frameRate
    NSUInteger frameRate_;
    NSTimer *loopTimer_;
    /// Number of frames since setup() is called.
    NSUInteger frameCount_;
    
    //..........................
    //  Image
    //..........................
    
    /// The pixels array
    color *pixels_;
    
    //..........................
    //  Shape
    //..........................

    /// Flag between beginShape() and endShape()
    BOOL shapeBegan_;
    /// Current vertex mode. Because bezierVertex and curveVertex can be
    /// used in PATH mode only.
    int vertexMode_;
    /// The vertex list.
    NSMutableData *vertices_;
    /// The index list, contains vertex types.
    NSMutableData *indices_;
    
    //..........................
    //  3D
    //..........................
    
    /// YES if perspective projection is used, o.w., ortho projection. Default is YES.
    BOOL perspective_;
        
    //..........................
    //  Mouse Input
    //..........................

    /// Mouse input states
    BOOL mousePressed_;
    float mouseX_;
    float mouseY_;
    float pMouseX_;
    float pMouseY_;
    
    NSMutableArray *styleStack_;
    PStyle *curStyle_;
    
    /// For computing |millis|
    NSDate *startTime_;
    
    /// For debugging FPS.
    BOOL showFPS_;
    NSTimer *fpsTimer_;
    NSUInteger prevFrameCount_;
    NSUInteger curFPS_;
}

/// Control if measure real Frames per second.
@property (assign) BOOL showFPS;

@property (readonly) color *pixels;
@property (readonly) int mode;
@property (readonly) float width;
@property (readonly) float height;

- (id)initWithContainer:(UIView *)containerView;

/// Called by concrete PGraphics instance.
- (void)guardedDraw;

/// TODO: Execute raw Processing code.
///
+ (void)execute:(NSString *)code inContainer:(UIView *)containerView;

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
/// height of the view
- (float)height;
/// show cursor. Not implemented.
- (void)noCursor;
/// if run within a Browser. Always NO.
- (BOOL)online;
/// screen size.
- (CGSize)screen;
/// width of the view.
- (float)width;

#pragma mark -
#pragma mark Structure
#pragma mark -

/// stop execution for +ms+ milliseconds
- (void)delay:(NSUInteger)ms;
/// quit gracefully
- (void)exit;
/// enable loop
- (void)loop;
/// disable loop
- (void)noLoop;
/// restore original style
- (void)popStyle;
/// save current style
- (void)pushStyle;
/// executes the code within draw() one time
- (void)redraw;
/// set the size. 
- (void)size:(float)width :(float)height;
- (void)size:(float)width :(float)height :(int)mode;

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
#pragma mark -

- (NSData *)loadBytes:(NSURL*)url;
- (NSArray *)loadStrings:(NSURL*)url;

#pragma mark Input - Time

@property (readonly) int day;
@property (readonly) int month;
@property (readonly) int year;
@property (readonly) int hour;
@property (readonly) int minute;
@property (readonly) int second;
/// Returns the milliseconds since the ViewController is initialized.
@property (readonly) int millis;

@end

