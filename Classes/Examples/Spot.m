/**
 * Spot. 
 * 
 * Move the mouse the change the position and concentation
 * of a blue spot light. 
 */
/*
int concentration = 600; // Try values 1 -> 10000

void setup() 
{
    //size(200, 200, P3D);
    size(640, 360, P3D);
    noStroke();
    fill(204);
    sphereDetail(60);
}

void draw() 
{
    background(0); 
    
    // Light the bottom of the sphere
    directionalLight(51, 102, 126, 0, -1, 0);
    
    // Orange light on the upper-right of the sphere
    spotLight(204, 153, 0, 360, 160, 600, 0, 0, -1, PI/2, 600); 
    
    // Moving spotlight that follows the mouse
    spotLight(102, 153, 204, 360, mouseY, 600, 0, 0, -1, PI/2, 600); 
    
    translate(width/2, height/2, 0); 
    sphere(120); 
}
*/
//
//  Spot.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-14.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Spot.h"

static const int concentration = 600;

@implementation Spot

- (void)setup 
{
    //size(200, 200, P3D);
    [self size:320 :320 :P3D];
    [self noStroke];
    [self fill:[self color:204]];
    [self sphereDetail:60];
}

- (void)draw 
{
    [self background:PBlackColor]; 
    
    // Light the bottom of the sphere
    [self directionalLight:51 :102 :126 :0 :-1 :0];
    
    // Orange light on the upper-right of the sphere
    [self spotLight:204 :153 :0 :360 :160 :600 :0 :0 :-1 :PI/2 :128]; 
    
    // Moving spotlight that follows the mouse
    [self spotLight:102 :153 :204 :360 :self.mouseY :600 :0 :0 :-1 :PI/2 :128]; 
    
    [self translate:self.width/2 :self.height/2 :0]; 
    [self sphere:120]; 
}

@end
