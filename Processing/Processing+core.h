//
//  Processing.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-05.
//  Copyright 2009 campl software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProcessingTypes.h"
#import "PGraphics.h"

@class Processing;

/// A Processing implementation for Cocoa Touch.
///  
@interface Processing : UIViewController {
    
@private
    UIView *container_;
    id<PGraphics> graphics_;
    
    // variables used to maintain status
    int mode_;
    BOOL loop_;
    NSUInteger frameRate_;
    BOOL smooth_;
    int rectMode_;
    int ellipseMode_;
    int strokeCap_;
    int strokeJoin_;
    float strokeWeight_;
    
    int colorMode_;
    float colorRanges_[4];
    color backgroundColor_;
    color fillColor_;
    color strokeColor_;
    
    /// Mouse input states
    BOOL mouseMoved_;
    BOOL mousePressed_;
    BOOL mouseReleased_;
    BOOL mouseDragged_;
    BOOL mouseClicked_;
    float mouseX_;
    float mouseY_;
    float pMouseX_;
    float pMouseY_;
    
    NSDate *startTime_;
    
    NSTimer *loopTimer_;
    NSUInteger frameCount_;
    
    /// For debugging FPS.
    BOOL showFPS_;
    NSTimer *fpsTimer_;
    NSUInteger prevFrameCount_;
}

@property (assign) BOOL showFPS;

- (id)initWithContainer:(UIView *)containerView;

/// TODO: Execute a Processing code.
///
/// This method will create a subview in the containerView. 
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
- (void)mosueReleased;

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

#pragma mark Rendering

@end

