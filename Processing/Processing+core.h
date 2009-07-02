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
    
    color *pixels_;
    
    BOOL shapeBegan_;
    int vertexMode_;
    NSMutableData *vertices_;
    NSMutableData *indices_;
    
    int mode_;
    /// Loop and frameRate
    BOOL loop_;
    BOOL visible_;
    NSUInteger frameRate_;
    NSTimer *loopTimer_;
    NSUInteger frameCount_;

    /// Mouse input states
    BOOL mousePressed_;
    float mouseX_;
    float mouseY_;
    float pMouseX_;
    float pMouseY_;
    
    NSMutableArray *styleStack_;
    PStyle *curStyle_;
    
    /// For computing |milli|
    NSDate *startTime_;
    
    /// For debugging FPS.
    BOOL showFPS_;
    NSTimer *fpsTimer_;
    NSUInteger prevFrameCount_;
    NSUInteger curFPS_;
}

/// Control if measure real Frames per second.
@property (assign) BOOL showFPS;
@property (readonly) float width;
@property (readonly) float height;
@property (readonly) color *pixels;

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

#pragma mark Lights

#pragma mark Camera

#pragma mark Coordinates

#pragma mark Material properties

#pragma mark -
#pragma mark Rendering
#pragma mark -

@end

