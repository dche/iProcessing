//
//  PolarToCartesian.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Processing.h"

@interface PolarToCartesian : Processing {
    float r;
    
    // Angle and angular velocity, accleration
    float theta;
    float theta_vel;
    float theta_acc;    
}

@end
