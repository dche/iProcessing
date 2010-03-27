//
//  PAnimation.h
//  iProcessing
//
//  Created by Kenan Che on 09-08-02.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PAnimation : NSObject {

@private
    /// animation duration in milliseconds.
    NSUInteger duration_;
}

- (void)drawFrame:(NSUInteger)frame;

@end
