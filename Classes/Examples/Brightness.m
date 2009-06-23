/**
 * Brightness 
 * by Rusty Robison. 
 * 
 * Brightness is the relative lightness or darkness of a color.
 * Move the cursor vertically over each bar to alter its brightness. 
 */

//
//  Brightness.m
//  iProcessing
//
//  Translated by Diego Che on 09-06-22.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Brightness.h"

static const int barWidth = 5;

@implementation Brightness

- (void)setup
{
    [self size:200 :200];
    [self colorMode:HSB :360 :[self height] :[self height]];
    brightness = (int *)malloc([self width] / barWidth * sizeof(int));
}

- (void)draw
{
    int j = 0;
    for (int i = 0; i <= ([self width]-barWidth); i += barWidth) {  
        [self noStroke];
        if (([self mouseX] > i) && ([self mouseX] < i+barWidth)) {
            brightness[j] = [self mouseY];
        }
        [self fill:i :[self height] :brightness[j]];
        [self rect:i :0 :barWidth :[self height]];  
        j++;
    }
}

@end
