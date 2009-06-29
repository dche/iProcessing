/**
 * Non-orthogonal Reflection 
 * by Ira Greenberg. 
 * 
 * Based on the equation (R = 2N(N*L)-L) where R is the 
 * reflection vector, N is the normal, and L is the incident
 * vector.
 */
/*
float baseX1, baseY1, baseX2, baseY2;
float baseLength;
float[] xCoords, yCoords;
float ellipseX, ellipseY, ellipseRadius = 6;
float directionX, directionY;
float ellipseSpeed = 3.5;
float velocityX, velocityY; 

void setup(){
    size(640, 240);
    frameRate(30);
    fill(128);
    smooth();
    baseX1 = 0;
    baseY1 = height-150;
    baseX2 = width;
    baseY2 = height;
    
    // start ellipse at middle top of screen
    ellipseX = width/2;
    
    // calculate initial random direction
    directionX = random(0.1, 0.99);
    directionY = random(0.1, 0.99);
    
    // normalize direction vector
    float directionVectLength = sqrt(directionX*directionX + 
                                     directionY*directionY);
    directionX /= directionVectLength;
    directionY /= directionVectLength;
}

void draw(){
    // draw background
    fill(0, 12);
    noStroke();
    rect(0, 0, width, height);
    
    // calculate length of base top
    baseLength = dist(baseX1, baseY1, baseX2, baseY2);
    xCoords = new float[ceil(baseLength)];
    yCoords = new float[ceil(baseLength)];
    
    // fill base top coordinate array
    for (int i=0; i<xCoords.length; i++){
        xCoords[i] = baseX1 + ((baseX2-baseX1)/baseLength)*i;
        yCoords[i] = baseY1 + ((baseY2-baseY1)/baseLength)*i;
    }
    
    // draw base
    fill(200);
    quad(baseX1, baseY1, baseX2, baseY2, baseX2, height, 0, height);
    
    // calculate base top normal
    float baseDeltaX = (baseX2-baseX1)/baseLength;
    float baseDeltaY = (baseY2-baseY1)/baseLength;
    float normalX = -baseDeltaY;
    float normalY = baseDeltaX;
    
    // draw ellipse
    noStroke();
    fill(255);
    ellipse(ellipseX, ellipseY, ellipseRadius*2, ellipseRadius*2);
    
    // calculate ellipse velocity
    velocityX = directionX * ellipseSpeed;
    velocityY = directionY * ellipseSpeed;
    
    // move elipse
    ellipseX += velocityX;
    ellipseY += velocityY;
    
    // normalized incidence vector
    float incidenceVectorX = -directionX;
    float incidenceVectorY = -directionY;
    
    // detect and handle collision
    for (int i=0; i<xCoords.length; i++){
        // check distance between ellipse and base top coordinates
        if (dist(ellipseX, ellipseY, xCoords[i], yCoords[i]) < ellipseRadius){
            
            // calculate dot product of incident vector and base top normal 
            float dot = incidenceVectorX*normalX + incidenceVectorY*normalY;
            
            // calculate reflection vector
            float reflectionVectorX = 2*normalX*dot - incidenceVectorX;
            float reflectionVectorY = 2*normalY*dot - incidenceVectorY;
            
            // assign reflection vector to direction vector
            directionX = reflectionVectorX;
            directionY = reflectionVectorY;
            
            // draw base top normal at collision point
            stroke(255, 128, 0);
            line(ellipseX, ellipseY, ellipseX-normalX*100, 
                 ellipseY-normalY*100);
        }
    }
    
    // detect boundary collision
    // right
    if (ellipseX > width-ellipseRadius){
        ellipseX = width-ellipseRadius;
        directionX *= -1;
    }
    // left 
    if (ellipseX < ellipseRadius){
        ellipseX = ellipseRadius;
        directionX *= -1;
    }
    // top
    if (ellipseY < ellipseRadius){
        ellipseY = ellipseRadius;
        directionY *= -1;
        // randomize base top
        baseY1 = random(height-100, height);
        baseY2 = random(height-100, height);
    }
}
*/
//
//  Reflection1.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Reflection1.h"

static const float ellipseRadius = 6;
static const float ellipseSpeed = 3.5;

@implementation Reflection1

- (void)setup
{
    [self size:320 :320];
    [self frameRate:30];
    [self fill:[self color:128]];
    [self smooth];
    baseX1 = 0;
    baseY1 = [self height]-150;
    baseX2 = [self width];
    baseY2 = [self height];
    
    // start ellipse at middle top of screen
    ellipseX = [self width]/2;
    
    // calculate initial random direction
    directionX = [self random:0.1 :0.99];
    directionY = [self random:0.1 :0.99];
    
    // normalize direction vector
    float directionVectLength = [self sqrt:directionX*directionX + directionY*directionY];
    directionX /= directionVectLength;
    directionY /= directionVectLength;
}

- (void) draw
{
    // draw background
    [self fill:0 :12];
    [self noStroke];
    [self rect:0 :0 :[self width] :[self height]];
    
    // calculate length of base top
    baseLength = [self dist:baseX1 :baseY1 :baseX2 :baseY2];
    float *xCoords = (float *)malloc([self ceil:baseLength] * sizeof(float));
    float *yCoords = (float *)malloc([self ceil:baseLength] * sizeof(float));
    
    // fill base top coordinate array
    for (int i=0; i<[self ceil:baseLength]; i++){
        xCoords[i] = baseX1 + ((baseX2-baseX1)/baseLength)*i;
        yCoords[i] = baseY1 + ((baseY2-baseY1)/baseLength)*i;
    }
    
    // draw base
    [self fill:[self color:200]];
    [self quad:baseX1 :baseY1 :baseX2 :baseY2 :baseX2 :[self height] :0 :[self height]];
    
    // calculate base top normal
    float baseDeltaX = (baseX2-baseX1)/baseLength;
    float baseDeltaY = (baseY2-baseY1)/baseLength;
    float normalX = -baseDeltaY;
    float normalY = baseDeltaX;
    
    // draw ellipse
    [self noStroke];
    [self fill:[self color:255]];
    [self ellipse:ellipseX :ellipseY :ellipseRadius*2 :ellipseRadius*2];
    
    // calculate ellipse velocity
    velocityX = directionX * ellipseSpeed;
    velocityY = directionY * ellipseSpeed;
    
    // move elipse
    ellipseX += velocityX;
    ellipseY += velocityY;
    
    // normalized incidence vector
    float incidenceVectorX = -directionX;
    float incidenceVectorY = -directionY;
    
    // detect and handle collision
    for (int i=0; i<[self ceil:baseLength]; i++){
        // check distance between ellipse and base top coordinates
        if ([self dist:ellipseX :ellipseY :xCoords[i] :yCoords[i]] < ellipseRadius){
            
            // calculate dot product of incident vector and base top normal 
            float dot = incidenceVectorX*normalX + incidenceVectorY*normalY;
            
            // calculate reflection vector
            float reflectionVectorX = 2*normalX*dot - incidenceVectorX;
            float reflectionVectorY = 2*normalY*dot - incidenceVectorY;
            
            // assign reflection vector to direction vector
            directionX = reflectionVectorX;
            directionY = reflectionVectorY;
            
            // draw base top normal at collision point
            [self stroke:255 :128 :0];
            [self line:ellipseX :ellipseY :ellipseX-normalX*100 :ellipseY-normalY*100];
        }
    }
    
    free(xCoords);
    free(yCoords);
    
    // detect boundary collision
    // right
    if (ellipseX > [self width]-ellipseRadius){
        ellipseX = [self width]-ellipseRadius;
        directionX *= -1;
    }
    // left 
    if (ellipseX < ellipseRadius){
        ellipseX = ellipseRadius;
        directionX *= -1;
    }
    // top
    if (ellipseY < ellipseRadius){
        ellipseY = ellipseRadius;
        directionY *= -1;
        // randomize base top
        baseY1 = [self random:[self height]-100 :[self height]];
        baseY2 = [self random:[self height]-100 :[self height]];
    }
}

@end
