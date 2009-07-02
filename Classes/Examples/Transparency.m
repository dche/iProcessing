/**
 * Transparency. 
 * 
 * Move the pointer left and right across the image to change
 * its position. This program overlays one image over another 
 * by modifying the alpha value of the image with the tint() function. 
 */
/*
PImage a, b;
float offset;

void setup() {
    size(200, 200);
    a = loadImage("construct.jpg");  // Load an image into the program 
    b = loadImage("wash.jpg");   // Load an image into the program 
    frameRate(60);
}

void draw() { 
    image(a, 0, 0);
    float offsetTarget = map(mouseX, 0, width, -b.width/2 - width/2, 0);
    offset += (offsetTarget-offset)*0.05; 
    tint(255, 153);
    image(b, offset, 20);
}
*/
//
//  Transparency.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-01.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Transparency.h"


@implementation Transparency
- (void)setup
{
    [self size:200 :200];
    a = [self loadImage:@"construct.jpg"];  // Load an image into the program 
    [a retain];
    b = [self loadImage:@"wash.jpg"];   // Load an image into the program 
    [b retain];
    [self frameRate:60];
}

- (void)draw
{ 
    [self image:a :0 :0];
    float offsetTarget = [self map:[self mouseX] :0 :[self width] :-b.width/2 - [self width]/2 :0];
    offset += (offsetTarget-offset)*0.05; 
    [self tint:255 :153];
    [self image:b :offset :20];
    [self noTint];
}

- (void)dealloc
{
    [a release];
    [b release];
    [super dealloc];
}
@end
