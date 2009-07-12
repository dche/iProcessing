/**
 * Shape Primitives. 
 * 
 * The basic shape primitive functions are triangle(),
 * rect(), quad(), and ellipse(). Squares are made
 * with rect() and circles are made with
 * ellipse(). Each of these functions requires a number
 * of parameters to determine the shape's position and size. 
 */
/*
size(200, 200);
smooth(); 
background(0);
noStroke();
fill(226);
triangle(10, 10, 10, 200, 45, 200);
rect(45, 45, 35, 35);
quad(105, 10, 120, 10, 120, 200, 80, 200);
ellipse(140, 80, 40, 40);
triangle(160, 10, 195, 200, 160, 200); 
*/
//
//  ShapePrimitives.m
//  iProcessing
//
//  Translated by Diego Che on 09-06-27.
//  Copyright 2009 campl software. All rights reserved.
//

#import "ShapePrimitives.h"


@implementation ShapePrimitives

- (void)setup
{
    [self size:200 :200];
    [self smooth];
    [self background:[self color:0]];
    [self noStroke];
    [self fill:[self color:226]];
    [self triangle:10 :10 :10 :200 :45 :200];
    [self rect:45 :45 :35 :35];
    [self fill:[self color:226]];
    [self quad:105 :10 :120 :10 :120 :200 :80 :200];
    [self ellipse:140 :80 :40 :40];
    [self triangle:160 :10 :195 :200 :160 :200];     
}

@end
