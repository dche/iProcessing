//
//  P3DSpec.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-13.
//  Copyright 2009 campl software. All rights reserved.
//

#import "P3DSpec.h"

#define NSPEC 3

@interface P3DSpec ()

- (void)directionalLight_1;
- (void)directionalLight_2;
- (void)pointLight;

@end


@implementation P3DSpec

- (void)setup
{
    [self size:200 :200 :P3D];    
    SEL selectors[] = {
        @selector(directionalLight_1),
        @selector(directionalLight_2),
        @selector(pointLight),
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
    [self background:PBlackColor];
    [self noStroke];
    [self directionalLight:51 :102 :126 :-1 :0 :0];
    [self translate:20 :50 :0];
    [self sphere:30];
}

- (void)directionalLight_2
{
    [self background:PBlackColor];
    [self noStroke];
    [self directionalLight:51 :102 :126 :0 :-1 :0];
    [self translate:80 :50 :0];
    [self sphere:30];
}

- (void)pointLight
{
    [self background:PBlackColor];
    [self noStroke];
    [self pointLight:51 :102 :126 :35 :40 :36];
    [self translate:80 :50 :0];
    [self sphere:30];
}

@end
