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

- (void)dealloc
{
    [p_ release];
    [super dealloc];
}

@end
