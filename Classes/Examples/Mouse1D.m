/**
 * Mouse 1D. 
 * 
 * Move the mouse left and right to shift the balance. 
 * The "mouseX" variable is used to control both the 
 * size and color of the rectangles. 
 */
/*
int gx = 15;
int gy = 35;
float leftColor = 0.0;
float rightColor = 0.0;

void setup() 
{
    size(200, 200);
    colorMode(RGB, 1.0);
    noStroke();
}

void draw() 
{
    background(0.0);
    update(mouseX); 
    fill(0.0, leftColor + 0.4, leftColor + 0.6); 
    rect(width/4-gx, width/2-gx, gx*2, gx*2); 
    fill(0.0, rightColor + 0.2, rightColor + 0.4); 
    rect(width/1.33-gy, width/2-gy, gy*2, gy*2);
}

void update(int x) 
{
    leftColor = -0.002 * x/2 + 0.06;
    rightColor =  0.002 * x/2 + 0.06;
	
    gx = x/2;
    gy = 100-x/2;
    
    if (gx < 10) {
        gx = 10;
    } else if (gx > 90) {
        gx = 90;
    }
    
    if (gy > 90) {
        gy = 90;
    } else if (gy < 10) {
        gy = 10;
    }
}
*/
//
//  Mouse1D.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Mouse1D.h"

@interface Mouse1D ()

- (void)update:(int)x;

@end


@implementation Mouse1D

- (void)setup
{
    [self size:200 :200];
    [self colorMode:RGB :1.0];
    [self noStroke];

    gx = 15;
    gy = 35;
}

- (void)draw 
{
    [self background:0.0];
    [self update:[self mouseX]]; 
    [self fill:0.0 :leftColor + 0.4 :leftColor + 0.6]; 
    [self rect:[self width]/4-gx :[self width]/2-gx :gx*2 :gx*2]; 
    [self fill:0.0 :rightColor + 0.2 :rightColor + 0.4]; 
    [self rect:[self width]/1.33-gy :[self width]/2-gy :gy*2 :gy*2];
}

- (void)update:(int)x 
{
    leftColor = -0.002 * x/2 + 0.06;
    rightColor =  0.002 * x/2 + 0.06;
	
    gx = x/2;
    gy = 100-x/2;
    
    if (gx < 10) {
        gx = 10;
    } else if (gx > 90) {
        gx = 90;
    }
    
    if (gy > 90) {
        gy = 90;
    } else if (gy < 10) {
        gy = 10;
    }
}

@end
