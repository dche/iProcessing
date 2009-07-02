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

- (void)setup
{
    a = [self loadImage:@"dche.jpg"];
    [a retain];
    [self size:200 :150];
    [self noStroke];
    [self background:[self color:255]];
    [self smooth];
}

- (void)draw
{ 
    float pointillize = [self map:[self mouseX] :0 :[self width] :2 :18];
    int x = (int)[self random:a.width];
    int y = (int)[self random:a.height];
    color pix = [a get:x :y];
    [self fill:[self red:pix] :[self green:pix] :[self blue:pix] :126];
    [self ellipse:x :y :pointillize :pointillize];
}

- (void)dealloc
{
    [a release];
    [super dealloc];
}

@end
