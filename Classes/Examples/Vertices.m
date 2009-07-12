/**
 * Vertices. 
 * 
 * The beginShape() function begins recording vertices 
 * for a shape and endShape() stops recording. 
 * A vertex is a location in space specified by X, Y, 
 * and sometimes Z coordinates. After calling the beginShape() function, 
 * a series of vertex() functions must follow.  
 * To stop drawing the shape, call the endShape() functions.
 */
/*
size(200, 200);
background(0);
noFill();

stroke(102);
beginShape();
curveVertex(168, 182);
curveVertex(168, 182);
curveVertex(136, 38);
curveVertex(42, 34);
curveVertex(64, 200);
curveVertex(64, 200);
endShape();

stroke(51);
beginShape(LINES);
vertex(60, 40);
vertex(160, 10);
vertex(170, 150);
vertex(60, 150);
endShape();

stroke(126);
beginShape();
vertex(60, 40);
bezierVertex(160, 10, 170, 150, 60, 150);
endShape();

stroke(255);
beginShape(POINTS);
vertex(60, 40);
vertex(160, 10);
vertex(170, 150);
vertex(60, 150);
endShape();
*/
//
//  Vertices.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-27.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Vertices.h"


@implementation Vertices

- (void)setup
{
    [self size:200 :200];
    [self background:[self color:0]];
    [self noFill];
    
    [self stroke:[self color:102]];
    [self beginShape];
    [self curveVertex:168 :182];
    [self curveVertex:168 :182];
    [self curveVertex:136 :38];
    [self curveVertex:42 :34];
    [self curveVertex:64 :200];
    [self curveVertex:64 :200];
    [self endShape];
    
    [self stroke:[self color:51]];
    [self beginShape:LINES];
    [self vertex:60 :40];
    [self vertex:160 :10];
    [self vertex:170 :150];
    [self vertex:60 :150];
    [self endShape];
    
    [self stroke:[self color:126]];
    [self beginShape];
    [self vertex:60 :40];
    [self bezierVertex:160 :10 :170 :150 :60 :150];
    [self endShape];
    
    [self stroke:[self color:255]];
    [self beginShape:POINTS];
    [self vertex:60 :40];
    [self vertex:160 :10];
    [self vertex:170 :150];
    [self vertex:60 :150];
    [self endShape];
}

@end
