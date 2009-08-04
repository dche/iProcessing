//
//  SequentialAnim.h
//  iProcessing
//
//  Created by Kenan Che on 09-08-02.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Processing.h"

@interface SequentialAnim : Processing {
    int frame;
    PImage *images[12];
}

@end
