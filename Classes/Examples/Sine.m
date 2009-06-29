/**
 * Sine. 
 * 
 * Smoothly scaling size with the sin() function. 
 */
/*
float spin = 0.0; 
float diameter = 84.0; 
float angle;

float angle_rot; 
int rad_points = 90;

void setup() 
{
    size(200, 200);
    noStroke();
    smooth();
}

void draw() 
{ 
    background(153);
    
    translate(130, 65);
    
    fill(255);
    ellipse(0, 0, 16, 16);
    
    angle_rot = 0;
    fill(51);
    
    for(int i=0; i<5; i++) {
        pushMatrix();
        rotate(angle_rot + -45);
        ellipse(-116, 0, diameter, diameter);
        popMatrix();
        angle_rot += PI*2/5;
    }
    
    diameter = 34 * sin(angle) + 168;
    
    angle += 0.02;
    if (angle > TWO_PI) { angle = 0; }
}
*/
//
//  Sine.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Sine.h"

static const float spin = 0.0; 
static const int rad_points = 90;

@implementation Sine

- (void)setup
{
    [self size:200 :200];
    [self noStroke];
    [self smooth];
    diameter = 84.0;
}

- (void)draw
{
    [self background:[self color:153]];
    
    [self translate:130 :65];
    
    [self fill:[self color:255]];
    [self ellipse:0 :0 :16 :16];
    
    angle_rot = 0;
    [self fill:[self color:51]];
    
    for(int i=0; i<5; i++) {
        [self pushMatrix];
        [self rotate:angle_rot + -45];
        [self ellipse:-116 :0 :diameter :diameter];
        [self popMatrix];
        angle_rot += PI*2/5;
    }
    
    diameter = 34 * [self sin:angle] + 168;
    
    angle += 0.02;
    if (angle > TWO_PI) { angle = 0; }    
}

@end
