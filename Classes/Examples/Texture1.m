/**
 * Texture 1. 
 * 
 * Load an image and draw it onto a quad. The texture() function sets
 * the texture image. The vertex() function maps the image to the geometry.
 */
/*
PImage img;

void setup() {
    size(640, 360, P3D);
    img = loadImage("berlin-1.jpg");
    noStroke();
}

void draw() {
    background(0);
    translate(width / 2, height / 2);
    rotateY(map(mouseX, 0, width, -PI, PI));
    rotateZ(PI/6);
    beginShape();
    texture(img);
    vertex(-100, -100, 0, 0, 0);
    vertex(100, -100, 0, 400, 0);
    vertex(100, 100, 0, 400, 400);
    vertex(-100, 100, 0, 0, 400);
    endShape();
}
*/
//
//  Texture1.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-15.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Texture1.h"


@implementation Texture1

- (void)setup
{
    [self size:320 :320 :P3D];
    img = [self loadImage:@"berlin-1.jpg"];
    [img retain];
    [self noStroke];
}

- (void)draw
{
    [self background:PBlackColor];
    [self translate:self.width / 2 :self.height / 2];
    [self rotateY:[self map:self.mouseX :0 :self.width :-PI :PI]];
    [self rotateZ:PI/6.0f];
    [self beginShape:QUADS];
    [self texture:img];
    [self vertex:-100 :-100 :0 :0 :0];
    [self vertex:100 :-100 :0 :400 :0];
    [self vertex:100 :100 :0 :400 :400];
    [self vertex:-100 :100 :0 :0 :400];
    [self endShape];
}

- (void)dealloc
{
    [img release];
    [super dealloc];
}

@end
