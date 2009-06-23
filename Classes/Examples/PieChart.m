/**
 * Pie Chart  
 * By Ira Greenberg 
 * 
 * Uses the arc() function to generate a pie chart from the data
 * stored in an array. 
 */

//
//  PieChart.m
//  iProcessing
//
//  Translated by Diego Che on 09-06-22.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PieChart.h"


@implementation PieChart

- (void)setup
{
    [self size:200 :200];
    [self background:100];
    [self smooth];
    [self noStroke];
    [self noLoop];
}

- (void)draw
{
    int diameter = 150;
    int angs[] = {30, 10, 45, 35, 60, 38, 75, 67};
    float lastAng = 0;
    
    [self noStroke];
    for (int i = 0; i < 8; i++){
        [self fill:angs[i] * 3.0];
        [self arc:[self width]/2 :[self height]/2 :diameter :diameter :lastAng :lastAng+[self radians:angs[i]]];
        lastAng += [self radians:angs[i]];  
    }    
}

@end
