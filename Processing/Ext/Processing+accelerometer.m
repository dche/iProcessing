//
//  Processing+accelerometer.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-28.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Processing+accelerometer.h"

@implementation Processing (Accelerometer)
@dynamic useAccelerometer;

- (BOOL)useAccelerometer
{
    return YES;
}

- (void)setUseAccelerometer:(BOOL)use
{
    
}

- (void)accelerometer:(UIAccelerometer *)accelerometer 
        didAccelerate:(UIAcceleration *)acceleration
{
    
}

@end
