//
//  P3DSpec.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-13.
//  Copyright 2009 campl software. All rights reserved.
//

#import "P3DSpec.h"

#define NSPEC 2

@interface P3DSpec ()

- (void)directionalLight_1;
- (void)directionalLight_2;

@end


@implementation P3DSpec

- (void)setup
{
    [self size:200 :200 :P3D];    
    SEL selectors[] = {
        @selector(directionalLight_1),
        @selector(directionalLight_2),
    };
    specs = (SEL *)malloc(NSPEC * sizeof(SEL));
    memcpy(specs, selectors, sizeof(selectors));
    [self noLoop];
}

- (void)draw
{
    int index = [self frameCount] % NSPEC;    
    [self background:PBlackColor];
    [self pushStyle];
    [self performSelector:specs[index]];
    [self popStyle];
}

- (void)dealloc
{
    free(specs);
    [super dealloc];
}

- (void)mouseClicked
{
    [self redraw];
}

- (void)directionalLight_1
{
    
}

- (void)directionalLight_2
{
    
}

@end
