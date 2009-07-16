/**
 * Directional. 
 * 
 * Move the mouse the change the direction of the light.
 * Directional light comes from one direction and is stronger 
 * when hitting a surface squarely and weaker if it hits at a 
 * a gentle angle. After hitting a surface, a directional lights 
 * scatters in all directions. 
 */
/*
void setup() {
    size(640, 360, P3D);
    noStroke();
    fill(204);
}

void draw() {
    noStroke(); 
    background(0); 
    float dirY = (mouseY / float(height) - 0.5) * 2;
    float dirX = (mouseX / float(width) - 0.5) * 2;
    directionalLight(204, 204, 204, -dirX, -dirY, -1); 
    translate(width/2 - 100, height/2, 0); 
    sphere(80); 
    translate(200, 0, 0); 
    sphere(80); 
}
*/
//
//  Directional.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-14.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Directional.h"


@implementation Directional

- (void)setup
{
    [self size:320 :320 :P3D];
    [self noStroke];
    [self fill:[self color:204]];
}

- (void)draw
{
    [self background:PBlackColor]; 
    float dirY = (self.mouseY / (float)self.height - 0.5) * 2;
    float dirX = (self.mouseX / (float)self.width - 0.5) * 2;
    [self directionalLight:184 :184 :184 :-dirX :-dirY :-1]; 
    [self translate:self.width/2 - 80 :self.height/2 :0]; 
    [self sphere:60]; 
    [self translate:150 :0 :0]; 
    [self sphere:60]; 
}

@end
