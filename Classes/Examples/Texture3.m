/**
 * Texture 3. 
 * 
 * Load an image and draw it onto a cylinder and a quad. 
 */
/*

int tubeRes = 32;
float[] tubeX = new float[tubeRes];
float[] tubeY = new float[tubeRes];
PImage img;

void setup() {
    size(640, 360, P3D);
    img = loadImage("berlin-1.jpg");
    float angle = 270.0 / tubeRes;
    for (int i = 0; i < tubeRes; i++) {
        tubeX[i] = cos(radians(i * angle));
        tubeY[i] = sin(radians(i * angle));
    }
    noStroke();
}

void draw() {
    background(0);
    translate(width / 2, height / 2);
    rotateX(map(mouseY, 0, height, -PI, PI));
    rotateY(map(mouseX, 0, width, -PI, PI));
    beginShape(QUAD_STRIP);
    texture(img);
    for (int i = 0; i < tubeRes; i++) {
        float x = tubeX[i] * 100;
        float z = tubeY[i] * 100;
        float u = img.width / tubeRes * i;
        vertex(x, -100, z, u, 0);
        vertex(x, 100, z, u, img.height);
    }
    endShape();
    beginShape(QUADS);
    texture(img);
    vertex(0, -100, 0, 0, 0);
    vertex(100, -100, 0, 100, 0);
    vertex(100, 100, 0, 100, 100);
    vertex(0, 100, 0, 0, 100);
    endShape();
}
*/
//
//  Texture3.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-15.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Texture3.h"

static const int tubeRes = 32;

@implementation Texture3

- (void)setup
{
    [self size:320 :320 :P3D];
    img = [[self loadImage:@"berlin-1.jpg"] retain];
    
    float angle = 270.0f / tubeRes;
    tubeX = (float *)malloc(tubeRes * sizeof(float));
    tubeY = (float *)malloc(tubeRes * sizeof(float));
    
    for (int i = 0; i < tubeRes; i++) {
        tubeX[i] = [self cos:[self radians:i * angle]];
        tubeY[i] = [self sin:[self radians:i * angle]];
    }
    [self noStroke];
}

- (void)draw
{
    [self background:PBlackColor];
    [self translate:self.width / 2 :self.height / 2];
    [self rotateX:[self map:self.mouseY :0 :self.height :-PI :PI]];
    [self rotateY:[self map:self.mouseX :0 :self.width :-PI :PI]];
    [self beginShape:QUAD_STRIP];
    [self texture:img];
    for (int i = 0; i < tubeRes; i++) {
        float x = tubeX[i] * 100;
        float z = tubeY[i] * 100;
        float u = img.width / tubeRes * i;
        [self vertex:x :-100 :z :u :0];
        [self vertex:x :100 :z :u :img.height];
    }
    [self endShape];
    [self beginShape:QUADS];
    [self texture:img];
    [self vertex:0 :-100 :0 :0 :0];
    [self vertex:100 :-100 :0 :100 :0];
    [self vertex:100 :100 :0 :100 :100];
    [self vertex:0 :100 :0 :0 :100];
    [self endShape];
}

@end
