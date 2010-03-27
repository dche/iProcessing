//
//  PAgent.h
//  iProcessing
//
//  Created by Kenan Che on 09-07-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PObject.h"

@class PWorld;

@interface PAgent : PObject {

@private
    /// The unique id of a Agent.
    NSUInteger tag_;
    /// Age, in millisecond.
    NSUInteger birthTime_;
    
@protected
    /// Gene of the agent.
    NSUInteger gene_;
}

@property (nonatomic, readonly) NSUInteger age;
@property (nonatomic, readonly) NSUInteger tag;

- (id)initWithProcessing:(Processing *)p;

- (PAgent *)clone;
- (PAgent *)offspring:(PAgent *)a;

@end
