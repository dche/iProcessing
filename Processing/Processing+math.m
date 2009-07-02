//
//  Processing+math+random.m
//  Processing Touch
//
//  Created by Kenan Che on 09-06-06.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Processing+math.h"

#pragma mark -
#pragma mark Perlin Noise
#pragma mark -




@implementation Processing (Math)

#pragma mark -
#pragma mark Calculation
#pragma mark -

- (float)abs:(float)x
{
    return (x < 0) ? (-x) : (x);
}

- (float)ceil:(float)x
{
    return ceilf(x);
}

- (float)constrain:(float)value :(float)min :(float)max
{
    return (value < min) ? (min) : ((value > max) ? (max) : (value));
}

- (float)dist:(float)x1 :(float)y1 :(float)x2 :(float)y2
{
    return sqrtf(powf((x2 - x1), 2) + powf((y2 - y1), 2));
}

- (float)dist:(float)x1 :(float)y1 :(float)z1 :(float)x2 :(float)y2 :(float)z2
{
    return sqrtf(powf((x2 - x1), 2) + powf((y2 - y1), 2) + powf((z2 - z1), 2));
}

- (float)exp:(float)x
{
    return expf(x);
}

- (float)floor:(float)x
{
    return floorf(x);
}

- (float)lerp:(float)value1 :(float)value2 :(float)amt
{
    return value1 + (value2 - value1) * amt;
}

/// Natural logrithm.
- (float)log:(float)x
{
    if (x <= EPSILON)
        return -MAXFLOAT;
    return logf(x);
}

/// Vector's magtitude.
- (float)mag:(float)a :(float)b
{
    return sqrtf(powf(a, 2) + powf(b, 2));;
}

- (float)mag:(float)a :(float)b :(float)c
{
    return sqrtf(powf(a, 2) + powf(b, 2) + powf(c, 2));
}

/// Re-maps a number from one range to another.
- (float)map:(float)value :(float)low1 :(float)high1 :(float)low2 :(float)high2
{
    if (fabsf(high1 - low1) < EPSILON) return low2;
    
    return (value - low1) / (high1 - low1) * (high2 - low2) + low2;
}

/// Determines the largest value in a sequence of numbers.
- (float)max:(float)value1 :(float)value2
{
    return (value2 > value1) ? (value2) : (value1);
}

- (float)max:(float)value1 :(float)value2 :(float)value3
{
    return [self max:value1 :[self max:value2 :value3]];
}

/// Determines the smallest value in a sequence of numbers.
- (float)min:(float)value1 :(float)value2
{
    return (value2 < value1) ? (value2) : (value1);
}

- (float)min:(float)value1 :(float)value2 :(float)value3
{
    return [self min:value1 :[self min:value2 :value3]];
}

/// Normalizes a number from another range into a value between 0 and 1.
/// Identical to map(value, low, high, 0, 1); 
- (float)norm:(float)value :(float)low :(float)high
{
    return [self map:value :low :high :0 :1];
}

- (float)pow:(float)num :(float)exponent
{
    // TODO: refine the protection.
    if (num < 0 && (exponent == floorf(exponent))) {
        return powf(-num, exponent);
    }
    return powf(num, exponent);
}

- (float)round:(float)x
{
    return roundf(x);
}

- (float)sq:(float)x
{
    return x * x;
}

- (float)sqrt:(float)x
{
    if (x < 0) return sqrtf(-x);
    return sqrtf(x);
}


#pragma mark -
#pragma mark Trigonometry
#pragma mark -

- (float)acos:(float)x
{
    float y = [self constrain:x :-1 :1];
    return acosf(y);
}

- (float)asin:(float)x
{
    float y = [self constrain:x :-1.0f :1.0f];
    return asinf(y);
}

- (float)atan:(float)x
{
    return atanf(x);
}

- (float)atan2:(float)y :(float)x
{
    return atan2f(y, x);
}

- (float)cos:(float)x
{
    return cosf(x);
}

- (float)degrees:(float)angle
{
    return angle * 180.0f / PI;
}

- (float)radians:(float)angle
{
    return angle * PI / 180.0f;
}

- (float)sin:(float)x
{
    return sinf(x);
}

- (float)tan:(float)x
{
    if (fabs(fmodf(x / HALF_PI, 2.0f) - 1.0f) < EPSILON) return 0;
    
    return tanf(x);
}


#pragma mark -
#pragma mark Noise and random
#pragma mark -

- (float)noise:(float)x
{
    return 0;
}

- (float)noise:(float)x :(float)y
{
    return 0;
}

- (float)noise:(float)x :(float)y :(float)z
{
    return 0;
}

- (void)noiseDetail:(int)octaves
{
    
}


- (void)noiseSeed:(int)x
{
    
}

- (float)random:(float)high
{
    return high * rand() / RAND_MAX;
}

- (float)random:(float)low :(float)high
{
    return low + (high - low) * rand() / RAND_MAX;
}

- (void)randomSeed:(unsigned int)value
{
    return srand(value);
}

@end
