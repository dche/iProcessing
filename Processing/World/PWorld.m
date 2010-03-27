//
//  PWorld.m
//  iProcessing
//
//  Created by Kenan Che on 09-08-13.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PWorld.h"

static PWorld *theWorld;

@implementation PWorld

+ (PWorld *)world
{
    return theWorld;
}

- (void)setup
{
    
}

- (void)draw
{
    for (PObject *o in objects_) {
        if ([o update]) {
            [o display];
        } else {
            [self removeObject:o];
        }
    }
}


@end
