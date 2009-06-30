/**
 * Continuous Lines. 
 * 
 * Click and drag the mouse to draw a line. 
 */
/*
void setup() {
    size(640, 200);
    background(102);
}

void draw() {
    stroke(255);
    if(mousePressed) {
        line(mouseX, mouseY, pmouseX, pmouseY);
    }
}
*/
//
//  ContinuousLines.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-30.
//  Copyright 2009 campl software. All rights reserved.
//

#import "ContinuousLines.h"


@implementation ContinuousLines

- (void)setup
{
    [self size:320 :320];
    [self background:[self color:102]];
}

- (void)draw
{
    [self stroke:[self color:255]];
    if ([self isMousePressed]) {
        [self line:[self mouseX] :[self mouseY] :[self pmouseX] :[self pmouseY]];
    }
}

@end
