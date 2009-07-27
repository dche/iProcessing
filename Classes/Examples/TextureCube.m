/**
 * TexturedCube
 * by Dave Bollinger.
 * 
 * Drag mouse to rotate cube. Demonstrates use of u/v coords in 
 * vertex() and effect on texture(). The textures get distorted using
 * the P3D renderer as you can see, but they look great using OPENGL.
 */
/*

PImage tex;
float rotx = PI/4;
float roty = PI/4;

void setup() 
{
    size(640, 360, P3D);
    tex = loadImage("berlin-1.jpg");
    textureMode(NORMALIZED);
    fill(255);
    stroke(color(44,48,32));
}

void draw() 
{
    background(0);
    noStroke();
    translate(width/2.0, height/2.0, -100);
    rotateX(rotx);
    rotateY(roty);
    scale(90);
    TexturedCube(tex);
}

void TexturedCube(PImage tex) {
    beginShape(QUADS);
    texture(tex);
    
    // Given one texture and six faces, we can easily set up the uv coordinates
    // such that four of the faces tile "perfectly" along either u or v, but the other
    // two faces cannot be so aligned.  This code tiles "along" u, "around" the X/Z faces
    // and fudges the Y faces - the Y faces are arbitrarily aligned such that a
    // rotation along the X axis will put the "top" of either texture at the "top"
    // of the screen, but is not otherwised aligned with the X/Z faces. (This
    // just affects what type of symmetry is required if you need seamless
    // tiling all the way around the cube)
    
    // +Z "front" face
    vertex(-1, -1,  1, 0, 0);
    vertex( 1, -1,  1, 1, 0);
    vertex( 1,  1,  1, 1, 1);
    vertex(-1,  1,  1, 0, 1);
    
    // -Z "back" face
    vertex( 1, -1, -1, 0, 0);
    vertex(-1, -1, -1, 1, 0);
    vertex(-1,  1, -1, 1, 1);
    vertex( 1,  1, -1, 0, 1);
    
    // +Y "bottom" face
    vertex(-1,  1,  1, 0, 0);
    vertex( 1,  1,  1, 1, 0);
    vertex( 1,  1, -1, 1, 1);
    vertex(-1,  1, -1, 0, 1);
    
    // -Y "top" face
    vertex(-1, -1, -1, 0, 0);
    vertex( 1, -1, -1, 1, 0);
    vertex( 1, -1,  1, 1, 1);
    vertex(-1, -1,  1, 0, 1);
    
    // +X "right" face
    vertex( 1, -1,  1, 0, 0);
    vertex( 1, -1, -1, 1, 0);
    vertex( 1,  1, -1, 1, 1);
    vertex( 1,  1,  1, 0, 1);
    
    // -X "left" face
    vertex(-1, -1, -1, 0, 0);
    vertex(-1, -1,  1, 1, 0);
    vertex(-1,  1,  1, 1, 1);
    vertex(-1,  1, -1, 0, 1);
    
    endShape();
}

void mouseDragged() {
    float rate = 0.01;
    rotx += (pmouseY-mouseY) * rate;
    roty += (mouseX-pmouseX) * rate;
}
*/
//
//  TextureCube.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-15.
//  Copyright 2009 campl software. All rights reserved.
//

#import "TextureCube.h"

@implementation TextureCube

- (void)TexturedCube:(PImage *)t
{
    [self beginShape:QUADS];
    [self texture:t];
    
    // Given one texture and six faces, we can easily set up the uv coordinates
    // such that four of the faces tile "perfectly" along either u or v, but the other
    // two faces cannot be so aligned.  This code tiles "along" u, "around" the X/Z faces
    // and fudges the Y faces - the Y faces are arbitrarily aligned such that a
    // rotation along the X axis will put the "top" of either texture at the "top"
    // of the screen, but is not otherwised aligned with the X/Z faces. (This
    // just affects what type of symmetry is required if you need seamless
    // tiling all the way around the cube)
    
    // +Z "front" face
    [self vertex:-1 :-1 :1 :0 :0];
    [self vertex: 1 :-1 : 1 :1 :0];
    [self vertex: 1 : 1 : 1 :1 :1];
    [self vertex:-1 : 1 : 1 :0 :1];
    
    // -Z "back" face
    [self vertex: 1 :-1 :-1 :0 :0];
    [self vertex:-1 :-1 :-1 :1 :0];
    [self vertex:-1 : 1 :-1 :1 :1];
    [self vertex: 1 : 1 :-1 :0 :1];
    
    // +Y "bottom" face
    [self vertex:-1 : 1 : 1 :0 :0];
    [self vertex: 1 : 1 : 1 :1 :0];
    [self vertex: 1 : 1 :-1 :1 :1];
    [self vertex:-1 : 1 :-1 :0 :1];
    
    // -Y "top" face
    [self vertex:-1 :-1 :-1 :0 :0];
    [self vertex: 1 :-1 :-1 :1 :0];
    [self vertex: 1 :-1 : 1 :1 :1];
    [self vertex:-1 :-1 : 1 :0 :1];
    
    // +X "right" face
    [self vertex: 1 :-1 : 1 :0 :0];
    [self vertex: 1 :-1 :-1 :1 :0];
    [self vertex: 1 : 1 :-1 :1 :1];
    [self vertex: 1 : 1 : 1 :0 :1];
    
    // -X "left" face
    [self vertex:-1 :-1 :-1 :0 :0];
    [self vertex:-1 :-1 : 1 :1 :0];
    [self vertex:-1 : 1 : 1 :1 :1];
    [self vertex:-1 : 1 :-1 :0 :1];
    
    [self endShape];
}

- (void)setup 
{
    [self size:320 :320 :P3D];
    rotx = PI/4;
    roty = PI/4;
    
    tex = [[self loadImage:@"berlin-1.jpg"] retain];
    [self textureMode:NORMAL];
    [self fill:[self color:255]];
    [self stroke:[self color:44 :48 :32]];
}

- (void)draw 
{
    [self background:PBlackColor];
    [self noStroke];
    [self translate:self.width/2.0 :self.height/2.0 :-100];
    [self rotateX:rotx];
    [self rotateY:roty];
    [self scale:90];
    [self TexturedCube:tex];
}

- (void)mouseDragged
{
    float rate = 0.01;
    rotx += (self.pmouseY-self.mouseY) * rate;
    roty += (self.mouseX-self.pmouseX) * rate;
}

@end
