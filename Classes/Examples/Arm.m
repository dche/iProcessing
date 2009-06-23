//
//  Arm.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-18.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Arm.h"

#define px           50
#define py           100
#define segLength   50

@interface Arm ()

- (void)segment:(float)x :(float)y :(float)angle;

@end


@implementation Arm

- (void)setup
{
    [self size:200 :200];
    [self smooth]; 
    [self strokeWeight:20.0];
    [self stroke:0 :100];    
}

- (void)draw
{
    [self background:226 :255];
    
    angle1 = ([self mouseX]/([self width]) - 0.5) * -PI;
    angle2 = ([self mouseY]/([self height]) - 0.5) * PI;
    
    [self pushMatrix];
    [self segment:px :py :angle1]; 
    [self segment:segLength :0 :angle2];
    [self popMatrix];    
}

- (void)segment:(float)x :(float)y :(float)angle
{
    [self translate:x :y];
    [self rotate:angle];
    [self line:0 :0 :segLength :0];
}

@end
