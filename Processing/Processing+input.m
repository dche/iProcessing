//
//  Processing+input.m
//  BubbleTalk
//
//  Created by Kenan Che on 09-06-06.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Processing.h"


@implementation Processing (Input)

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

- (float)mouseX
{
    return mouseX_;
}

- (float)mouseY
{
    return mouseY_;
}

- (float)pmouseX
{
    return pMouseX_;
}

- (float)pmouseY
{
    return pMouseY_;
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
