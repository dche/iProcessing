/**
 * Simple Curves. 
 * 
 * Simple curves are drawn with simple equations. 
 * By using numbers with values between 0 and 1 in
 * the equations, a series of elegant curves
 * are created. The numbers are then scaled to fill the screen. 
 */
/*
void setup() {
    size(200, 200);
    colorMode(RGB, 100);
    background(0);
    noFill();
    noLoop();
}

void draw() {
    stroke(40);
    beginShape();
    for(int i=0; i<width; i++) {
        vertex(i, singraph((float)i/width)*height);
    }
    endShape();
    
    stroke(55);
    beginShape();
    for(int i=0; i<width; i++) {
        vertex(i, quad((float)i/width)*height);
    }
    endShape();
    
    stroke(70);
    beginShape();
    for(int i=0; i<width; i++) {
        vertex(i, quadHump((float)i/width)*height);
    }
    endShape();
    
    stroke(85);
    beginShape();
    for(int i=0; i<width; i++) {
        vertex(i, hump((float)i/width)*height);
    }
    endShape();
    
    stroke(100);
    beginShape();
    for(int i=0; i<width; i++) {
        vertex(i, squared((float)i/width)*height);
    }
    endShape();
}

float singraph(float sa) {
    sa = (sa - 0.5) * 1.0; //scale from -1 to 1
    sa = sin(sa*PI)/2 + 0.5;
    return sa;
}

float quad(float sa) {
    return sa*sa*sa*sa;
}

float quadHump(float sa) {
    sa = (sa - 0.5); //scale from -2 to 2
    sa = sa*sa*sa*sa * 16;
    return sa;
}

float hump(float sa) {
    sa = (sa - 0.5) * 2; //scale from -2 to 2
    sa = sa*sa;
    if(sa > 1) { sa = 1; }
    return 1-sa;
}

float squared(float sa) {
    sa = sa*sa;
    return sa;
}
*/
//
//  SimpleCurve.m
//  iProcessing
//
//  Created by Kenan Che on 09-08-07.
//  Copyright 2009 campl software. All rights reserved.
//

#import "SimpleCurve.h"

static float singraph(float sa) {
    sa = (sa - 0.5f) * 1.0f; //scale from -1 to 1
    sa = sinf(sa*PI)/2.0f + 0.5f;
    return sa;
}

static float quad(float sa) {
    return sa*sa*sa*sa;
}

static float quadHump(float sa) {
    sa = (sa - 0.5f); //scale from -2 to 2
    sa = sa*sa*sa*sa * 16;
    return sa;
}

static float hump(float sa) {
    sa = (sa - 0.5f) * 2; //scale from -2 to 2
    sa = sa*sa;
    if(sa > 1) { sa = 1; }
    return 1-sa;
}

static float squared(float sa) {
    sa = sa*sa;
    return sa;
}

@implementation SimpleCurve

- (void)setup
{
    [self size:200 :200];
    [self colorMode:RGB :100];
    [self background:PBlackColor];
    [self noFill];
    [self noLoop];
    [self strokeWeight:20];
}

- (void)draw
{
    [self stroke:[self color:40]];
    [self beginShape];
    for(int i=0; i<self.width; i++) {
        [self vertex:i :singraph(i/self.width)*self.height];
    }
    [self endShape];
    
    [self stroke:[self color:55]];
    [self beginShape];
    for(int i=0; i<self.width; i++) {
        [self vertex:i :quad(i/self.width)*self.height];
    }
    [self endShape];
    
    [self stroke:[self color:70]];
    [self beginShape];
    for(int i=0; i<self.width; i++) {
        [self vertex:i :quadHump(i/self.width)*self.height];
    }
    [self endShape];
    
    [self stroke:[self color:85]];
    [self beginShape];
    for(int i=0; i<self.width; i++) {
        [self vertex:i :hump(i/self.width)*self.height];
    }
    [self endShape];
    
    [self stroke:[self color:100]];
    [self beginShape];
    for(int i=0; i<self.width; i++) {
        [self vertex:i :squared(i/self.width)*self.height];
    }
    [self endShape];
}


@end
