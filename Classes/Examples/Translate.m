/**
 * Translate. 
 * 
 * The translate() function allows objects to be moved
 * to any location within the window. The first parameter
 * sets the x-axis offset and the second parameter sets the
 * y-axis offset. 
 */
/*
float x, y;
float size = 40.0;

void setup() 
{
    size(200,200);
    noStroke();
    frameRate(30);
}

void draw() 
{
    background(102);
    
    x = x + 0.8;
    
    if (x > width + size) {
        x = -size;
    } 
    
    translate(x, height/2-size/2);
    fill(255);
    rect(-size/2, -size/2, size, size);
    
    // Transforms accumulate.
    // Notice how this rect moves twice
    // as fast as the other, but it has
    // the same parameter for the x-axis value
    translate(x, size);
    fill(0);
    rect(-size/2, -size/2, size, size);
}
*/
//
//  Translate.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Translate.h"

static const float size = 40.0;

@implementation Translate

- (void)setup
{
    [self size:200 :200];
    [self noStroke];
    [self frameRate:30];    
}

- (void)draw
{
    [self background:102];
    
    x = x + 0.8;
    
    if (x > [self width] + size) {
        x = -size;
    } 
    
    [self translate:x :[self height]/2-size/2];
    [self fill:255];
    [self rect:-size/2 :-size/2 :size :size];
    
    // Transforms accumulate.
    // Notice how this rect moves twice
    // as fast as the other, but it has
    // the same parameter for the x-axis value
    [self translate:x :size];
    [self fill:0];
    [self rect:-size/2 :-size/2 :size :size];    
}

@end
