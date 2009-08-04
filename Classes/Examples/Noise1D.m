/**
 * Noise1D. 
 * 
 * Using 1D Perlin Noise to assign location. 
 */

/*
float xoff = 0.0;
float xincrement = 0.01; 

void setup() {
    size(200,200);
    background(0);
    frameRate(30);
    smooth();
    noStroke();
}

void draw()
{
    // Create an alpha blended background
    fill(0, 10);
    rect(0,0,width,height);
    
    //float n = random(0,width);  // Try this line instead of noise
    
    // Get a noise value based on xoff and scale it according to the window's width
    float n = noise(xoff)*width;
    
    // With each cycle, increment xoff
    xoff += xincrement;
    
    // Draw the ellipse at the value produced by perlin noise
    fill(200);
    ellipse(n,height/2,16,16);
}

*/
//
//  Noise1D.m
//  iProcessing
//
//  Created by Kenan Che on 09-08-04.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Noise1D.h"

static const float xincrement = 0.01; 

@implementation Noise1D

- (void)setup
{
    [self size:200 :200];
    [self background:PBlackColor];
    [self frameRate:30];
    [self smooth];
    [self noStroke];
}

- (void)draw
{
    // Create an alpha blended background
    [self fill:0 :10];
    [self rect:0 :0 :self.width :self.height];
    
    //float n = [self random:0 :self.width];  // Try this line instead of noise
    
    // Get a noise value based on xoff and scale it according to the window's width
    float n = [self noise:xoff]*self.width;
    
    // With each cycle, increment xoff
    xoff += xincrement;
    
    // Draw the ellipse at the value produced by perlin noise
    [self fill:[self color:200]];
    [self ellipse:n :self.height/2.0f :16 :16];
}
@end
