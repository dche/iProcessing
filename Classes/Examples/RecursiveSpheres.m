/*
 
 http://www.openprocessing.org/visuals/?visualID=154
 
int d = 0; 
float spin = 0.0; 

void setup() { 
    size(500, 500, P3D);  
} 

void draw() { 
    background(0); 
    lights(); 
    
    pushMatrix(); 
    translate(250.0, 250.0, 0.0); 
    rotateY(spin); 
    drawSphere(0.0, 0.0, 100.0, 0, 5, d, 360); // origin X, origin Y, radius, level inward, degrees roatation, num of total degrees 
    popMatrix(); 
    
    if (spin <= TWO_PI) spin = spin + 0.01; 
    else spin = 0.0; 
    
    if (d < 360) d++; 
    else d = 0; 
    
} 

void drawSphere(float x, float y, float radius, int brighten, int level, int degreesCircle, int numPoints) 
{ 
    
    fill(brighten, 255, 255 - brighten, 105);  
    pushMatrix(); 
    translate(x, y, 0); 
    
    if (level == 5)  stroke(0,200,200,50); 
    else noStroke(); 
    
    sphere(radius*2); 
    popMatrix(); 
    
    if(level > 1) 
    { 
        level--; 
        degreesCircle = degreesCircle * 2; 
        
        float A = degreesCircle * (2*PI/numPoints); 
        float CircleAx = cos(A)*radius; 
        float CircleAy = sin(A)*radius; 
        CircleAx = CircleAx + x; 
        CircleAy = CircleAy + y; 
        
        float B = (degreesCircle-(numPoints/2))*(2*PI/numPoints); 
        float CircleBx = cos(B)*radius; 
        float CircleBy = sin(B)*radius; 
        CircleBx = CircleBx + x; 
        CircleBy = CircleBy + y; 
        
        radius = radius/2; 
        brighten = brighten + 50; 
        
        drawSphere(CircleAx, CircleAy, radius, brighten, level, degreesCircle, numPoints); 
        drawSphere(CircleBx, CircleBy, radius, brighten, level, degreesCircle, numPoints);  
    }   
    
} 
*/

//
//  RecursiveSpheres.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-28.
//  Copyright 2009 campl software. All rights reserved.
//

#import "RecursiveSpheres.h"


@implementation RecursiveSpheres

- (void)setup
{ 
    [self size:320 :320 :P3D];  
} 

- (void)drawSphere:(float)x :(float)y :(float)radius 
                  :(int)brighten :(int)level :(int)degreesCircle :(int)numPoints 
{ 
    
    [self fill:brighten :255 :255-brighten :105];  
    [self pushMatrix]; 
    [self translate:x :y :0]; 
    
    if (level == 5)  [self stroke:0 :200 :200 :50]; 
    else [self noStroke]; 
    
    [self sphere:radius*2]; 
    [self popMatrix]; 
    
    if(level > 1) 
    { 
        level--; 
        degreesCircle = degreesCircle * 2; 
        
        float aA = degreesCircle * (2.0f*PI/numPoints); 
        float CircleAx = [self cos:aA]*radius; 
        float CircleAy = [self sin:aA]*radius; 
        CircleAx = CircleAx + x; 
        CircleAy = CircleAy + y; 
        
        float bB = (degreesCircle-(numPoints/2.0f))*(2.0f*PI/numPoints); 
        float CircleBx = [self cos:bB]*radius; 
        float CircleBy = [self sin:bB]*radius; 
        CircleBx = CircleBx + x; 
        CircleBy = CircleBy + y; 
        
        radius = radius/2; 
        brighten = brighten + 50; 
        
        [self drawSphere:CircleAx :CircleAy :radius :brighten :level :degreesCircle :numPoints]; 
        [self drawSphere:CircleBx :CircleBy :radius :brighten :level :degreesCircle :numPoints];  
    }   
    
} 

- (void)draw
{ 
    [self background:[self color:0]]; 
    [self lights]; 
    
    [self pushMatrix]; 
    [self translate:160.0 :160.0 :0.0]; 
    [self rotateY:spin]; 
    [self drawSphere:0.0 :0.0 :60.0 :0 :5 :d :360]; // origin X, origin Y, radius, level inward, degrees roatation, num of total degrees 
    [self popMatrix]; 
    
    if (spin <= TWO_PI) spin = spin + 0.01; 
    else spin = 0.0; 
    
    if (d < 360) d++; 
    else d = 0;     
} 

@end
