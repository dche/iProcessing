//
//  Processing+math+random.h
//  Processing Touch
//
//  Created by Kenan Che on 09-06-06.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Processing+core.h"

@interface Processing (Math)


#pragma mark -
#pragma mark Calculation
#pragma mark -

- (float)abs:(float)x;
- (float)ceil:(float)x;
/// Constrains a value to not exceed a maximum and minimum value.
- (float)constrain:(float)value :(float)min :(float)max;
- (float)dist:(float)x1 :(float)y1 :(float)x2 :(float)y2;
- (float)dist:(float)x1 :(float)y1 :(float)z1 :(float)x2 :(float)y2 :(float)z2;
- (float)exp:(float)x;
- (float)floor:(float)x;
- (float)lerp:(float)value1 :(float)value2 :(float)amt;
/// Natural logrithm.
- (float)log:(float)x;
/// Vector's magtitude.
- (float)mag:(float)a :(float)b;
- (float)mag:(float)a :(float)b :(float)c;
/// Re-maps a number from one range to another.
- (float)map:(float)value :(float)low1 :(float)high1 :(float)low2 :(float)high2;
/// Determines the largest value in a sequence of numbers.
- (float)max:(float)value1 :(float)value2;
- (float)max:(float)value1 :(float)value2 :(float)value3;
/// Determines the smallest value in a sequence of numbers.
- (float)min:(float)value1 :(float)value2;
- (float)min:(float)value1 :(float)value2 :(float)value3;
/// Normalizes a number from another range into a value between 0 and 1.
/// Identical to map(value, low, high, 0, 1); 
- (float)norm:(float)value :(float)low :(float)high;
- (float)pow:(float)num :(float)exponent;
- (float)round:(float)x;
- (float)sq:(float)x;
- (float)sqrt:(float)x;

#pragma mark -
#pragma mark Trigonometry
#pragma mark -

- (float)acos:(float)x;
- (float)asin:(float)x;
- (float)atan:(float)x;
- (float)atan2:(float)y :(float)x;
- (float)cos:(float)x;
- (float)degrees:(float)angle;
- (float)radians:(float)angle;
- (float)sin:(float)x;
- (float)tan:(float)x;

#pragma mark -
#pragma mark Noise and random
#pragma mark -

- (float)noise:(float)x;
- (float)noise:(float)x :(float)y;
- (float)noise:(float)x :(float)y :(float)z;
- (void)noiseDetail:(int)octaves;
- (void)noiseDetail:(int)octaves :(float)falloff;
- (void)noiseSeed:(int)x;
- (float)random:(float)high;
- (float)random:(float)low :(float)high;
- (void)randomSeed:(unsigned int)value;

@end
