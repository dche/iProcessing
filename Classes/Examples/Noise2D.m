/**
 * Noise2D 
 * by Daniel Shiffman.  
 * 
 * Using 2D noise to create simple texture. 
 */

/*
float increment = 0.02;

void setup() {
    size(200,200);
    noLoop();
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
            float bright = noise(xoff,yoff)*255;
            
            // Try using this line instead
            //float bright = random(0,255);
            
            // Set each pixel onscreen to a grayscale value
            pixels[x+y*width] = color(bright);
        }
    }
    
    updatePixels();
}

*/
//
//  Noise2D.m
//  iProcessing
//
//  Created by Kenan Che on 09-08-04.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Noise2D.h"

static const float increment = 0.02f;

@implementation Noise2D

- (void)setup {
    [self size:320 :320];
    [self noLoop];
}

- (void)draw
{
    [self background:PBlackColor];
    
    // Optional: adjust noise detail here
    // [self noiseDetail:8 :0.65f];
    
    [self loadPixels];
    
    float xoff = 0.0f; // Start xoff at 0
    
    // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
    for (int x = 0; x < self.width; x++) {
        xoff += increment;   // Increment xoff 
        float yoff = 0.0f;   // For every xoff, start yoff at 0
        for (int y = 0; y < self.height; y++) {
            yoff += increment; // Increment yoff
            
            // Calculate noise and scale by 255
            float bright = [self noise:xoff :yoff]*255;
            
            // Try using this line instead
            //float bright = random(0,255);
            
            // Set each pixel onscreen to a grayscale value
            self.pixels[(int)(x+y*self.width)] = [self color:bright];
        }
    }
    
    [self updatePixels];
}

@end
