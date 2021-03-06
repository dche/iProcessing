/**
 * Noise3D. 
 * 
 * Using 3D noise to create simple animated texture. 
 * Here, the third dimension ('z') is treated as time. 
 */

/*
float increment = 0.01;
// The noise function's 3rd argument, a global variable that increments once per cycle
float zoff = 0.0;  
// We will increment zoff differently than xoff and yoff
float zincrement = 0.02; 

void setup() {
    size(200,200);
    frameRate(30);
}

void draw() {
    background(0);
    
    // Optional: adjust noise detail here
    // noiseDetail(8,0.65f);
    
    loadPixels();
    
    float xoff = 0.0; // Start xoff at 0
    
    // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
    for (int x = 0; x < width; x++) {
        xoff += increment;   // Increment xoff 
        float yoff = 0.0;   // For every xoff, start yoff at 0
        for (int y = 0; y < height; y++) {
            yoff += increment; // Increment yoff
            
            // Calculate noise and scale by 255
            float bright = noise(xoff,yoff,zoff)*255;
            
            // Try using this line instead
            //float bright = random(0,255);
            
            // Set each pixel onscreen to a grayscale value
            pixels[x+y*width] = color(bright,bright,bright);
        }
    }
    updatePixels();
    
    zoff += zincrement; // Increment zoff
    
    
}

*/

//
//  Noise3D.m
//  iProcessing
//
//  Created by Kenan Che on 09-08-05.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Noise3D.h"

static const float increment = 0.01f;
// We will increment zoff differently than xoff and yoff
static const float zincrement = 0.02f; 

@implementation Noise3D

- (void)setup
{
    [self size:200 :200 :QUARTZ2D];
    [self frameRate:30];
    self.showFPS = YES;
}

- (void)draw
{
    [self background:PBlackColor];
    
    // Optional: adjust noise detail here
    // noiseDetail(8,0.65f);
    
    [self loadPixels];
    
    float xoff = 0.0f; // Start xoff at 0
    
    // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
    for (int x = 0; x < self.width; x++) {
        xoff += increment;   // Increment xoff 
        float yoff = 0.0;   // For every xoff, start yoff at 0
        for (int y = 0; y < self.height; y++) {
            yoff += increment; // Increment yoff
            
            // Calculate noise and scale by 255
            float bright = [self noise:xoff :yoff :zoff]*255;
            
            // Try using this line instead
            //float bright = random(0,255);
            
            // Set each pixel onscreen to a grayscale value
            self.pixels[(int)(x+y*self.width)] = [self color:bright :bright :bright];
        }
    }
    [self updatePixels];
    
    zoff += zincrement; // Increment zoff
    
    
}

@end
