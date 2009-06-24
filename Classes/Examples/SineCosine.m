/**
 * Sine Cosine. 
 * 
 * Linear movement with sin() and cos(). 
 * Numbers between 0 and PI*2 (TWO_PI which is roughly 6.28) 
 * are put into these functions and numbers between -1 and 1 are 
 * returned. These values are then scaled to produce larger movements. 
 */
/*
int i = 45;
int j = 225; 
float pos1 = 0; 
float pos2 = 0; 
float pos3 = 0; 
float pos4 = 0;
int sc = 40;

void setup() 
{
    size(200, 200);
    noStroke();
    smooth();
}

void draw() 
{
    background(0);
    
    fill(51);
    rect(60, 60, 80, 80);
    
    fill(255);
    ellipse(pos1, 36, 32, 32);
    
    fill(153);
    ellipse(36, pos2, 32, 32);
    
    fill(255);
    ellipse(pos3, 164, 32, 32);
    
    fill(153);
    ellipse(164, pos4, 32, 32);
    
    i += 3;
    j -= 3;
    
    if(i > 405) {
        i = 45;
        j = 225;
    }
    
    float ang1 = radians(i); // convert degrees to radians
    float ang2 = radians(j); // convert degrees to radians
    pos1 = width/2 + (sc * cos(ang1));
    pos2 = width/2 + (sc * sin(ang1));
    pos3 = width/2 + (sc * cos(ang2));
    pos4 = width/2 + (sc * sin(ang2));
}
*/
//
//  SineCosine.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import "SineCosine.h"

static int sc = 40;

@implementation SineCosine

- (void)setup
{
    [self size:200 :200];
    [self noStroke];
    [self smooth];
    i = 45;
    j = 225;
}

- (void)draw
{
    [self background:0];
    
    [self fill:51];
    [self rect:60 :60 :80 :80];
    
    [self fill:255];
    [self ellipse:pos1 :36 :32 :32];
    
    [self fill:153];
    [self ellipse:36 :pos2 :32 :32];
    
    [self fill:255];
    [self ellipse:pos3 :164 :32 :32];
    
    [self fill:153];
    [self ellipse:164 :pos4 :32 :32];
    
    i += 3;
    j -= 3;
    
    if(i > 405) {
        i = 45;
        j = 225;
    }
    
    float ang1 = [self radians:i]; // convert degrees to radians
    float ang2 = [self radians:j]; // convert degrees to radians
    pos1 = [self width]/2 + (sc * [self cos:ang1]);
    pos2 = [self width]/2 + (sc * [self sin:ang1]);
    pos3 = [self width]/2 + (sc * [self cos:ang2]);
    pos4 = [self width]/2 + (sc * [self sin:ang2]);    
}

@end
