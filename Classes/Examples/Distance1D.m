/**
 * Distance 1D. 
 * 
 * Move the mouse left and right to control the 
 * speed and direction of the moving shapes. 
 */
/*
int thin = 8;
int thick = 36;
float xpos1 = 134.0;
float xpos2 = 44.0;
float xpos3 = 58.0;
float xpos4 = 120.0;

void setup() 
{
    size(200, 200);
    noStroke();
    frameRate(60);
}

void draw() 
{
    background(0);
    
    float mx = mouseX * 0.4 - width/5.0;
    
    fill(102);
    rect(xpos2, 0, thick, height/2);
    fill(204);
    rect(xpos1, 0, thin, height/2);
    fill(102);
    rect(xpos4, height/2, thick, height/2);
    fill(204);
    rect(xpos3, height/2, thin, height/2);
	
    xpos1 += mx/16;
    xpos2 += mx/64;
    xpos3 -= mx/16;
    xpos4 -= mx/64;
    
    if(xpos1 < -thin)  { xpos1 =  width; }
    if(xpos1 >  width) { xpos1 = -thin; }
    if(xpos2 < -thick) { xpos2 =  width; }
    if(xpos2 >  width) { xpos2 = -thick; }
    if(xpos3 < -thin)  { xpos3 =  width; }
    if(xpos3 >  width) { xpos3 = -thin; }
    if(xpos4 < -thick) { xpos4 =  width; }
    if(xpos4 >  width) { xpos4 = -thick; }
}
*/
//
//  Distance1D.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Distance1D.h"

static int thin = 8;
static int thick = 36;

@implementation Distance1D

- (void)setup
{
    [self size:200 :200];
    [self noStroke];
    [self frameRate:60]; 
    xpos1 = 134.0;
    xpos2 = 44.0;
    xpos3 = 58.0;
    xpos4 = 120.0;
}

- (void)draw
{
    [self background:0];
    
    float mx = [self mouseX] * 0.4 - [self width]/5.0;
    
    [self fill:102];
    [self rect:xpos2 :0 :thick :[self height]/2];
    [self fill:204];
    [self rect:xpos1 :0 :thin :[self height]/2];
    [self fill:102];
    [self rect:xpos4 :[self height]/2 :thick :[self height]/2];
    [self fill:204];
    [self rect:xpos3 :[self height]/2 :thin :[self height]/2];
	
    xpos1 += mx/16;
    xpos2 += mx/64;
    xpos3 -= mx/16;
    xpos4 -= mx/64;
    
    if(xpos1 < -thin)  { xpos1 =  [self width]; }
    if(xpos1 >  [self width]) { xpos1 = -thin; }
    if(xpos2 < -thick) { xpos2 =  [self width]; }
    if(xpos2 >  [self width]) { xpos2 = -thick; }
    if(xpos3 < -thin)  { xpos3 =  [self width]; }
    if(xpos3 >  [self width]) { xpos3 = -thin; }
    if(xpos4 < -thick) { xpos4 =  [self width]; }
    if(xpos4 >  [self width]) { xpos4 = -thick; }
}

@end
