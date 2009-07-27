/**
 * Vertices 
 * by Simon Greenwold.
 * 
 * Draw a cylinder centered on the y-axis, going down 
 * from y=0 to y=height. The radius at the top can be 
 * different from the radius at the bottom, and the 
 * number of sides drawn is variable.
 */
/*
void setup() {
    size(640, 360, P3D);
}

void draw() {
    background(0);
    lights();
    translate(width / 2, height / 2);
    rotateY(map(mouseX, 0, width, 0, PI));
    rotateZ(map(mouseY, 0, height, 0, -PI));
    noStroke();
    fill(255, 255, 255);
    translate(0, -40, 0);
    drawCylinder(10, 180, 200, 16); // Draw a mix between a cylinder and a cone
    //drawCylinder(70, 70, 120, 64); // Draw a cylinder
    //drawCylinder(0, 180, 200, 4); // Draw a pyramid
}

void drawCylinder(float topRadius, float bottomRadius, float tall, int sides) {
    float angle = 0;
    float angleIncrement = TWO_PI / sides;
    beginShape(QUAD_STRIP);
    for (int i = 0; i < sides + 1; ++i) {
        vertex(topRadius*cos(angle), 0, topRadius*sin(angle));
        vertex(bottomRadius*cos(angle), tall, bottomRadius*sin(angle));
        angle += angleIncrement;
    }
    endShape();
    
    // If it is not a cone, draw the circular top cap
    if (topRadius != 0) {
        angle = 0;
        beginShape(TRIANGLE_FAN);
        
        // Center point
        vertex(0, 0, 0);
        for (int i = 0; i < sides + 1; i++) {
            vertex(topRadius * cos(angle), 0, topRadius * sin(angle));
            angle += angleIncrement;
        }
        endShape();
    }
    
    // If it is not a cone, draw the circular bottom cap
    if (bottomRadius != 0) {
        angle = 0;
        beginShape(TRIANGLE_FAN);
        
        // Center point
        vertex(0, tall, 0);
        for (int i = 0; i < sides + 1; i++) {
            vertex(bottomRadius * cos(angle), tall, bottomRadius * sin(angle));
            angle += angleIncrement;
        }
        endShape();
    }
}
*/
//
//  Vertices3D.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-15.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Vertices3D.h"

@interface Vertices3D ()

- (void)drawCylinder:(float)topRadius :(float)bottomRadius :(float)tall :(int)sides;

@end


@implementation Vertices3D
- (void)setup
{
    [self size:320 :320 :P3D];
}

- (void)draw
{
    [self background:PBlackColor];
    [self lights];
    [self translate:self.width / 2 :self.height / 2];
    [self rotateY:[self map:self.mouseX :0 :self.width :0:PI]];
    [self rotateZ:[self map:self.mouseY :0 :self.height :0 :PI]];
    [self noStroke];
    [self fill:255 :255 :255];
    [self translate:0 :-40 :0];
    [self drawCylinder:10 :80 :120 :12]; // Draw a mix between a cylinder and a cone
    //drawCylinder(70, 70, 120, 64); // Draw a cylinder
    //drawCylinder(0, 180, 200, 4); // Draw a pyramid
}

- (void)drawCylinder:(float)topRadius :(float)bottomRadius :(float)tall :(int)sides
{
    float angle = 0;
    float angleIncrement = TWO_PI / sides;
    [self beginShape:QUAD_STRIP];
    for (int i = 0; i < sides + 1; ++i) {
        [self vertex:topRadius*cosf(angle) :0 :topRadius*sinf(angle)];
        [self vertex:bottomRadius*cosf(angle) :tall :bottomRadius*sinf(angle)];
        angle += angleIncrement;
    }
    [self endShape];
    
    // If it is not a cone, draw the circular top cap
    if (topRadius != 0) {
        angle = 0;
        [self beginShape:TRIANGLE_FAN];
        
        // Center point
        [self vertex:0 :0 :0];
        for (int i = 0; i < sides + 1; i++) {
            [self vertex:topRadius * cosf(angle) :0 :topRadius * sinf(angle)];
            angle += angleIncrement;
        }
        [self endShape];
    }
    
    // If it is not a cone, draw the circular bottom cap
    if (bottomRadius != 0) {
        angle = 0;
        [self beginShape:TRIANGLE_FAN];
        
        // Center point
        [self vertex:0 :tall :0];
        for (int i = 0; i < sides + 1; i++) {
            [self vertex:bottomRadius * cosf(angle) :tall :bottomRadius * sinf(angle)];
            angle += angleIncrement;
        }
        [self endShape];
    }
}

@end
