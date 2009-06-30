/**
 * PolarToCartesian
 * by Daniel Shiffman.  
 * 
 * Convert a polar coordinate (r,theta) to cartesian (x,y):  
 * x = r * cos(theta)
 * y = r * sin(theta)
 */

/*
float r;

// Angle and angular velocity, accleration
float theta;
float theta_vel;
float theta_acc;

void setup() {
    size(200,200);
    frameRate(30);
    smooth();
    
    // Initialize all values
    r = 50.0f;
    theta = 0.0f;
    theta_vel = 0.0f;
    theta_acc = 0.0001f;
}

void draw() {
    background(0);
    // Translate the origin point to the center of the screen
    translate(width/2,height/2);
    
    // Convert polar to cartesian
    float x = r * cos(theta);
    float y = r * sin(theta);
    
    // Draw the ellipse at the cartesian coordinate
    ellipseMode(CENTER);
    noStroke();
    fill(200);
    ellipse(x,y,16,16);
    
    // Apply acceleration and velocity to angle (r remains static in this example)
    theta_vel += theta_acc;
    theta += theta_vel;
    
}

*/
//
//  PolarToCartesian.m
//  iProcessing
//
//  Translated by Diego Che on 09-06-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PolarToCartesian.h"


@implementation PolarToCartesian
- (void)setup 
{
    [self size:200 :200];
    [self frameRate:30];
    [self smooth];
    
    // Initialize all values
    r = 50.0f;
    theta = 0.0f;
    theta_vel = 0.0f;
    theta_acc = 0.0001f;
}

- (void)draw
{
    [self background:[self color:0]];
    // Translate the origin point to the center of the screen
    [self translate:[self width]/2 :[self height]/2];
    
    // Convert polar to cartesian
    float x = r * [self cos:theta];
    float y = r * [self sin:theta];
    
    // Draw the ellipse at the cartesian coordinate
    [self ellipseMode:CENTER];
    [self noStroke];
    [self fill:[self color:200]];
    [self ellipse:x :y :16 :16];
    
    // Apply acceleration and velocity to angle (r remains static in this example)
    theta_vel += theta_acc;
    theta += theta_vel;
    
}
@end
