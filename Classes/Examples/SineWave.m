/**
 * Sine Wave
 * by Daniel Shiffman.  
 * 
 * Render a simple sine wave. 
 */
/*
int xspacing = 8;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

float theta = 0.0;  // Start angle at 0
float amplitude = 75.0;  // Height of wave
float period = 500.0;  // How many pixels before the wave repeats
float dx;  // Value for incrementing X, a function of period and xspacing
float[] yvalues;  // Using an array to store height values for the wave

void setup() {
    size(200,200);
    frameRate(30);
    colorMode(RGB,255,255,255,100);
    smooth();
    w = width+16;
    dx = (TWO_PI / period) * xspacing;
    yvalues = new float[w/xspacing];
}

void draw() {
    background(0);
    calcWave();
    renderWave();
    
}

void calcWave() {
    // Increment theta (try different values for 'angular velocity' here
    theta += 0.02;
    
    // For every x value, calculate a y value with sine function
    float x = theta;
    for (int i = 0; i < yvalues.length; i++) {
        yvalues[i] = sin(x)*amplitude;
        x+=dx;
    }
}

void renderWave() {
    // A simple way to draw the wave with an ellipse at each location
    for (int x = 0; x < yvalues.length; x++) {
        noStroke();
        fill(255,50);
        ellipseMode(CENTER);
        ellipse(x*xspacing,width/2+yvalues[x],16,16);
    }
}
*/
//
//  SineWave.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import "SineWave.h"

@interface SineWave ()

- (void)calcWave;
- (void)renderWave;

@end

static const int xspacing = 8.0f;   // How far apart should each horizontal location be spaced

@implementation SineWave

- (void)setup
{
    [self size:200 :200];
    [self frameRate:30];
    [self colorMode:RGB :255 :255 :255 :100];
    [self smooth];
    
    amplitude = 75.0;
    period = 500.0;
    w = [self width]+16;
    dx = (TWO_PI / period) * xspacing;
    yvalues = (float *)malloc((w/xspacing) * sizeof(float));
}

- (void)draw
{
    [self background:[self color:0]];
    [self calcWave];
    [self renderWave];    
}

- (void)calcWave
{
    // Increment theta (try different values for 'angular velocity' here
    theta += 0.02;
    
    // For every x value, calculate a y value with sine function
    float x = theta;
    for (int i = 0; i < w/xspacing; i++) {
        yvalues[i] = [self sin:x]*amplitude;
        x+=dx;
    }
}

- (void)renderWave
{
    // A simple way to draw the wave with an ellipse at each location
    for (int x = 0; x < w/xspacing; x++) {
        [self noStroke];
        [self fill:255 :50];
        [self ellipseMode:CENTER];
        [self ellipse:x*xspacing :[self width]/2+yvalues[x] :16 :16];
    }
}

- (void)dealloc
{
    free(yvalues);
    [super dealloc];
}

@end
