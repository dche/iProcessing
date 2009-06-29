/*
int num = 20;
float c;

void setup()
{
    size(200,200);
    fill(255);
    frameRate(30);
}

void draw() 
{ 
    background(0);
    c+=0.1;
    for(int i=1; i<height/num; i++) { 
        float x = (c%i)*i*i;
        stroke(102);
        line(0, i*num, x, i*num);
        noStroke();
        rect(x, i*num-num/2, 8, num);
    } 
} 
*/

//
//  Modulo.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-23.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Modulo.h"

static const int num = 20;

@implementation Modulo

- (void)setup
{
    [self size:200 :200];
    [self fill:255 :255];
    [self frameRate:30];
}

- (void)draw
{
    [self background:[self color:0]];
    c+=0.1;
    for(int i=1; i<[self height]/num; i++) { 
        float x = fmodf(c, i)*i*i;
        [self stroke:[self color:102]];
        [self line:0 :i*num :x :i*num];
        [self noStroke];
        [self rect:x :i*num-num/2 :8 :num];
    }     
}

@end
