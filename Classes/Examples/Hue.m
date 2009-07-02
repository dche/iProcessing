//
//  Hue.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-18.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Hue.h"

#define barWidth    5

@implementation Hue

- (void)setup
{
    [self size:200 :200];
    [self background:255];
    [self colorMode:HSB :360 :[self height] :[self height]];
    
    hue = (int *)malloc([self width]/barWidth * sizeof(int));
    [self noStroke];
}

- (void)draw
{
    int j = 0;
    float width = [self width];
    float height = [self height];
    for (int i=0; i<=(width-barWidth); i+=barWidth) {  
        if (([self mouseX] > i) && ([self mouseX] < i+barWidth)) {
            hue[j] = [self mouseY];
        }
        [self fill:hue[j] :height/1.2 :height/1.2];
        [self rect:i :0 :barWidth :height];
        j++;
    }    
}

@end
