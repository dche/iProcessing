//
//  NoiseWave.h
//  iProcessing
//
//  Created by Kenan Che on 09-08-05.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Processing.h"

@interface NoiseWave : Processing {
    float *yvalues;          // Using an array to store height values for the wave (not entirely necessary)
    int w;              // Width of entire wave
    
    float yoff;        // 2nd dimension of perlin noise
}

@end
