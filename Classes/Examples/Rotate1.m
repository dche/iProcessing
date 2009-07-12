/**
 * Rotate 1. 
 * 
 * Rotating simultaneously in the X and Y axis. 
 * Transformation functions such as rotate() are additive.
 * Successively calling rotate(1.0) and rotate(2.0)
 * is equivalent to calling rotate(3.0). 
 */
/*
float a = 0.0;
float rSize;  // rectangle size

void setup() {
    size(640, 360, P3D);
    rSize = width / 6;  
    noStroke();
    fill(204, 204);
}

void draw() {
    background(0);
    
    a += 0.005;
    if(a > TWO_PI) { 
        a = 0.0; 
    }
    
    translate(width/2, height/2);
    
    rotateX(a);
    rotateY(a * 2.0);
    rect(-rSize, -rSize, rSize*2, rSize*2);
    
    rotateX(a * 1.001);
    rotateY(a * 2.002);
    rect(-rSize, -rSize, rSize*2, rSize*2);
    
}
*/
//
//  Rotate1.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-08.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Rotate1.h"


@implementation Rotate1

- (void)setup
{
    [self size:320 :320 :P3D];
    rSize = self.width / 6;  
    [self noStroke];
    [self fill:204 :204];
}

- (void)draw
{
    [self background:[self color:0]];
    
    a += 0.005;
    if(a > TWO_PI) { 
        a = 0.0; 
    }
    
    [self translate:self.width/2 :self.height/2];
    
    [self rotateX:a];
    [self rotateY:a * 2.0];
    [self rect:-rSize :-rSize :rSize*2 :rSize*2];
    
    [self rotateX:a * 1.001];
    [self rotateY:a * 2.002];
    [self rect:-rSize :-rSize :rSize*2 :rSize*2];
    
}
@end
