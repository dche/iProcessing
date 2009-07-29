//
//  TextureSphere.h
//  iProcessing
//
//  Created by Kenan Che on 09-07-15.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Processing.h"

@interface TextureSphere : Processing {
    PImage *texmap;
    int sDetail;
    
    float rotationX;
    float rotationY;
    float velocityX;
    float velocityY;
    float *sphereX;
    float *sphereY;
    float *sphereZ;
}

@end
