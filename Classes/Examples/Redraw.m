/**
 * Redraw. 
 * 
 * The redraw() function makes draw() execute once.  
 * In this example, draw() is executed once every time 
 * the mouse is clicked. 
 */
/*
// The statements in the setup() function 
// execute once when the program begins
void setup() 
{
    size(200, 200);  // Size should be the first statement
    stroke(255);     // Set line drawing color to white
    noLoop();
}

float y = 100;

// The statements in draw() are executed until the 
// program is stopped. Each statement is executed in 
// sequence and after the last line is read, the first 
// line is executed again.
void draw() 
{ 
    background(0);   // Set the background to black
    y = y - 1; 
    if (y < 0) { y = height; } 
    line(0, y, width, y);  
} 

void mousePressed() 
{
    redraw();
}
*/

//
//  Redraw.m
//  iProcessing
//
//  Translated by Diego Che on 09-06-23.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Redraw.h"


@implementation Redraw

- (void)setup
{
    [self size:200 :200];  // Size should be the first statement
    [self stroke:255];     // Set line drawing color to white
    [self noLoop];

    y = 100.0f;
}

- (void)draw
{
    [self background:0];   // Set the background to black
    y = y - 1; 
    if (y < 0) { y = [self height]; } 
    [self line:0 :y :[self width] :y];    
}

- (void)mousePressed
{
    [self redraw];
}

@end
