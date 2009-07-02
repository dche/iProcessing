/**
 * Create Image. 
 * 
 * The createImage() function provides a fresh buffer of pixels to play with.
 * This example creates an image gradient.
 */
/*
PImage img;

void setup() 
{
    size(200, 200);  
    img = createImage(120, 120, ARGB);
    for(int i=0; i < img.pixels.length; i++) {
        img.pixels[i] = color(0, 90, 102, i%img.width * 2); 
    }
}

void draw() 
{
    background(204);
    image(img, 33, 33);
    image(img, mouseX-60, mouseY-60);
}
*/
//
//  CreateImage.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-01.
//  Copyright 2009 campl software. All rights reserved.
//

#import "CreateImage.h"


@implementation CreateImage
- (void)setup 
{
    [self size:200 :200];  
    img = [self createImage:120 :120 :ARGB];
    [img retain];
    [img loadPixels];
    for(int i=0; i < img.width * img.height; i++) {
        img.pixels[i] = [self color:0 :90 :102 :i%img.width * 2]; 
    }
    [img updatePixels];
}

- (void)draw 
{
    [self background:[self color:204]];
    [self image:img :33 :33];
    [self image:img :[self mouseX]-60 :[self mouseY]-60];
}

- (void)dealloc
{
    [img release];
    [super dealloc];
}

@end
