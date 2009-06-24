//
//  SineWave.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Processing.h"

@interface SineWave : Processing {
    int w;              // Width of entire wave
    
    float theta;  // Start angle at 0
    float amplitude;  // Height of wave
    float period;  // How many pixels before the wave repeats
    float dx;         // Value for incrementing X, a function of period and xspacing
    float *yvalues;  // Using an array to store height values for the wave    
}

@end
