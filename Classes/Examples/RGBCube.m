/**
 * RGB Cube.
 * 
 * The three primary colors of the additive color model are red, green, and blue.
 * This RGB color cube displays smooth transitions between these colors. 
 */
/*
float xmag, ymag = 0;
float newXmag, newYmag = 0; 

void setup() 
{ 
    size(640, 360, P3D); 
    noStroke(); 
    colorMode(RGB, 1); 
} 

void draw() 
{ 
    background(0.5);
    
    pushMatrix(); 
    
    translate(width/2, height/2, -30); 
    
    newXmag = mouseX/float(width) * TWO_PI;
    newYmag = mouseY/float(height) * TWO_PI;
    
    float diff = xmag-newXmag;
    if (abs(diff) >  0.01) { xmag -= diff/4.0; }
    
    diff = ymag-newYmag;
    if (abs(diff) >  0.01) { ymag -= diff/4.0; }
    
    rotateX(-ymag); 
    rotateY(-xmag); 
    
    scale(90);
    beginShape(QUADS);
    
    fill(0, 1, 1); vertex(-1,  1,  1);
    fill(1, 1, 1); vertex( 1,  1,  1);
    fill(1, 0, 1); vertex( 1, -1,  1);
    fill(0, 0, 1); vertex(-1, -1,  1);
    
    fill(1, 1, 1); vertex( 1,  1,  1);
    fill(1, 1, 0); vertex( 1,  1, -1);
    fill(1, 0, 0); vertex( 1, -1, -1);
    fill(1, 0, 1); vertex( 1, -1,  1);
    
    fill(1, 1, 0); vertex( 1,  1, -1);
    fill(0, 1, 0); vertex(-1,  1, -1);
    fill(0, 0, 0); vertex(-1, -1, -1);
    fill(1, 0, 0); vertex( 1, -1, -1);
    
    fill(0, 1, 0); vertex(-1,  1, -1);
    fill(0, 1, 1); vertex(-1,  1,  1);
    fill(0, 0, 1); vertex(-1, -1,  1);
    fill(0, 0, 0); vertex(-1, -1, -1);
    
    fill(0, 1, 0); vertex(-1,  1, -1);
    fill(1, 1, 0); vertex( 1,  1, -1);
    fill(1, 1, 1); vertex( 1,  1,  1);
    fill(0, 1, 1); vertex(-1,  1,  1);
    
    fill(0, 0, 0); vertex(-1, -1, -1);
    fill(1, 0, 0); vertex( 1, -1, -1);
    fill(1, 0, 1); vertex( 1, -1,  1);
    fill(0, 0, 1); vertex(-1, -1,  1);
    
    endShape();
    
    popMatrix(); 
} 
*/
//
//  RGBCube.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-08.
//  Copyright 2009 campl software. All rights reserved.
//

#import "RGBCube.h"


@implementation RGBCube

- (void)setup 
{ 
    [self size:320 :320 :P3D]; 
    [self noStroke]; 
    [self colorMode:RGB :1]; 
} 

- (void)draw 
{ 
    [self background:[self color:0.5]];
    
    [self pushMatrix]; 
    
    [self translate:self.width/2 :self.height/2 :-30]; 
    
    newXmag = [self mouseX]/(float)(self.width) * TWO_PI;
    newYmag = [self mouseY]/(float)(self.height) * TWO_PI;
    
    float diff = xmag-newXmag;
    if ([self abs:diff] >  0.01) { xmag -= diff/4.0; }
    
    diff = ymag-newYmag;
    if ([self abs:diff] >  0.01) { ymag -= diff/4.0; }
    
    [self rotateX:-ymag]; 
    [self rotateY:-xmag]; 
    
    [self scale:90];
    [self beginShape:QUADS];
    
    [self fill:[self color:0:1:1]]; [self vertex:-1:1:1];
    [self fill:[self color:1:1:1]]; [self vertex:1:1:1];
    [self fill:[self color:1:0:1]]; [self vertex:1:-1:1];
    [self fill:[self color:0:0:1]]; [self vertex:-1:-1:1];
    
    [self fill:[self color:1:1:1]]; [self vertex:1:1:1];
    [self fill:[self color:1:1:0]]; [self vertex:1:1:-1];
    [self fill:[self color:1:0:0]]; [self vertex:1:-1:-1];
    [self fill:[self color:1:0:1]]; [self vertex:1:-1:1];
    
    [self fill:[self color:1:1:0]]; [self vertex:1:1:-1];
    [self fill:[self color:0:1:0]]; [self vertex:-1:1:-1];
    [self fill:[self color:0:0:0]]; [self vertex:-1:-1:-1];
    [self fill:[self color:1:0:0]]; [self vertex:1:-1:-1];
    
    [self fill:[self color:0:1:0]]; [self vertex:-1:1:-1];
    [self fill:[self color:0:1:1]]; [self vertex:-1:1:1];
    [self fill:[self color:0:0:1]]; [self vertex:-1:-1:1];
    [self fill:[self color:0:0:0]]; [self vertex:-1:-1:-1];
    
    [self fill:[self color:0:1:0]]; [self vertex:-1:1:-1];
    [self fill:[self color:1:1:0]]; [self vertex:1:1:-1];
    [self fill:[self color:1:1:1]]; [self vertex:1:1:1];
    [self fill:[self color:0:1:1]]; [self vertex:-1:1:1];
    
    [self fill:[self color:0:0:0]]; [self vertex:-1:-1:-1];
    [self fill:[self color:1:0:0]]; [self vertex:1:-1:-1];
    [self fill:[self color:1:0:1]]; [self vertex:1:-1:1];
    [self fill:[self color:0:0:1]]; [self vertex:-1:-1:1];
    
    [self endShape];
    
    [self popMatrix]; 
} 

@end
