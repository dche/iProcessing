//
//  PAnimatable.h
//  iProcessing
//
//  Created by Kenan Che on 10-04-03.
//  Copyright 2010 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAnimation.h"

@interface PAnimatable : NSObject
{
@private
    PAnimation *anim_;
    
    /// The start value.
    float start_;
    /// The end value.
    float end_;
    /// The timeline function.
    timelineFunc timeline_;
    
    /// If YES, the start value when the animation starts is used.
    /// Default is YES. Set the startValue property changes it to NO.
    BOOL dynamicStarting_;
    /// If YES, state value is the value returned by timeline().
    BOOL dynamicEnding_;
}

@property (nonatomic) float startValue;
@property (nonatomic) float endValue;

@property (nonatomic) timelineFunc timeline;

- (id)initWithAnimation:(PAnimation *)anim;
/// Update the state with new value. Called by the PAnimation object that
/// contains the receiver.
- (void)update:(float)value;

@end

