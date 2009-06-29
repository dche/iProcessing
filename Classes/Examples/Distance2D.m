//
//  Distance2D.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-18.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Distance2D.h"


@implementation Distance2D

- (void)setup
{
    [self size:200 :200]; 
    [self smooth];
    [self noStroke];
    max_distance = [self dist:0 :0 :[self width] :[self height]];
}

- (void)draw
{
    [self background:[self color:51]];
    for(int i = 0; i <= [self width]; i += 20) {
        for(int j = 0; j <= [self height]; j += 20) {
            float size = [self dist:[self mouseX] :[self mouseY] :i :j];
            size = size/max_distance * 66;
            [self ellipse:i :j :size :size];
        }
    }
}

@end
