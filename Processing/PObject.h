//
//  PObject.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Processing;

@interface PObject : NSObject {

@private
    /// Reference to Processing.
    Processing *p_;
}

@property (readonly) Processing *p;

- (id)initWithProcessing:(Processing *)p;

- (BOOL)update;
- (void)display;

@end
