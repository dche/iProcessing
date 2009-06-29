/**
 * Mouse Functions. 
 * 
 * Click on the box and drag it across the screen. 
 */
/*
float bx;
float by;
int bs = 20;
boolean bover = false;
boolean locked = false;
float bdifx = 0.0; 
float bdify = 0.0; 


void setup() 
{
    size(200, 200);
    bx = width/2.0;
    by = height/2.0;
    rectMode(RADIUS);  
}

void draw() 
{ 
    background(0);
    
    // Test if the cursor is over the box 
    if (mouseX > bx-bs && mouseX < bx+bs && 
        mouseY > by-bs && mouseY < by+bs) {
        bover = true;  
        if(!locked) { 
            stroke(255); 
            fill(153);
        } 
    } else {
        stroke(153);
        fill(153);
        bover = false;
    }
    
    // Draw the box
    rect(bx, by, bs, bs);
}

void mousePressed() {
    if(bover) { 
        locked = true; 
        fill(255, 255, 255);
    } else {
        locked = false;
    }
    bdifx = mouseX-bx; 
    bdify = mouseY-by; 
    
}

void mouseDragged() {
    if(locked) {
        bx = mouseX-bdifx; 
        by = mouseY-bdify; 
    }
}

void mouseReleased() {
    locked = false;
}
*/
//
//  MouseFunctions.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import "MouseFunctions.h"


@implementation MouseFunctions

- (void)setup 
{
    [self size:200 :200];
    bx = [self width]/2.0;
    by = [self height]/2.0;
    [self rectMode:RADIUS];
    
    bs = 20;
}

-(void)draw 
{ 
    [self background:[self color:0]];
    
    // Test if the cursor is over the box 
    if ([self mouseX] > bx-bs && [self mouseX] < bx+bs && 
        [self mouseY] > by-bs && [self mouseY] < by+bs) {
        bover = YES;  
        if(!locked) { 
            [self stroke:[self color:255]]; 
            [self fill:[self color:153]];
        } 
    } else {
        [self stroke:[self color:153]];
        [self fill:[self color:153]];
        bover = NO;
    }
    
    // Draw the box
    [self rect:bx :by :bs :bs];
}

- (void)mousePressed
{
    if(bover) { 
        locked = YES; 
        [self fill:255 :255 :255];
    } else {
        locked = NO;
    }
    bdifx = [self mouseX]-bx; 
    bdify = [self mouseY]-by; 
    
}

- (void)mouseDragged
{
    if(locked) {
        bx = [self mouseX]-bdifx; 
        by = [self mouseY]-bdify; 
    }
}

- (void)mouseReleased
{
    locked = NO;
}

@end
