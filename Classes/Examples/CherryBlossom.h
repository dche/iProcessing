//
//  CherryBlossom.h
//  iProcessing
//
//  Created by Kenan Che on 09-07-30.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Processing.h"

typedef struct {
    float x;
    float y;
} Position;

@interface Branch : PObject
{
@private
    int generation; 
    int steps; 
    Position position; 
    float angle; 
    float maxAngleVar; 
    BOOL active; 
    
    int maxSteps; 
    float stepLength;
}

@property (nonatomic, readonly) int steps;
@property (nonatomic, readonly) int generation;
@property (nonatomic, readonly) Position position;
@property (nonatomic, assign) BOOL active;

- (id)initWithProcessing:(Processing *)p generation:(int)gen maxStep:(int)maxStep position:(Position)pos angle:(float)ang;
- (void)drawStep;
- (Branch *)generateChild:(int)cn;

@end

@interface CherryBlossom : Processing {
    int nextSlot;
    Branch **branches;
}

@end
