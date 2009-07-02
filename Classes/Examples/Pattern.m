/**
 * Patterns. 
 * 
 * Move the cursor over the image to draw with a software tool 
 * which responds to the speed of the mouse. 
 */
/*
void setup()
{
    size(640, 360);
    background(102);
    smooth();
}

void draw() 
{
    // Call the variableEllipse() method and send it the
    // parameters for the current mouse position
    // and the previous mouse position
    variableEllipse(mouseX, mouseY, pmouseX, pmouseY);
}


// The simple method variableEllipse() was created specifically 
// for this program. It calculates the speed of the mouse
// and draws a small ellipse if the mouse is moving slowly
// and draws a large ellipse if the mouse is moving quickly 

void variableEllipse(int x, int y, int px, int py) 
{
    float speed = abs(x-px) + abs(y-py);
    stroke(speed);
    ellipse(x, y, speed, speed);
}
*/
//
//  Pattern.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-01.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Pattern.h"

@interface Pattern ()

- (void)variableEllipse:(int)x :(int)y :(int)px :(int)py; 

@end


@implementation Pattern
- (void)setup
{
    [self size:320 :320];
    [self background:[self color:102]];
    [self smooth];
}

- (void)draw 
{
    // Call the variableEllipse() method and send it the
    // parameters for the current mouse position
    // and the previous mouse position
    [self variableEllipse:[self mouseX] :[self mouseY] :[self pmouseX] :[self pmouseY]];
}

- (void)variableEllipse:(int)x :(int)y :(int)px :(int)py
{
    float speed = [self abs:x-px] + [self abs:y-py];
    [self stroke:[self color:speed]];
    [self ellipse:x :y :speed :speed];    
}

@end
