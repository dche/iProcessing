/**
 * Mouse 2D. 
 * 
 * Moving the mouse changes the position and size of each box. 
 */
/*
void setup() 
{
    size(200, 200); 
    noStroke();
    colorMode(RGB, 255, 255, 255, 100);
    rectMode(CENTER);
}

void draw() 
{   
    background(51); 
    fill(255, 80);
    rect(mouseX, height/2, mouseY/2+10, mouseY/2+10);
    fill(255, 80);
    int inverseX = width-mouseX;
    int inverseY = height-mouseY;
    rect(inverseX, height/2, (inverseY/2)+10, (inverseY/2)+10);
}
*/
//
//  Mouse2D.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Mouse2D.h"


@implementation Mouse2D

- (void)setup 
{
    [self size:200 :200]; 
    [self noStroke];
    [self colorMode:RGB :255 :255 :255 :100];
    [self rectMode:CENTER];
}

- (void)draw 
{   
    [self background:[self color:51]]; 
    [self fill:255 :80];
    [self rect:[self mouseX] :[self height]/2.0f :[self mouseY]/2.0f+10 :[self mouseY]/2.0f+10];
    [self fill:255 :80];
    int inverseX = [self width]-[self mouseX];
    int inverseY = [self height]-[self mouseY];
    [self rect:inverseX :[self height]/2.0f :(inverseY/2.0f)+10 :(inverseY/2.0f)+10];
}

@end
