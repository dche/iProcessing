/**
 * Cubic Grid 
 * by Ira Greenberg. 
 * 
 * 3D translucent colored grid uses nested pushMatrix()
 * and popMatrix() functions. 
 */
/*
float boxSize = 40;
float margin = boxSize*2;
float depth = 400;
color boxFill;

void setup() {
    size(640, 360, P3D);
    noStroke();
}

void draw() {
    background(255);
    
    // Center and spin grid
    translate(width/2, height/2, -depth);
    rotateY(frameCount * 0.01);
    rotateX(frameCount * 0.01);
    
    // Build grid using multiple translations 
    for (float i =- depth/2+margin; i <= depth/2-margin; i += boxSize){
        pushMatrix();
        for (float j =- height+margin; j <= height-margin; j += boxSize){
            pushMatrix();
            for (float k =- width+margin; k <= width-margin; k += boxSize){
                // Base fill color on counter values, abs function 
                // ensures values stay within legal range
                boxFill = color(abs(i), abs(j), abs(k), 50);
                pushMatrix();
                translate(k, j, i);
                fill(boxFill);
                box(boxSize, boxSize, boxSize);
                popMatrix();
            }
            popMatrix();
        }
        popMatrix();
    }
}
*/
//
//  CubicGrid.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-08.
//  Copyright 2009 campl software. All rights reserved.
//

#import "CubicGrid.h"

static const float boxSize = 40;
static const float margin = 80; //boxSize*2;
static const float depth = 400;


@implementation CubicGrid

- (void)setup
{
    [self size:320 :320 :P3D];
    [self noStroke];
}

- (void)draw
{
    [self background:[self color:255]];
    
    // Center and spin grid
    [self translate:self.width/2 :self.height/2 :-depth];
    [self rotateY:[self frameCount] * 0.01];
    [self rotateX:[self frameCount] * 0.01];
    
    // Build grid using multiple translations 
    for (float i =- depth/2+margin; i <= depth/2-margin; i += boxSize){
        [self pushMatrix];
        for (float j =- self.height+margin; j <= self.height-margin; j += boxSize){
            [self pushMatrix];
            for (float k =- self.width+margin; k <= self.width-margin; k += boxSize){
                // Base fill color on counter values, abs function 
                // ensures values stay within legal range
                boxFill = [self color:[self abs:i] :[self abs:j] :[self abs:k] :50];
                [self pushMatrix];
                [self translate:k :j :i];
                [self fill:boxFill];
                [self box:boxSize :boxSize :boxSize];
                [self popMatrix];
            }
            [self popMatrix];
        }
        [self popMatrix];
    }
}

@end
