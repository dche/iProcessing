/**
 * Pointillism
 * by Daniel Shiffman. 
 * 
 * Mouse horizontal location controls size of dots. 
 * Creates a simple pointillist effect using ellipses colored
 * according to pixels in an image. 
 */
/*
PImage a;

void setup()
{
    a = loadImage("eames.jpg");
    size(200,200);
    noStroke();
    background(255);
    smooth();
}

void draw()
{ 
    float pointillize = map(mouseX, 0, width, 2, 18);
    int x = int(random(a.width));
    int y = int(random(a.height));
    color pix = a.get(x, y);
    fill(pix, 126);
    ellipse(x, y, pointillize, pointillize);
}
*/
//
//  Pointillism.m
//  iProcessing
//
//  Translated by Diego Che on 09-06-30.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Pointillism.h"


@implementation Pointillism

@end
