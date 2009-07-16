/**
 * Lights 1. 
 * 
 * Uses the default lights to show a simple box. The lights() function
 * is used to turn on the default lighting.
 */
/*
float spin = 0.0;

void setup() 
{
    size(640, 360, P3D);
    noStroke();
}

void draw() 
{
    background(51);
    lights();
    
    spin += 0.01;
    
    pushMatrix();
    translate(width/2, height/2, 0);
    rotateX(PI/9);
    rotateY(PI/5 + spin);
    box(150);
    popMatrix();
}
*/
//
//  Lights1.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-14.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Lights1.h"


@implementation Lights1

- (void)setup 
{
    [self size:320 :320 :P3D];
    [self noStroke];
}

- (void)draw 
{
    [self background:[self color:51]];
    [self lights];
    
    spin += 0.01f;
    
    [self pushMatrix];
    [self translate:self.width/2.0f :self.height/2.0f :0];
    [self rotateX:PI/9];
    [self rotateY:PI/5 + spin];
    [self box:90];
    [self popMatrix];
}

@end
