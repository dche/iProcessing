//
//  StoringInput.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-21.
//  Copyright 2009 campl software. All rights reserved.
//

#import "StoringInput.h"


@implementation StoringInput

- (void)setup
{
    [self size:200 :200];
    [self smooth];
    [self noStroke];
    [self fill:[self color:255 :153]];
}

- (void)draw
{
    [self background:[self color:51]];
    
    // Reads throught the entire array
    // and shifts the values to the left
    for(int i=1; i<num; i++) {
        mx[i-1] = mx[i];
        my[i-1] = my[i];
    } 
    // Add the new values to the end of the array
    mx[num-1] = [self mouseX];
    my[num-1] = [self mouseY];
        
    for(int i=0; i<num; i++) {
        [self ellipse:mx[i] :my[i] :i/2 :i/2];
    }
}

@end
