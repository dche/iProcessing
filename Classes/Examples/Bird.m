/**
 * Simple 3D Bird 
 * by Ira Greenberg.  
 * 
 * Using a box and 2 rects to simulate a flying bird. 
 * Trig functions handle the flapping and sinuous movement.
 */
/*
float ang = 0, ang2 = 0, ang3 = 0, ang4 = 0;
float px = 0, py = 0, pz = 0;
float flapSpeed = 0.2;

void setup(){
    size(640, 360, P3D);
    noStroke();
}

void draw(){
    background(0);
    lights();
    
    // Flight
    px = sin(radians(ang3)) * 170;
    py = cos(radians(ang3)) * 300;
    pz = sin(radians(ang4)) * 500;
    translate(width/2 + px, height/2 + py, -700+pz);
    rotateX(sin(radians(ang2)) * 120);
    rotateY(sin(radians(ang2)) * 50);
    rotateZ(sin(radians(ang2)) * 65);
    
    // Body
    fill(153);
    box(20, 100, 20);
    
    
    // Left wing
    fill(204);
    pushMatrix();
    rotateY(sin(radians(ang)) * -20);
    rect(-75, -50, 75, 100);
    popMatrix();
    
    // Right wing
    pushMatrix();
    rotateY(sin(radians(ang)) * 20);
    rect(0, -50, 75, 100);
    popMatrix();
    
    // Wing flap
    ang += flapSpeed;
    if (ang > 3) {
        flapSpeed *= -1;
    } 
    if (ang < -3) {
        flapSpeed *= -1;
    }
    
    // Increment angles
    ang2 += 0.01;
    ang3 += 2.0;
    ang4 += 0.75;
}
*/
//
//  Bird.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-21.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Bird.h"

static float flapSpeed = 0.2;

@implementation Bird

- (void)setup
{
    [self size:320 :320 :P3D];
    [self noStroke];
    [self scale:320.0f/640.0f];
}

- (void)draw
{
    [self background:PBlackColor];
    [self lights];
    
    // Flight
    px = [self sin:[self radians:ang3]] * 170;
    py = [self cos:[self radians:ang3]] * 300;
    pz = [self sin:[self radians:ang4]] * 500;
    [self translate:self.width/2 + px :self.height/2 + py :-700+pz];
    [self rotateX:[self sin:[self radians:ang2]] * 120];
    [self rotateY:[self sin:[self radians:ang2]] * 50];
    [self rotateZ:[self sin:[self radians:ang2]] * 65];
    
    // Body
    [self fill:[self color:153]];
    [self box:20 :100 :20];
    
    
    // Left wing
    [self fill:[self color:204]];
    [self pushMatrix];
    [self rotateY:[self sin:[self radians:ang]] * -20];
    [self rect:-75 :-50 :75 :100];
    [self popMatrix];
    
    // Right wing
    [self pushMatrix];
    [self rotateY:[self sin:[self radians:ang]] * 20];
    [self rect:0 :-50 :75 :100];
    [self popMatrix];
    
    // Wing flap
    ang += flapSpeed;
    if (ang > 3) {
        flapSpeed *= -1;
    } 
    if (ang < -3) {
        flapSpeed *= -1;
    }
    
    // Increment angles
    ang2 += 0.01;
    ang3 += 2.0;
    ang4 += 0.75;
}

@end
