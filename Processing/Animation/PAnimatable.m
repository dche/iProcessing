//
//  PAnimatable.m
//  iProcessing
//
//  Created by Kenan Che on 10-04-03.
//  Copyright 2010 campl software. All rights reserved.
//

#import "PAnimatable.h"

@implementation PAnimatable

@dynamic startValue;
@dynamic endValue;
@synthesize timeline = timeline_;

- (id)initWithAnimation:(PAnimation *)anim
{
    if (self = [super init]) {
        self.timeline = NULL;        
        dynamicStarting_ = dynamicEnding_ = YES;
    }
    return self;
}

- (void)update:(float)value
{}

- (void)setStartValue:(float)v
{
    start_ = v;
    dynamicStarting_ = NO;
}

- (float)startValue
{
    return dynamicStarting_ ? 0 : start_;
}

- (void)setEndValue:(float)v
{
    end_ = v;
    dynamicEnding_ = NO;
}

- (float)endValue
{
    return dynamicEnding_ ? 0 : end_;
}

@end
