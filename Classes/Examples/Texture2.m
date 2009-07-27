/**
 * Texture 2. 
 * 
 * Using a rectangular image to map a texture onto a triangle.
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
    beginShape();
    texture(img);
    vertex(-100, -100, 0, 0, 0);
    vertex(100, -40, 0, 400, 120);
    vertex(0, 100, 0, 200, 400);
    endShape();
}
*/
//
//  Texture2.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-15.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Texture2.h"


@implementation Texture2

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
    [self translate:self.width / 2.0f :self.height / 2.0f];
    [self rotateY:[self map:self.mouseX :0 :self.width :-PI :PI]];
    [self beginShape:TRIANGLES];
    [self texture:img];
    [self vertex:-100 :-100 :0 :0 :0];
    [self vertex:100 :-40 :0 :400 :120];
    [self vertex:0 :100 :0 :200 :400];
    [self endShape];
}

- (void)dealloc
{
    [img release];
    [super dealloc];
}

@end
