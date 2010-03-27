//
//  PWorld.h
//  iProcessing
//
//  Created by Kenan Che on 09-08-13.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Processing.h"
#import "PObject.h"

@interface PWorld : Processing {

@private
    /// List of all PObjects in the world.
    NSMutableArray *objects_;
    
    
}

/// Create a new world with given size.
/// This method is typically called by a UIApplication delegate.
+ (PWorld *)newWorld;
/// Get current world.
+ (PWorld *)world;

- (void)run;

- (void)addObject:(PObject *)o;
- (void)removeObject:(PObject *)o;

@end
