//
//  ProcessingSpec.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-23.
//  Copyright 2009 campl software. All rights reserved.
//

#import "ProcessingSpec.h"

#define NSPEC   6

@interface ProcessingSpec ()

// Shape
- (void)arc;
- (void)ellipse;
- (void)line;

// Transformation
- (void)rotate;
- (void)scale;
- (void)translate;

@end

@implementation ProcessingSpec

- (void)setup
{
    [self size:200 :200];    
    SEL selectors[] = {
        @selector(arc),
        @selector(ellipse),
        @selector(line),
        @selector(rotate),
        @selector(translate),
        @selector(scale),
    };
    specs = (SEL *)malloc(NSPEC * sizeof(SEL));
    memcpy(specs, selectors, sizeof(selectors));
}

- (void)draw
{
    int index = [self frameCount] % NSPEC;
    [self delay:10000]; // FIXME: delay will re-start loop even viewDidDisappear!
    
    [self background:151];
    [self pushStyle];
    [self performSelector:specs[index]];
    [self popStyle];
}

- (void)dealloc
{
    free(specs);
    [super dealloc];
}

#pragma mark -
#pragma mark Shape
#pragma mark -

- (void)arc
{
    [self arc:50 :55 :50 :50 :0 :PI/2];
    [self noFill];
    [self arc:50 :55 :60 :60 :PI/2 :PI];
    [self arc:50 :55 :70 :70 :PI :TWO_PI-PI/2];
    [self arc:50 :55 :80 :80 :TWO_PI-PI/2 :TWO_PI];
}

- (void)ellipse
{
    [self ellipse:56 :46 :55 :55];
}

- (void)line
{
    [self line:30 :20 :85 :75];
    
    [self line:30 :20 :85 :20];
    [self stroke:126];
    [self line:85 :20 :85 :75];
    [self stroke:255];
    [self line:85 :75 :30 :75];
    
    // TODO: 3D spec.
}

#pragma mark -
#pragma mark Transformation
#pragma mark -

- (void)rotate
{
    [self translate:[self width]/2 :[self height]/2];
    [self rotate:PI/3.0];
    [self rect:-26 :-26 :52 :52];
}

- (void)scale
{
    [self rect:30 :20 :50 :50];
    [self scale:0.5 :1.3];
    [self rect:30 :20 :50 :50];
}

- (void)translate
{
    [self translate:30 :20];
    [self rect:0 :0 :55 :55];
    [self translate:14 :14];
    [self rect:0 :0 :55 :55];
}

@end
