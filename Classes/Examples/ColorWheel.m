/**
 * Subtractive Color Wheel 
 * by Ira Greenberg. 
 * 
 * The primaries are red, yellow, and blue. The
 * secondaries are green, purple, and orange. The 
 * tertiaries are  yellow-orange, red-orange, red-purple, 
 * blue-purple, blue-green, and yellow-green.
 * 
 * Create a shade or tint of the 
 * subtractive color wheel using
 * SHADE or TINT parameters.
 */

//
//  ColorWheel.m
//  iProcessing
//
//  Translated by Diego Che on 09-06-22.
//  Copyright 2009 campl software. All rights reserved.
//

#import "ColorWheel.h"

static const int segs = 12;
static const int steps = 6;
static float rotAdjust;
static float radius = 95.0;
static float segWidth;
static float interval;
static const int SHADE = 0;
static const int TINT = 1;

@interface ColorWheel ()

- (void)createWheel:(int)x :(int)y :(int)valueShift;

@end


@implementation ColorWheel

- (void)setup
{
    [self size:200 :200];
    [self noLoop];
    [self smooth];
    [self ellipseMode:RADIUS];
    [self noStroke];
    
    rotAdjust = [self radians:360.0 / segs / 2.0];
    segWidth = radius / steps;
    interval = TWO_PI / segs;
}

- (void)draw
{
    [self noStroke];
    [self createWheel:[self width]/2 :[self height]/2 :SHADE];
}

- (void)createWheel:(int)x :(int)y :(int)valueShift
{
    color *cols;
    if (valueShift == SHADE){
        for (int j = 0; j < steps; j++){
            color colors[] = { 
                [self color:255-(255/steps)*j :255-(255/steps)*j :0], 
                [self color:255-(255/steps)*j :(255/1.5)-((255/1.5)/steps)*j :0], 
                [self color:255-(255/steps)*j :(255/2)-((255/2)/steps)*j: 0], 
                [self color:255-(255/steps)*j :(255/2.5)-((255/2.5)/steps)*j :0], 
                [self color:255-(255/steps)*j :0 :0], 
                [self color:255-(255/steps)*j :0 :(255/2)-((255/2)/steps)*j], 
                [self color:255-(255/steps)*j :0 :255-(255/steps)*j], 
                [self color:(255/2)-((255/2)/steps)*j :0 :255-(255/steps)*j], 
                [self color:0 :0 :255-(255/steps)*j],
                [self color:0 :255-(255/steps)*j: (255/2.5)-((255/2.5)/steps)*j], 
                [self color:0 :255-(255/steps)*j: 0], 
                [self color:(255/2)-((255/2)/steps)*j :255-(255/steps)*j :0] };
            cols = colors;
            for (int i = 0; i < segs; i++){
                [self fill:cols[i]];
                [self arc:x :y :radius :radius :interval*i+rotAdjust :interval*(i+1)+rotAdjust];
            }
            radius -= segWidth;
        }
    } 
    else  if (valueShift == TINT){
        for (int j = 0; j < steps; j++){
            color colors[] = { 
                [self color:(255/steps)*j :(255/steps)*j :0], 
                [self color:(255/steps)*j :((255/1.5)/steps)*j :0], 
                [self color:(255/steps)*j :((255/2)/steps)*j :0], 
                [self color:(255/steps)*j :((255/2.5)/steps)*j :0], 
                [self color:(255/steps)*j :0 :0], 
                [self color:(255/steps)*j :0 :((255/2)/steps)*j], 
                [self color:(255/steps)*j :0 :(255/steps)*j], 
                [self color:((255/2)/steps)*j :0 :(255/steps)*j], 
                [self color:0 :0 :(255/steps)*j],
                [self color:0 :(255/steps)*j :((255/2.5)/steps)*j], 
                [self color:0 :(255/steps)*j :0], 
                [self color:((255/2)/steps)*j :(255/steps)*j :0] };
            cols = colors;
            for (int i = 0; i < segs; i++){
                [self fill:cols[i]];
                [self arc:x :y :radius :radius :interval*i+rotAdjust :interval*(i+1)+rotAdjust];
            }
            radius -= segWidth;
        }
    }    
}

@end
