/**
 * Saturation. 
 * 
 * Saturation is the strength or purity of the color and represents the 
 * amount of gray in proportion to the hue. A "saturated" color is pure 
 * and an "unsaturated" color has a large percentage of gray. 
 * Move the cursor vertically over each bar to alter its saturation. 
 */

//
//  Saturation.m
//  iProcessing
//
//  Translated by Diego Che on 09-06-22.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Saturation.h"

static const int barWidth = 5;

@implementation Saturation

- (void)setup
{
    [self size:200 :200];
    [self colorMode:HSB :360 :[self height] :[self height]];
    saturation = (int *)malloc([self width]/barWidth * sizeof(int));
}

- (void)draw
{
    int j = 0;
    for (int i=0; i<=([self width]-barWidth); i+=barWidth) {  
        [self noStroke];
        if (([self mouseX] > i) && ([self mouseX] < i+barWidth)) {
            saturation[j] = [self mouseY];
        }
        [self fill:i :saturation[j] :[self height]/1.5];
        [self rect:i :0 :barWidth :[self height]];  
        j++;
    }
}

@end
