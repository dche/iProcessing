//
//  Constrain.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-21.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Constrain.h"

static const float easing = 0.05;
static const float esize = 25.0;
static const int box = 30;

@implementation Constrain

- (void)setup
{
    [self size:200 :200];
    [self noStroke];
    [self smooth];
    [self ellipseMode:RADIUS];
    mx = my = 0.0;
}

- (void)draw
{
    [self background:51];
    
    if([self abs:[self mouseX] - mx] > 0.1) {
        mx = mx + ([self mouseX] - mx) * easing;
    }
    if([self abs:[self mouseY] - my] > 0.1) {
        my = my + ([self mouseY]- my) * easing;
    }
    
    float distance = esize * 2;
    mx = [self constrain:mx :box+distance :[self width]-box-distance];
    my = [self constrain:my :box+distance :[self height]-box-distance];
    [self fill:76];
    [self rect:box+esize :box+esize :box*3 :box*3];
    [self fill:255];
    [self ellipse:mx :my :esize :esize];
}

@end
