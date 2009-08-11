//
//  PAgent.h
//  iProcessing
//
//  Created by Kenan Che on 09-07-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PObject.h"

@class Processing;

@interface PAgent : PObject {

@private
    /// The unique id of a Agent.
    NSUInteger tag_;
    NSUInteger gene_;
    /// Age.
    NSUInteger birthTime_;
}

@property (nonatomic, readonly) NSUInteger age;

- (id)initWithProcessing:(Processing *)p;
- (PAgent *)offspring:(PAgent *)a;

@end
