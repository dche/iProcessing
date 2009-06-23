//
//  Clock.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-21.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Clock.h"


@implementation Clock

- (void)setup
{
    [self size:200 :200];
    [self stroke:[self color:255]];
    [self smooth];
}

- (void)draw
{
    [self background:0];
    [self fill:[self color:80]];
    [self noStroke];
    // Angles for sin() and cos() start at 3 o'clock;
    // subtract HALF_PI to make them start at the top
    [self ellipse:100 :100 :160 :160];
    float s = [self map:[self second] :0 :60 :0 :TWO_PI] - HALF_PI;
    float m = [self map:[self minute] + [self norm:[self second] :0 :60] :0 :60 :0 :TWO_PI] - HALF_PI; 
    float h = [self map:[self hour] + [self norm:[self minute] :0 :60] :0 :24 :0 :TWO_PI * 2] - HALF_PI;
    [self stroke:[self color:255]];
    [self strokeWeight:1];
    [self line:100 :100 :[self cos:s] * 72 + 100 :[self sin:s] * 72 + 100];
    [self strokeWeight:2];
    [self line:100 :100 :[self cos:m] * 60 + 100 :[self sin:m] * 60 + 100];
    [self strokeWeight:4];
    [self line:100 :100 :[self cos:h] * 50 + 100 :[self sin:h] * 50 + 100];
    
    // Draw the minute ticks
    [self strokeWeight:2];
    for (int a = 0; a < 360; a+=6) {
        float x = 100 + ( [self cos:[self radians:a]] * 72 );
        float y = 100 + ( [self sin:[self radians:a]] * 72 );
        [self point:x :y];
    }    
}

@end
