//
//  Processing+input.h
//  BubbleTalk
//
//  Created by Kenan Che on 09-06-06.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Processing+core.h"

@interface Processing (Input)

#pragma mark -
#pragma mark Input - Mouse
#pragma mark -

- (int)mouseButton;
- (BOOL)isMousePressed;
- (float)mouseX;
- (float)mouseY;
- (float)pmouseX;
- (float)pmouseY;

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
- (int)day;
- (int)month;
- (int)year;
- (int)hour;
- (int)minute;
- (int)second;
// Returns the milliseconds since the layer is entered.
- (int)millis;

@end
