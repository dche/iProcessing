/**
 * Primitives 3D. 
 * 
 * Placing mathematically 3D objects in synthetic space.
 * The lights() method reveals their imagined dimension.
 * The box() and sphere() functions each have one parameter
 * which is used to specify their size. These shapes are
 * positioned using the translate() function.
 */
/*
size(640, 360, P3D); 
background(0);
lights();

noStroke();
pushMatrix();
translate(130, height/2, 0);
rotateY(1.25);
rotateX(-0.4);
box(100);
popMatrix();

noFill();
stroke(255);
pushMatrix();
translate(500, height*0.35, -200);
sphere(280);
popMatrix();

*/
//
//  Premitives3D.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-15.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Premitives3D.h"


@implementation Premitives3D

- (void)setup
{
    [self size:320 :320 :P3D]; 
    [self background:0];
    [self lights];
    
    [self noStroke];
    [self pushMatrix];
    [self translate:50 :self.height/2 :0];
    [self rotateY:1.25];
    [self rotateX:-0.4];
    [self box:100];
    [self popMatrix];
    
    [self noFill];
    [self stroke:[self color:255]];
    [self pushMatrix];
    [self translate:300 :self.height*0.35 :-200];
    [self sphere:180];
    [self popMatrix];
}

@end
