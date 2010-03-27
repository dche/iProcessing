//
//  PGraphics.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-30.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Processing.h"
#import "PRender2D.h"
#import "PRender3D.h"

@interface PGraphics ()

- (void)applyCurrentStyle;

@end


@implementation PGraphics

@synthesize mode = mode_;
@synthesize pixels = pixels_;
@synthesize width = width_, height = height_;

@dynamic day, month, year, hour, minute, second;

- (id)init
{
    if (self = [super init]) {
        // Default noise parameters
        [self noiseDetail:4 :0.5f];
        [self noiseSeed:1];
        // Default curve details.
        curveDetail_ = 20;
        [self curveTightness:0];
        [self bezierDetail:20];
        
        curStyle_ = [[PStyle alloc] init];        
    }
    return self;
}

- (id)initWithWidth:(float)w height:(float)h
{
    if (self = [self init]) {
        width_ = w;
        height_ = h;
    }
    return self;
}

- (void)decalloc
{
    [renderer_ release];
    
    [curStyle_ release];
    [styleStack_ release];
    
    [vertices_ release];
    [indices_ release];
    
    if (self.mode == P3D) {
        [accessories_ release];
    }
    
    [super dealloc];
}

- (void)createRenderWithMode:(int)mode frame:(CGRect)frame;
{
    if (renderer_ != nil || CGRectIsEmpty(frame) || (mode != P2D && mode != P3D && mode != QUARTZ2D)) {
        return;
    }
    
    mode_ = mode;
    width_ = frame.size.width;
    height_ = frame.size.height;

    switch (mode_) {
        case QUARTZ2D:
            self.view = [[PRender2D alloc] initWithFrame:frame controller:self];
            break;
        case OPENGL:
            textureMode_ = IMAGE;
        case P2D:
        default:
            self.view = [[PRender3D alloc] initWithFrame:frame controller:self];
            break;
    }
    renderer_ = (id<PRender>)self.view;
    // Apply default style.
    [self applyCurrentStyle];
}

- (void)drawView
{
    [renderer_ draw];
}

- (void)beginDraw
{
    CGRect frame = CGRectMake(0, 0, width_, height_);
    if (!CGRectIsEmpty(frame) && renderer_ == nil) {
        [self createRenderWithMode:QUARTZ2D frame:frame];
    }    
}

- (void)endDraw
{/* Do nothing */}

#pragma mark -
#pragma mark Style
#pragma mark -

- (void)applyCurrentStyle
{
    if (renderer_ == nil) return;
    
    // Only apply styles that affect state of renderer_.    
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

// restore original style
- (void)popStyle
{
    if (styleStack_ == nil || [styleStack_ count] < 1) return;
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
    
    if (styleStack_ == nil) {
        styleStack_ = [[NSMutableArray alloc] init];
    }
    [styleStack_ addObject:style];
    [style release];
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

@end
