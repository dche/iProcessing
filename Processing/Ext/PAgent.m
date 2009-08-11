//
//  PAgent.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PAgent.h"
#import "Processing.h"

@implementation PAgent
@dynamic age;

- (id)init
{
    return [self initWithProcessing:nil];
}

- (id)initWithProcessing:(Processing *)p
{
    if (self = [super initWithProcessing:p]) {
        birthTime_ = [self.p millis];
    }
    return self;
}

- (NSUInteger)age
{
    return ([self.p millis] - birthTime_);
}

- (PAgent *)offspring:(PAgent *)a
{
    return nil;
}

@end
