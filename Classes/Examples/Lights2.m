/**
 * Lights 2 
 * by Simon Greenwold. 
 * 
 * Display a box with three different kinds of lights. 
 */
/*
void setup() 
{
    size(640, 360, P3D);
    noStroke();
}

void draw() 
{
    background(0);
    translate(width / 2, height / 2);
    
    // Orange point light on the right
    pointLight(150, 100, 0, // Color
               200, -150, 0); // Position
    
    // Blue directional light from the left
    directionalLight(0, 102, 255, // Color
                     1, 0, 0); // The x-, y-, z-axis direction
    
    // Yellow spotlight from the front
    spotLight(255, 255, 109, // Color
              0, 40, 200, // Position
              0, -0.5, -0.5, // Direction
              PI / 2, 2); // Angle, concentration
    
    rotateY(map(mouseX, 0, width, 0, PI));
    rotateX(map(mouseY, 0, height, 0, PI));
    box(150);
}
*/
//
//  Lights2.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-14.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Lights2.h"


@implementation Lights2
- (void)setup 
{
    [self size:320 :320 :P3D];
    [self noStroke];
}

- (void)draw 
{
    [self background:PBlackColor];
    [self translate:self.width / 2 :self.height / 2];
    
    // Orange point light on the right
    [self pointLight:150 :100 :0    // Color
                    :200 :-150 :0]; // Position
    
    // Blue directional light from the left
    [self directionalLight:0 :102 :255  // Color
                          :1 :0 :0];    // The x-, y-, z-axis direction
    
    // Yellow spotlight from the front
    [self spotLight:255 :255 :109   // Color
                   :0 :40 :200      // Position
                   :0 :-0.5f :-0.5f // Direction
                   :PI / 2 :2];     // Angle, concentration
    
    [self rotateY:[self map:self.mouseX :0 :self.width :0 :PI]];
    [self rotateX:[self map:self.mouseY :0 :self.height :0 :PI]];
    [self box:90];
}
@end
