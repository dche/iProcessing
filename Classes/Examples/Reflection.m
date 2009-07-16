/**
 * Reflection 
 * by Simon Greenwold. 
 * 
 * Vary the specular reflection component of a material
 * with the horizontal position of the mouse. 
 */
/*
void setup() {
    size(640, 360, P3D);
    noStroke();
    colorMode(RGB, 1);
    fill(0.4);
}

void draw() {
    background(0);
    translate(width / 2, height / 2);
    // Set the specular color of lights that follow
    lightSpecular(1, 1, 1);
    directionalLight(0.8, 0.8, 0.8, 0, 0, -1);
    float s = mouseX / float(width);
    specular(s, s, s);
    sphere(120);
}
*/
//
//  Reflection.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-14.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Reflection.h"


@implementation Reflection
- (void)setup
{
    [self size:320 :320 :P3D];
    [self noStroke];
    [self colorMode:RGB :1];
    [self fill:[self color:0.4f]];
}

- (void)draw
{
    [self background:[self color:0]];
    [self translate:self.width / 2 :self.height / 2];
    // Set the specular color of lights that follow
    [self lightSpecular:1 :1 :1];
    [self directionalLight:0.8 :0.8 :0.8 :0 :0 :-1];
    float s = self.mouseX / (float)(self.width);
    [self specular:s :s :s];
    [self sphere:120];
}

@end
