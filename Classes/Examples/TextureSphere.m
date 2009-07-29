/**
 * Textured Sphere 
 * by Mike 'Flux' Chang (cleaned up by Aaron Koblin). 
 * Based on code by Toxi. 
 * 
 * A 3D textured sphere with simple rotation control.
 * Note: Controls will be inverted when sphere is upside down. 
 * Use an "arc ball" to deal with this appropriately.
 */ 
/*

import processing.opengl.*;

PImage bg;
PImage texmap;

int sDetail = 35;  // Sphere detail setting
float rotationX = 0;
float rotationY = 0;
float velocityX = 0;
float velocityY = 0;
float globeRadius = 450;
float pushBack = 0;

float[] cx, cz, sphereX, sphereY, sphereZ;
float sinLUT[];
float cosLUT[];
float SINCOS_PRECISION = 0.5;
int SINCOS_LENGTH = int(360.0 / SINCOS_PRECISION);


void setup() {
    size(1024, 768, OPENGL);  
    texmap = loadImage("world32k.jpg");    
    initializeSphere(sDetail);
}

void draw() {    
    background(0);            
    renderGlobe(); 
}

void renderGlobe() {
    pushMatrix();
    translate(width/2.0, height/2.0, pushBack);
    pushMatrix();
    noFill();
    stroke(255,200);
    strokeWeight(2);
    smooth();
    popMatrix();
    lights();    
    pushMatrix();
    rotateX( radians(-rotationX) );  
    rotateY( radians(270 - rotationY) );
    fill(200);
    noStroke();
    textureMode(IMAGE);  
    texturedSphere(globeRadius, texmap);
    popMatrix();  
    popMatrix();
    rotationX += velocityX;
    rotationY += velocityY;
    velocityX *= 0.95;
    velocityY *= 0.95;
    
    // Implements mouse control (interaction will be inverse when sphere is  upside down)
    if(mousePressed){
        velocityX += (mouseY-pmouseY) * 0.01;
        velocityY -= (mouseX-pmouseX) * 0.01;
    }
}

void initializeSphere(int res)
{
    sinLUT = new float[SINCOS_LENGTH];
    cosLUT = new float[SINCOS_LENGTH];
    
    for (int i = 0; i < SINCOS_LENGTH; i++) {
        sinLUT[i] = (float) Math.sin(i * DEG_TO_RAD * SINCOS_PRECISION);
        cosLUT[i] = (float) Math.cos(i * DEG_TO_RAD * SINCOS_PRECISION);
    }
    
    float delta = (float)SINCOS_LENGTH/res;
    float[] cx = new float[res];
    float[] cz = new float[res];
    
    // Calc unit circle in XZ plane
    for (int i = 0; i < res; i++) {
        cx[i] = -cosLUT[(int) (i*delta) % SINCOS_LENGTH];
        cz[i] = sinLUT[(int) (i*delta) % SINCOS_LENGTH];
    }
    
    // Computing vertexlist vertexlist starts at south pole
    int vertCount = res * (res-1) + 2;
    int currVert = 0;
    
    // Re-init arrays to store vertices
    sphereX = new float[vertCount];
    sphereY = new float[vertCount];
    sphereZ = new float[vertCount];
    float angle_step = (SINCOS_LENGTH*0.5f)/res;
    float angle = angle_step;
    
    // Step along Y axis
    for (int i = 1; i < res; i++) {
        float curradius = sinLUT[(int) angle % SINCOS_LENGTH];
        float currY = -cosLUT[(int) angle % SINCOS_LENGTH];
        for (int j = 0; j < res; j++) {
            sphereX[currVert] = cx[j] * curradius;
            sphereY[currVert] = currY;
            sphereZ[currVert++] = cz[j] * curradius;
        }
        angle += angle_step;
    }
    sDetail = res;
}

// Generic routine to draw textured sphere
void texturedSphere(float r, PImage t) 
{
    int v1,v11,v2;
    r = (r + 240 ) * 0.33;
    beginShape(TRIANGLE_STRIP);
    texture(t);
    float iu=(float)(t.width-1)/(sDetail);
    float iv=(float)(t.height-1)/(sDetail);
    float u=0,v=iv;
    for (int i = 0; i < sDetail; i++) {
        vertex(0, -r, 0,u,0);
        vertex(sphereX[i]*r, sphereY[i]*r, sphereZ[i]*r, u, v);
        u+=iu;
    }
    vertex(0, -r, 0,u,0);
    vertex(sphereX[0]*r, sphereY[0]*r, sphereZ[0]*r, u, v);
    endShape();   
    
    // Middle rings
    int voff = 0;
    for(int i = 2; i < sDetail; i++) {
        v1=v11=voff;
        voff += sDetail;
        v2=voff;
        u=0;
        beginShape(TRIANGLE_STRIP);
        texture(t);
        for (int j = 0; j < sDetail; j++) {
            vertex(sphereX[v1]*r, sphereY[v1]*r, sphereZ[v1++]*r, u, v);
            vertex(sphereX[v2]*r, sphereY[v2]*r, sphereZ[v2++]*r, u, v+iv);
            u+=iu;
        }
        
        // Close each ring
        v1=v11;
        v2=voff;
        vertex(sphereX[v1]*r, sphereY[v1]*r, sphereZ[v1]*r, u, v);
        vertex(sphereX[v2]*r, sphereY[v2]*r, sphereZ[v2]*r, u, v+iv);
        endShape();
        v+=iv;
    }
    u=0;
    
    // Add the northern cap
    beginShape(TRIANGLE_STRIP);
    texture(t);
    for (int i = 0; i < sDetail; i++) {
        v2 = voff + i;
        vertex(sphereX[v2]*r, sphereY[v2]*r, sphereZ[v2]*r, u, v);
        vertex(0, r, 0,u,v+iv);    
        u+=iu;
    }
    vertex(sphereX[voff]*r, sphereY[voff]*r, sphereZ[voff]*r, u, v);
    endShape();
    
}
*/
//
//  TextureSphere.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-15.
//  Copyright 2009 campl software. All rights reserved.
//

#import "TextureSphere.h"

static const float pushBack = 0;
static const float globeRadius = 120;
static const float SINCOS_PRECISION = 0.5;
static const int SINCOS_LENGTH = 720;

@implementation TextureSphere

// Generic routine to draw textured sphere
- (void)texturedSphere:(float)r :(PImage *)t 
{
    int v1,v11,v2;
    r = (r + 240 ) * 0.33;
    [self beginShape:TRIANGLE_STRIP];
    [self texture:t];
    float iu= (t.width-1)/((float)sDetail);
    float iv= (t.height-1)/((float)sDetail);
    float u=0,v=iv;
    for (int i = 0; i < sDetail; i++) {
        [self vertex:0 :r :0 :u :0];
        [self vertex:sphereX[i]*r :sphereY[i]*r :sphereZ[i]*r :u :v];
        u+=iu;
    }
    [self vertex:0 :-r :0 :u :0];
    [self vertex:sphereX[0]*r :sphereY[0]*r :sphereZ[0]*r :u :v];
    [self endShape];   
    
    // Middle rings
    int voff = 0;
    for(int i = 2; i < sDetail; i++) {
        v1=v11=voff;
        voff += sDetail;
        v2=voff;
        u=0;
        [self beginShape:TRIANGLE_STRIP];
        [self texture:t];
        for (int j = 0; j < sDetail; j++) {
            [self vertex:sphereX[v1]*r :sphereY[v1]*r :sphereZ[v1++]*r :u :v];
            [self vertex:sphereX[v2]*r :sphereY[v2]*r :sphereZ[v2++]*r :u :v+iv];
            u+=iu;
        }
        
        // Close each ring
        v1=v11;
        v2=voff;
        [self vertex:sphereX[v1]*r :sphereY[v1]*r :sphereZ[v1]*r :u :v];
        [self vertex:sphereX[v2]*r :sphereY[v2]*r :sphereZ[v2]*r :u :v+iv];
        [self endShape];
        v+=iv;
    }
    u=0;
    
    // Add the northern cap
    [self beginShape:TRIANGLE_STRIP];
    [self texture:t];
    for (int i = 0; i < sDetail; i++) {
        v2 = voff + i;
        [self vertex:sphereX[v2]*r :sphereY[v2]*r :sphereZ[v2]*r :u :v];
        [self vertex:0 :-r :0 :u :v+iv];    
        u+=iu;
    }
    [self vertex:sphereX[voff]*r :sphereY[voff]*r :sphereZ[voff]*r :u :v];
    [self endShape];
    
}

- (void)renderGlobe
{
    [self pushMatrix];
    [self translate:self.width/2.0 :self.height/2.0 :pushBack];
    [self lights];    
    [self pushMatrix];
    [self rotateX:[self radians:-rotationX]];  
    [self rotateY:[self radians:270 - rotationY]];
    [self fill:[self color:200]];
    [self noStroke];
    [self textureMode:IMAGE];  
    [self texturedSphere:globeRadius :texmap];
    [self popMatrix];  
    [self popMatrix];
    rotationX += velocityX;
    rotationY += velocityY;
    velocityX *= 0.95;
    velocityY *= 0.95;
    
    // Implements mouse control (interaction will be inverse when sphere is  upside down)
    if([self isMousePressed]){
        velocityX += (self.mouseY-self.pmouseY) * 0.01;
        velocityY -= (self.mouseX-self.pmouseX) * 0.01;
    }
}

- (void)initializeSphere:(int)res
{    
    float delta = SINCOS_LENGTH/(float)res;
    float *cx = malloc(res * sizeof(float));
    float *cz = malloc(res * sizeof(float));
    
    // Calc unit circle in XZ plane
    for (int i = 0; i < res; i++) {
        cx[i] = cosf([self radians:(i*delta*SINCOS_PRECISION)]);
        cz[i] = sinf([self radians:(i*delta*SINCOS_PRECISION)]);
    }
    
    // Computing vertexlist vertexlist starts at south pole
    int vertCount = res * (res-1) + 2;
    int currVert = 0;
    
    // Re-init arrays to store vertices
    sphereX = malloc(vertCount * sizeof(float));
    sphereY = malloc(vertCount * sizeof(float));
    sphereZ = malloc(vertCount * sizeof(float));
    float angle_step = (SINCOS_LENGTH*SINCOS_PRECISION)/res;
    float angle = angle_step;
    
    // Step along Y axis
    for (int i = 1; i < res; i++) {
        float curradius = sinf([self radians:angle*SINCOS_PRECISION]);
        float currY = cosf([self radians:angle*SINCOS_PRECISION]);
        for (int j = 0; j < res; j++) {
            sphereX[currVert] = cx[j] * curradius;
            sphereY[currVert] = currY;
            sphereZ[currVert++] = cz[j] * curradius;
        }
        angle += angle_step;
    }
    free(cx);
    free(cz);

    sDetail = res;
}

- (void)setup
{
    [self size:320 :320 :OPENGL];  
    texmap = [self loadImage:@"world32k.jpg"];
    [texmap retain];
    
    sDetail = 35;
    [self initializeSphere:sDetail];
}

- (void) draw
{    
    [self background:[self color:0]];            
    [self renderGlobe]; 
}

- (void)dealloc
{
    [texmap release];
    free(sphereZ);
    free(sphereX);
    free(sphereY);
    [super dealloc];
}

@end
