//
//  ProcessingSpec.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-23.
//  Copyright 2009 campl software. All rights reserved.
//

#import "ProcessingSpec.h"

#define NSPEC   3

@interface ProcessingSpec ()

// Because |setup| is not called between specs, we must restore
// default drawing attributes by calling setDefaults.
- (void)setDefaults;

// Shape
- (void)arc;
- (void)ellipse;
- (void)line;

@end

@implementation ProcessingSpec

- (void)setup
{
    [self size:200 :200];    
    SEL selectors[] = {
        @selector(arc),
        @selector(ellipse),
        @selector(line)
    };
    specs = (SEL *)malloc(NSPEC * sizeof(SEL));
    memcpy(specs, selectors, sizeof(selectors));
}

- (void)draw
{
    int index = [self frameCount] % NSPEC;
    [self delay:10000]; // FIXME: delay will re-start loop even viewDidDisappear!
    [self setDefaults];
    [self performSelector:specs[index]];
}

- (void)dealloc
{
    free(specs);
    [super dealloc];
}

- (void)setDefaults
{    
    // fill color, stroke color, stroke cap, join and weight
    [self background:151];
    [self fill:[self color:251]];
    [self stroke:[self color:0]];
    [self strokeCap:ROUND];
    [self strokeJoin:MITER];
    [self strokeWeight:1];    
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

@end
