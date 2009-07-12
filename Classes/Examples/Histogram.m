/**
 * Histogram. 
 * 
 * Calculates the histogram of an image. 
 * A histogram is the frequency distribution 
 * of the gray levels with the number of pure black values
 * displayed on the left and number of pure white values on the right. 
 */
/*
size(200, 200);
colorMode(RGB, width);

int[] hist = new int[width];

// Load an image from the data directory
// Load a different image by modifying the comments
PImage a;
a = loadImage("cdi01_g.jpg");
image(a, 0, 0);

// Calculate the histogram
for (int i=0; i<width; i++) {
    for (int j=0; j<height; j++) {
        hist[int(red(get(i, j)))]++; 
    }
} 

// Find the largest value in the histogram
float maxval = 0;
for (int i=0; i<width; i++) {
    if(hist[i] > maxval) {
        maxval = hist[i];
    }  
}

// Normalize the histogram to values between 0 and "height"
for (int i=0; i<width; i++) {
    hist[i] = int(hist[i]/maxval * height);
}

// Draw half of the histogram (skip every second value)
stroke(width);
for (int i=0; i<width; i+=2) {
    line(i, height, i, height-hist[i]);
}
*/
//
//  Histogram.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-02.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Histogram.h"


@implementation Histogram

- (void)setup
{
    [self size:200 :200];
    [self colorMode:RGB :[self width]];
    
    int *hist = (int *)calloc([self width], sizeof(int));
    
    PImage *a;
    a = [self loadImage:@"eames.jpg"];
    [self image:a :0 :0];
    
    // Calculate the histogram
    for (int i=0; i<[self width]; i++) {
        for (int j=0; j<[self height]; j++) {
            hist[(int)[self red:[self get:i :j]]] += 1; 
        }
    } 
    
    // Find the largest value in the histogram
    float maxval = 0;
    for (int i=0; i<[self width]; i++) {
        if(hist[i] > maxval) {
            maxval = hist[i];
        }  
    }
    
    // Normalize the histogram to values between 0 and "height"
    for (int i=0; i<[self width]; i++) {
        hist[i] = (int)hist[i]/maxval * [self height];
    }
    
    // Draw half of the histogram (skip every second value)
    [self stroke:[self color:[self width]]];
    for (int i=0; i<[self width]; i+=2) {
        [self line:i :[self height] :i :[self height]-hist[i]];
    }
    
    free(hist);
}

@end
