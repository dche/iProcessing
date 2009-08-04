/**
 * Noise Wave
 * by Daniel Shiffman.  
 * 
 * Using Perlin Noise to generate a wave-like pattern. 
 */
/*
int xspacing = 8;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave

float yoff = 0.0f;        // 2nd dimension of perlin noise
float[] yvalues;          // Using an array to store height values for the wave (not entirely necessary)

void setup() {
    size(200,200);
    frameRate(30);
    colorMode(RGB,255,255,255,100);
    smooth();
    w = width+16;
    yvalues = new float[w/xspacing];
}

void draw() {
    background(0);
    calcWave();
    renderWave();
    
}

void calcWave() {
    float dx = 0.05f;
    float dy = 0.01f;
    float amplitude = 100.0f;
    
    // Increment y ('time')
    yoff += dy;
    
    //float xoff = 0.0;  // Option #1
    float xoff = yoff; // Option #2
    
    for (int i = 0; i < yvalues.length; i++) {
        // Using 2D noise function
        //yvalues[i] = (2*noise(xoff,yoff)-1)*amplitude; // Option #1
        // Using 1D noise function
        yvalues[i] = (2*noise(xoff)-1)*amplitude;    // Option #2
        xoff+=dx;
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
//  NoiseWave.m
//  iProcessing
//
//  Created by Kenan Che on 09-08-05.
//  Copyright 2009 campl software. All rights reserved.
//

#import "NoiseWave.h"

static const int xspacing = 8;   // How far apart should each horizontal location be spaced


@implementation NoiseWave

- (void)setup
{
    [self size:200 :200 :QUARTZ2D];
    [self frameRate:30];
    [self colorMode:RGB :255 :255 :255 :100];
    [self smooth];
    w = self.width+16;
    yvalues = malloc(w/xspacing * sizeof(float));
}

- (void)dealloc
{
    free(yvalues);
    [super dealloc];
}

- (void)calcWave
{
    float dx = 0.05f;
    float dy = 0.01f;
    float amplitude = 100.0f;
    
    // Increment y ('time')
    yoff += dy;
    
    //float xoff = 0.0;  // Option #1
    float xoff = yoff; // Option #2
    
    for (int i = 0; i < w/xspacing; i++) {
        // Using 2D noise function
        yvalues[i] = (2*[self noise:xoff :yoff]-1)*amplitude; // Option #1
        // Using 1D noise function
        //yvalues[i] = (2*[self noise:xoff]-1)*amplitude;    // Option #2
        xoff+=dx;
    }
    
}

- (void)renderWave
{
    // A simple way to draw the wave with an ellipse at each location
    for (int x = 0; x < w/xspacing; x++) {
        [self noStroke];
        [self fill:255 :50];
        [self ellipseMode:CENTER];
        [self ellipse:x*xspacing :self.width/2+yvalues[x] :16 :16];
    }
}

- (void)draw
{
    [self background:PBlackColor];
    [self calcWave];
    [self renderWave];    
}

@end
