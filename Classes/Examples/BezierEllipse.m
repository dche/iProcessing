/**
 * Bezier Ellipse  
 * By Ira Greenberg 
 * 
 * Generates an ellipse using bezier() and
 * trig functions. Approximately every 1/2 
 * second a new ellipse is plotted using 
 * random values for control/anchor points.
 */

/*
// arrays to hold ellipse coordinate data
float[] px, py, cx, cy, cx2, cy2;

// global variable-points in ellipse
int pts = 4;

color controlPtCol = #222222;
color anchorPtCol = #BBBBBB;

void setup(){
    size(200, 200);
    smooth();
    setEllipse(pts, 65, 65);
    frameRate(1);
}

void draw(){
    background(145);
    drawEllipse();
    setEllipse(int(random(3, 12)), random(-100, 150), random(-100, 150));
}

// draw ellipse with anchor/control points
void drawEllipse(){
    strokeWeight(1.125);
    stroke(255);
    noFill();
    // create ellipse
    for (int i=0; i<pts; i++){
        if (i==pts-1) {
            bezier(px[i], py[i], cx[i], cy[i], cx2[i], cy2[i],  px[0], py[0]);
        }
        else{
            bezier(px[i], py[i], cx[i], cy[i], cx2[i], cy2[i],  px[i+1], py[i+1]);
        }
    }
    strokeWeight(.75);
    stroke(0);
    rectMode(CENTER);
    
    // control handles and tangent lines
    for ( int i=0; i< pts; i++){
        if (i==pts-1){  // last loop iteration-close path
            line(px[0], py[0], cx2[i], cy2[i]);
        }
        if (i>0){
            line(px[i], py[i], cx2[i-1], cy2[i-1]);
        }
        line(px[i], py[i], cx[i], cy[i]);
    }
    
    for ( int i=0; i< pts; i++){
        fill(controlPtCol);
        noStroke();
        //control handles
        ellipse(cx[i], cy[i], 4, 4);
        ellipse(cx2[i], cy2[i], 4, 4);
        
        fill(anchorPtCol);
        stroke(0);
        //anchor points
        rect(px[i], py[i], 5, 5);
    }
}

// fill up arrays with ellipse coordinate data
void setEllipse(int points, float radius, float controlRadius){
    pts = points;
    px = new float[points];
    py = new float[points];
    cx = new float[points];
    cy = new float[points];
    cx2 = new float[points];
    cy2 = new float[points];
    float angle = 360.0/points;
    float controlAngle1 = angle/3.0;
    float controlAngle2 = controlAngle1*2.0;
    for ( int i=0; i<points; i++){
        px[i] = width/2+cos(radians(angle))*radius;
        py[i] = height/2+sin(radians(angle))*radius;
        cx[i] = width/2+cos(radians(angle+controlAngle1))* 
        controlRadius/cos(radians(controlAngle1));
        cy[i] = height/2+sin(radians(angle+controlAngle1))* 
        controlRadius/cos(radians(controlAngle1));
        cx2[i] = width/2+cos(radians(angle+controlAngle2))* 
        controlRadius/cos(radians(controlAngle1));
        cy2[i] = height/2+sin(radians(angle+controlAngle2))* 
        controlRadius/cos(radians(controlAngle1));
        
        //increment angle so trig functions keep chugging along
        angle+=360.0/points;
    }
}
*/

//
//  BezierEllipse.m
//  iProcessing
//
//  Translated by Diego Che on 09-06-23.
//  Copyright 2009 campl software. All rights reserved.
//

#import "BezierEllipse.h"

// global variable-points in ellipse

static const color controlPtCol = 0x222222FF;
static const color anchorPtCol = 0xBBBBBBFF;

@interface BezierEllipse ()

- (void)drawEllipse;
- (void)setEllipse:(int)points :(float)radius :(float)controlRadius;

@end


@implementation BezierEllipse

- (void)setup
{
    [self size:200 :200];
    [self smooth];
    [self setEllipse:pts :65 :65];
    [self frameRate:1];
    pts = 4;
}

- (void)draw
{
    [self background:[self color:145]];
    [self drawEllipse];
    [self setEllipse:(int)[self random:3 :12] 
                    :[self random:-100 :150] 
                    :[self random:-100 :150]];    
}

- (void)drawEllipse
{
    [self strokeWeight:1.125];
    [self stroke:[self color:255]];
    [self noFill];
    // create ellipse
    for (int i=0; i<pts; i++){
        if (i==pts-1) {
            [self bezier:px[i] :py[i] :cx[i] :cy[i] :cx2[i] :cy2[i] :px[0] :py[0]];
        }
        else{
            [self bezier:px[i] :py[i] :cx[i] :cy[i] :cx2[i] :cy2[i] :px[i+1] :py[i+1]];
        }
    }
    [self strokeWeight:0.75];
    [self stroke:[self color:0]];
    [self rectMode:CENTER];
    
    // control handles and tangent lines
    for ( int i=0; i< pts; i++){
        if (i==pts-1){  // last loop iteration-close path
            [self line:px[0] :py[0] :cx2[i] :cy2[i]];
        }
        if (i>0){
            [self line:px[i] :py[i] :cx2[i-1] :cy2[i-1]];
        }
        [self line:px[i] :py[i] :cx[i] :cy[i]];
    }
    
    for ( int i=0; i< pts; i++){
        [self fill:controlPtCol];
        [self noStroke];
        //control handles
        [self ellipse:cx[i] :cy[i] :4 :4];
        [self ellipse:cx2[i] :cy2[i] :4 :4];
        
        [self fill:anchorPtCol];
        [self stroke:[self color:0]];
        //anchor points
        [self rect:px[i] :py[i] :5 :5];
    }
    
}

- (void)dealloc
{
    free(px); free(py); free(cx); free(cy); free(cx2); free(cy2);
    [super dealloc];
}

- (void)setEllipse:(int)points :(float)radius :(float)controlRadius
{
    pts = points;
    free(px); free(py); free(cx); free(cy); free(cx2); free(cy2);
    px = (float *)malloc(points * sizeof(float));
    py = (float *)malloc(points * sizeof(float));
    cx = (float *)malloc(points * sizeof(float));
    cy = (float *)malloc(points * sizeof(float));
    cx2 = (float *)malloc(points * sizeof(float));
    cy2 = (float *)malloc(points * sizeof(float));
    float angle = 360.0/points;
    float controlAngle1 = angle/3.0;
    float controlAngle2 = controlAngle1*2.0;
    for ( int i=0; i<points; i++){
        px[i] = [self width]/2+[self cos:[self radians:angle]]*radius;
        py[i] = [self height]/2+[self sin:[self radians:angle]]*radius;
        cx[i] = [self width]/2+[self cos:[self radians:angle+controlAngle1]]*
        controlRadius/[self cos:[self radians:controlAngle1]];
        cy[i] = [self height]/2+[self sin:[self radians:angle+controlAngle1]]*
        controlRadius/[self cos:[self radians:controlAngle1]];
        cx2[i] = [self width]/2+[self cos:[self radians:angle+controlAngle2]]*
        controlRadius/[self cos:[self radians:controlAngle1]];
        cy2[i] = [self height]/2+[self sin:[self radians:angle+controlAngle2]]*
        controlRadius/[self cos:[self radians:controlAngle1]];
        
        //increment angle so trig functions keep chugging along
        angle+=360.0/points;
    }    
}

@end
