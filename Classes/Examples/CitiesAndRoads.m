//
//  CitiesAndRoads.m
//  iProcessing
//
//  Created by Kenan Che on 09-08-08.
//  Copyright 2009 campl software. All rights reserved.
//

#import "CitiesAndRoads.h"


@implementation CitiesAndRoads

- (void)setup
{
    [self size:320 :320: QUARTZ2D];
    [self noLoop];
}

- (void)draw
{
    
}

- (void)mouseClicked
{
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    [self redraw];
    NSTimeInterval elapsed = [NSDate timeIntervalSinceReferenceDate] - now;
    NSLog(@"%f milliseconds", elapsed);
}

@end
