//
//  MouseFunctions.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Processing.h"

@interface MouseFunctions : Processing {
    float bx;
    float by;
    int bs;
    BOOL bover;
    BOOL locked;
    float bdifx; 
    float bdify;     
}

@end
