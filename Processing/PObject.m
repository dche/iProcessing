//
//  PObject.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PObject.h"


@implementation PObject
@synthesize p = p_;

- (id)init
{
    return [self initWithProcessing:nil];
}

- (id)initWithProcessing:(Processing *)p
{
    if (p == nil) {
        [self release];
        return nil;
    }
    
    if (self = [super init]) {
        p_ = [p retain];
    }
    return self;
}

- (void)dealloc
{
    [p_ release];
    [super dealloc];
}

- (BOOL)update
{    
    return YES;
}

- (void)display
{}

@end
