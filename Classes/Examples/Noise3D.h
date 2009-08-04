//
//  Noise3D.h
//  iProcessing
//
//  Created by Kenan Che on 09-08-05.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Processing.h"

@interface Noise3D : Processing {
    // The noise function's 3rd argument, a global variable that increments once per cycle
    float zoff;  
}

@end
