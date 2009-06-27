/**
 * TRIANGLE_STRIP Mode
 * by Ira Greenberg. 
 * 
 * Generate a closed ring using vertex() 
 * function and beginShape(TRIANGLE_STRIP)
 * mode. outerRad and innerRad variables 
 * control ring's outer/inner radii respectively.
 * Trig functions generate ring.
 */
/*
size(200, 200);
background(204);
smooth();

int x = width/2;
int y = height/2;
int outerRad = 80;
int innerRad = 50;
float px = 0, py = 0, angle = 0;
float pts = 36;
float rot = 360.0/pts;

beginShape(TRIANGLE_STRIP); 
for (int i = 0; i < pts; i++) {
    px = x + cos(radians(angle))*outerRad;
    py = y + sin(radians(angle))*outerRad;
    angle += rot;
    vertex(px, py);
    px = x + cos(radians(angle))*innerRad;
    py = y + sin(radians(angle))*innerRad;
    vertex(px, py); 
    angle += rot;
}
endShape();
*/
//
//  TriangleStrip.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-28.
//  Copyright 2009 campl software. All rights reserved.
//

#import "TriangleStrip.h"


@implementation TriangleStrip

- (void)setup
{
    [self size:200 :200];
    [self background:204];
    [self smooth];
    [self noLoop];
    
    int x = [self width]/2;
    int y = [self height]/2;
    int outerRad = 80;
    int innerRad = 50;
    float px = 0, py = 0, angle = 0;
    float pts = 36;
    float rot = 360.0/pts;
    
    [self beginShape:TRIANGLE_STRIP]; 
    for (int i = 0; i < pts; i++) {
        px = x + [self cos:[self radians:angle]]*outerRad;
        py = y + [self sin:[self radians:angle]]*outerRad;
        angle += rot;
        [self vertex:px :py];
        px = x + [self cos:[self radians:angle]]*innerRad;
        py = y + [self sin:[self radians:angle]]*innerRad;
        [self vertex:px :py]; 
        angle += rot;
    }
    [self endShape];
}

@end
