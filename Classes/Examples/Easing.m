//
//  Easing.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-21.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Easing.h"

static const float easing = 0.05;

@implementation Easing

- (void)setup
{
    [self size:200 :200];
    [self smooth];
    [self noStroke];
}

- (void)draw
{
    [self background:[self color:51]];
    
    targetX = [self mouseX];
    float dx = [self mouseX] - x;
    if([self abs:dx] > 1) {
        x += dx * easing;
    }
    
    targetY = [self mouseY];
    float dy = [self mouseY] - y;
    if([self abs:dy] > 1) {
        y += dy * easing;
    }
    
    [self ellipse:x :y :33 :33];
}

@end
