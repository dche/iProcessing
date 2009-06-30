//
//  BezierEllipse.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-23.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Processing.h"

@interface BezierEllipse : Processing {
    float *px, *py, *cx, *cy, *cx2, *cy2;
    int pts;
}

@end
