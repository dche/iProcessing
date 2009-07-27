/**
 * Space Junk  
 * by Ira Greenberg. 
 * Zoom suggestion 
 * by Danny Greenberg.
 * 
 * Rotating cubes in space using a custom Cube class. 
 * Color controlled by light sources. Move the mouse left
 * and right to zoom.
 */

/*
 import processing.opengl.*;
 
 // Used for oveall rotation
 float ang;
 
 // Cube count-lower/raise to test P3D/OPENGL performance
 int limit = 500;
 
 // Array for all cubes
 Cube[]cubes = new Cube[limit];
 
 void setup() {
 size(1024, 768, OPENGL); 
 background(0); 
 noStroke();
 
 // Instantiate cubes, passing in random vals for size and postion
 for (int i = 0; i< cubes.length; i++){
 cubes[i] = new Cube(int(random(-10, 10)), int(random(-10, 10)), 
 int(random(-10, 10)), int(random(-140, 140)), int(random(-140, 140)), 
 int(random(-140, 140)));
 }
 }
 
 void draw(){
 background(0); 
 fill(200);
 
 // Set up some different colored lights
 pointLight(51, 102, 255, 65, 60, 100); 
 pointLight(200, 40, 60, -65, -60, -150);
 
 // Raise overall light in scene 
 ambientLight(70, 70, 10); 
 
 // Center geometry in display windwow.
 // you can change 3rd argument ('0')
 // to move block group closer(+)/further(-)
 translate(width/2, height/2, -200 + mouseX * 0.65);
 
 // Rotate around y and x axes
 rotateY(radians(ang));
 rotateX(radians(ang));
 
 // Draw cubes
 for (int i = 0; i < cubes.length; i++){
 cubes[i].drawCube();
 }
 
 // Used in rotate function calls above
 ang++;
 }
 
 
 class Cube {
 
 // Properties
 int w, h, d;
 int shiftX, shiftY, shiftZ;
 
 // Constructor
 Cube(int w, int h, int d, int shiftX, int shiftY, int shiftZ){
 this.w = w;
 this.h = h;
 this.d = d;
 this.shiftX = shiftX;
 this.shiftY = shiftY;
 this.shiftZ = shiftZ;
 }
 
 // Main cube drawing method, which looks 
 // more confusing than it really is. It's 
 // just a bunch of rectangles drawn for 
 // each cube face
 void drawCube(){
 beginShape(QUADS);
 // Front face
 vertex(-w/2 + shiftX, -h/2 + shiftY, -d/2 + shiftZ); 
 vertex(w + shiftX, -h/2 + shiftY, -d/2 + shiftZ); 
 vertex(w + shiftX, h + shiftY, -d/2 + shiftZ); 
 vertex(-w/2 + shiftX, h + shiftY, -d/2 + shiftZ); 
 
 // Back face
 vertex(-w/2 + shiftX, -h/2 + shiftY, d + shiftZ); 
 vertex(w + shiftX, -h/2 + shiftY, d + shiftZ); 
 vertex(w + shiftX, h + shiftY, d + shiftZ); 
 vertex(-w/2 + shiftX, h + shiftY, d + shiftZ);
 
 // Left face
 vertex(-w/2 + shiftX, -h/2 + shiftY, -d/2 + shiftZ); 
 vertex(-w/2 + shiftX, -h/2 + shiftY, d + shiftZ); 
 vertex(-w/2 + shiftX, h + shiftY, d + shiftZ); 
 vertex(-w/2 + shiftX, h + shiftY, -d/2 + shiftZ); 
 
 // Right face
 vertex(w + shiftX, -h/2 + shiftY, -d/2 + shiftZ); 
 vertex(w + shiftX, -h/2 + shiftY, d + shiftZ); 
 vertex(w + shiftX, h + shiftY, d + shiftZ); 
 vertex(w + shiftX, h + shiftY, -d/2 + shiftZ); 
 
 // Top face
 vertex(-w/2 + shiftX, -h/2 + shiftY, -d/2 + shiftZ); 
 vertex(w + shiftX, -h/2 + shiftY, -d/2 + shiftZ); 
 vertex(w + shiftX, -h/2 + shiftY, d + shiftZ); 
 vertex(-w/2 + shiftX, -h/2 + shiftY, d + shiftZ); 
 
 // Bottom face
 vertex(-w/2 + shiftX, h + shiftY, -d/2 + shiftZ); 
 vertex(w + shiftX, h + shiftY, -d/2 + shiftZ); 
 vertex(w + shiftX, h + shiftY, d + shiftZ); 
 vertex(-w/2 + shiftX, h + shiftY, d + shiftZ); 
 
 endShape(); 
 
 // Add some rotation to each box for pizazz.
 rotateY(radians(1));
 rotateX(radians(1));
 rotateZ(radians(1));
 }
 }
 */
//
//  SpaceJunk.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-16.
//  Copyright 2009 campl software. All rights reserved.
//

#import "SpaceJunk.h"

// Cube count-lower/raise to test P3D/OPENGL performance
static int limit = 500;

@implementation SpaceJunk

- (void)setup
{
    [self size:320 :320 :OPENGL]; 
    [self noStroke];
    
    // Instantiate cubes, passing in random vals for size and postion
    cubes = [[NSMutableArray alloc] initWithCapacity:limit];
    for (int i = 0; i< limit; i++){
        Cube *c = [Cube cube:[self random:-10 :10] :[self random:-10 :10] :[self random:-10 :10] 
                            :[self random:-100 :100] :[self random:-100 :100] :[self random:-100 :100]];
        c.p = self;
        [cubes addObject:c];
    }
}

- (void)draw
{
    [self background:PBlackColor]; 
    [self fill:[self color:200]];
    
    // Set up some different colored lights
    [self pointLight:51 :102 :255 :65 :60 :100]; 
    [self pointLight:200 :40 :60 :-65 :-60 :-150];
    
    // Raise overall light in scene 
    [self ambientLight:70 :70 :10]; 
    
    // Center geometry in display windwow.
    // you can change 3rd argument ('0')
    // to move block group closer(+)/further(-)
    [self translate:self.width/2 :self.height/2 :-200 + self.mouseX * 0.65];
    
    // Rotate around y and x axes
    [self rotateY:[self radians:ang]];
    [self rotateX:[self radians:ang]];
    
    // Draw cubes
    for (int i = 0; i < [cubes count]; i++){
        Cube *c = [cubes objectAtIndex:i];
        [c drawCube];
    }
    
    // Used in rotate function calls above
    ang++;
}

- (void)dealloc
{
    [cubes release];
    [super dealloc];
}

@end

@implementation Cube

- (id)init:(int)width :(int)height :(int)depth :(int)sx :(int)sy :(int)sz
{
    if (self = [super init]) {
        w = width;
        h = height;
        d = depth;
        shiftX = sx;
        shiftY = sy;
        shiftZ = sz;
    }
    return self;
}

+ (Cube *)cube:(int)w :(int)h :(int)d :(int)shiftX :(int)shiftY :(int)shiftZ
{
    return [[[self alloc] init:w :h :d :shiftX :shiftY :shiftZ] autorelease];
}

- (void)drawCube
{
    [self.p beginShape:QUADS];
    // Front face
    [self.p vertex:-w/2 + shiftX :-h/2 + shiftY :-d/2 + shiftZ]; 
    [self.p vertex:w + shiftX :-h/2 + shiftY :-d/2 + shiftZ]; 
    [self.p vertex:w + shiftX :h + shiftY :-d/2 + shiftZ]; 
    [self.p vertex:-w/2 + shiftX :h + shiftY :-d/2 + shiftZ]; 
    
    // Back face
    [self.p vertex:-w/2 + shiftX :-h/2 + shiftY :d + shiftZ]; 
    [self.p vertex:w + shiftX :-h/2 + shiftY :d + shiftZ]; 
    [self.p vertex:w + shiftX :h + shiftY :d + shiftZ]; 
    [self.p vertex:-w/2 + shiftX :h + shiftY :d + shiftZ];
    
    // Left face
    [self.p vertex:-w/2 + shiftX :-h/2 + shiftY :-d/2 + shiftZ]; 
    [self.p vertex:-w/2 + shiftX :-h/2 + shiftY :d + shiftZ]; 
    [self.p vertex:-w/2 + shiftX :h + shiftY :d + shiftZ]; 
    [self.p vertex:-w/2 + shiftX :h + shiftY :-d/2 + shiftZ]; 
    
    // Right face
    [self.p vertex:w + shiftX :-h/2 + shiftY:-d/2 + shiftZ]; 
    [self.p vertex:w + shiftX :-h/2 + shiftY :d + shiftZ]; 
    [self.p vertex:w + shiftX :h + shiftY :d + shiftZ]; 
    [self.p vertex:w + shiftX :h + shiftY :-d/2 + shiftZ]; 
    
    // Top face
    [self.p vertex:-w/2 + shiftX :-h/2 + shiftY :-d/2 + shiftZ]; 
    [self.p vertex:w + shiftX :-h/2 + shiftY :-d/2 + shiftZ]; 
    [self.p vertex:w + shiftX :-h/2 + shiftY :d + shiftZ]; 
    [self.p vertex:-w/2 + shiftX :-h/2 + shiftY :d + shiftZ]; 
    
    // Bottom face
    [self.p vertex:-w/2 + shiftX :h + shiftY :-d/2 + shiftZ]; 
    [self.p vertex:w + shiftX :h + shiftY :-d/2 + shiftZ]; 
    [self.p vertex:w + shiftX :h + shiftY :d + shiftZ]; 
    [self.p vertex:-w/2 + shiftX :h + shiftY :d + shiftZ]; 
    
    [self.p endShape]; 
    
    // Add some rotation to each box for pizazz.
    [self.p rotateY:[self.p radians:1]];
    [self.p rotateX:[self.p radians:1]];
    [self.p rotateZ:[self.p radians:1]];
}

@end

