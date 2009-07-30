/**
 * The Mandelbrot Set
 * by Daniel Shiffman.  
 * 
 * Simple rendering of the Mandelbrot set.
 */
/*
// Establish a range of values on the complex plane
// A different range will allow us to "zoom" in or out on the fractal
// float xmin = -1.5; float ymin = -.1; float wh = 0.15;
float xmin = -2.5; 
float ymin = -2; 
float wh = 4;

void setup() {
    size(200, 200);
    noLoop();
    background(255);
}

void draw() {
    
    loadPixels();
    
    // Maximum number of iterations for each point on the complex plane
    int maxiterations = 200;
    
    // x goes from xmin to xmax
    float xmax = xmin + wh;
    // y goes from ymin to ymax
    float ymax = ymin + wh;
    
    // Calculate amount we increment x,y for each pixel
    float dx = (xmax - xmin) / (width);
    float dy = (ymax - ymin) / (height);
    
    // Start y
    float y = ymin;
    for(int j = 0; j < height; j++) {
        // Start x
        float x = xmin;
        for(int i = 0;  i < width; i++) {
            
            // Now we test, as we iterate z = z^2 + cm does z tend towards infinity?
            float a = x;
            float b = y;
            int n = 0;
            while (n < maxiterations) {
                float aa = a * a;
                float bb = b * b;
                float twoab = 2.0 * a * b;
                a = aa - bb + x;
                b = twoab + y;
                // Infinty in our finite world is simple, let's just consider it 16
                if(aa + bb > 16.0) {
                    break;  // Bail
                }
                n++;
            }
            
            // We color each pixel based on how long it takes to get to infinity
            // If we never got there, let's pick the color black
            if (n == maxiterations) {
                pixels[i+j*width] = 0;
            } else {
                // Gosh, we could make fancy colors here if we wanted
                pixels[i+j*width] = color(n*16 % 255);  
            }
            x += dx;
        }
        y += dy;
    }
    updatePixels();
}
*/
//
//  Mandelbrot.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-02.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Mandelbrot.h"

static const float xmin = -2.5; 
static const float ymin = -2; 
static const float wh = 4;

@implementation Mandelbrot
- (void)setup
{
    [self size:200 :200];
    [self noLoop];
    [self background:[self color:255]];
}

- (void)draw
{    
    [self loadPixels];
    
    // Maximum number of iterations for each point on the complex plane
    int maxiterations = 200;
    
    // x goes from xmin to xmax
    float xmax = xmin + wh;
    // y goes from ymin to ymax
    float ymax = ymin + wh;
    
    // Calculate amount we increment x,y for each pixel
    float dx = (xmax - xmin) / ([self width]);
    float dy = (ymax - ymin) / ([self height]);
    
    // Start y
    float y = ymin;
    for(int j = 0; j < self.height; j++) {
        // Start x
        float x = xmin;
        for(int i = 0;  i < self.width; i++) {
            
            // Now we test, as we iterate z = z^2 + cm does z tend towards infinity?
            float a = x;
            float b = y;
            int n = 0;
            while (n < maxiterations) {
                float aa = a * a;
                float bb = b * b;
                float twoab = 2.0 * a * b;
                a = aa - bb + x;
                b = twoab + y;
                // Infinty in our finite world is simple, let's just consider it 16
                if(aa + bb > 16.0) {
                    break;  // Bail
                }
                n++;
            }
            
            // We color each pixel based on how long it takes to get to infinity
            // If we never got there, let's pick the color black
            if (n == maxiterations) {
                self.pixels[i+j*(int)self.width] = 0;
            } else {
                // Gosh, we could make fancy colors here if we wanted
                self.pixels[i+j*(int)self.width] = [self color:n*16 % 255];  
            }
            x += dx;
        }
        y += dy;
    }
    [self updatePixels];
}
@end
