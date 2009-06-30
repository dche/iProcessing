
/**
 * Alpha Mask. 
 * 
 * Loads a "mask" for an image to specify the transparency 
 * in different parts of the image. The two images are blended
 * together using the mask() method of PImage. 
 */
/*
PImage img;
PImage maskImg;

void setup() 
{
    size(200,200);
    img = loadImage("test.jpg");
    maskImg = loadImage("mask.jpg");
    img.mask(maskImg);
}

void draw() 
{
    background((mouseX+mouseY)/1.5);
    image(img, 50, 50);
    image(img, mouseX-50, mouseY-50);
}
*/
//
//  AlphaMask.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-30.
//  Copyright 2009 campl software. All rights reserved.
//

#import "AlphaMask.h"


@implementation AlphaMask
- (void)setup 
{
    [self size:200 :200];
    img = [self loadImage:@"test.jpg"];
    maskImg = [self loadImage:@"mask.jpg"];
    [img mask:maskImg];
}

- (void)draw 
{
    [self background:([self mouseX]+[self mouseY])/1.5];
    [self image:img :50 :50];
    [self image:img :[self mouseX]-50 :[self mouseY]-50];
}

@end
