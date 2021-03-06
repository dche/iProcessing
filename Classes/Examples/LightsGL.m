/**
 * LightsGL. 
 * Modified from an example by Simon Greenwold. 
 * 
 * Display a box with three different kinds of lights. 
 */
/*

import processing.opengl.*;

void setup() 
{
    size(1024, 768, OPENGL);
    noStroke();
}

void draw() 
{
    defineLights();
    background(0);
    
    for (int x = 0; x <= width; x += 100) {
        for (int y = 0; y <= height; y += 100) {
            pushMatrix();
            translate(x, y);
            rotateY(map(mouseX, 0, width, 0, PI));
            rotateX(map(mouseY, 0, height, 0, PI));
            box(90);
            popMatrix();
        }
    }
}

void defineLights() {
    // Orange point light on the right
    pointLight(150, 100, 0,   // Color
               200, -150, 0); // Position
    
    // Blue directional light from the left
    directionalLight(0, 102, 255, // Color
                     1, 0, 0);    // The x-, y-, z-axis direction
    
    // Yellow spotlight from the front
    spotLight(255, 255, 109,  // Color
              0, 40, 200,     // Position
              0, -0.5, -0.5,  // Direction
              PI / 2, 2);     // Angle, concentration
}
*/
//
//  LightsGL.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-14.
//  Copyright 2009 campl software. All rights reserved.
//

#import "LightsGL.h"


@implementation LightsGL

- (void)defineLights
{
    // Orange point light on the right
    [self pointLight:150 :100 :0   // Color
                    :200 :-150 :0]; // Position
    
    // Blue directional light from the left
    [self directionalLight:0 :102 :255 // Color
                          :1 :0 :0];    // The x-, y-, z-axis direction
    
    // Yellow spotlight from the front
    [self spotLight:255 :255 :109  // Color
                   :0 :40 :200     // Position
                   :0 :-0.5 :-0.5  // Direction
                   :PI / 2 :2];     // Angle, concentration
}

- (void)setup 
{
    [self size:320 :320 :OPENGL];
    [self noStroke];
}

- (void)draw 
{
    [self defineLights];
    [self background:PBlackColor];
    
    for (int x = 0; x <= self.width; x += 60) {
        for (int y = 0; y <= self.height; y += 100) {
            [self pushMatrix];
            [self translate:x :y];
            [self rotateY:[self map:self.mouseX :0 :self.width :0 :PI]];
            [self rotateX:[self map:self.mouseY :0 :self.height :0 :PI]];
            [self box:50];
            [self popMatrix];
        }
    }
}

@end
