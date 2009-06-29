//
//  Random.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-18.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Random.h"


@implementation Random

- (void)setup
{
    [self size:200 :200];
    [self smooth];
    [self background:[self color:0]];
    [self strokeWeight:10];
    [self noLoop];
}

- (void)draw
{
    for(int i = 0; i < [self width]; i++) {
        float r = [self random:255];
        float x = [self random:0 :[self width]];
        [self stroke:r :100];
        [self line:i :0 :x :[self height]];
    }
}

@end
