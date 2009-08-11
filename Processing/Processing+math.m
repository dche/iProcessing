//
//  Processing+math+random.m
//  Processing Touch
//
//  Created by Kenan Che on 09-06-06.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Processing+math.h"

@interface Processing (PerlinNoise)

- (float)intNoise:(int)x;
- (float)intNoise:(int)x :(float)y;
- (float)intNoise:(int)x :(float)y :(float)z;
- (float)interpolatedNoise:(float)x;
- (float)interpolatedNoise:(float)x :(float)y;
- (float)interpolatedNoise:(float)x :(float)y :(float)z;

@end

@implementation Processing (PerlinNoise)

- (float)intNoise:(int)x
{
    // TODO: apply nosieSeed_.
    // TODO: TOO SLOOOOOOW! Even on Mac! Use LUT instead.
    x = (x<<13) ^ x;
    return (1.0 - ((x * (x * x * 15731 + 789221) + 1376312589) & 0x7fffffff) / 2147483648.0f);
}

- (float)intNoise:(int)x :(float)y
{
    return [self intNoise:x + y * 57];
}

- (float)intNoise:(int)x :(float)y :(float)z
{
    return [self intNoise:x + y * 57 + z * 96847];
}

- (float)interpolatedNoise:(float)x
{
    int ix = floorf(x);
    float fx = x - ix;
    
    return cosineInterpolate([self intNoise:ix], [self intNoise:ix + 1], fx);
}

- (float)interpolatedNoise:(float)x :(float)y
{
    int ix = floorf(x);
    float fx = x - ix;
    int iy = floorf(y);
    float fy = y - iy;
    
    float v0 = [self intNoise:ix :iy];    
    float v1 = [self intNoise:ix :iy + 1];
    float v2 = [self intNoise:ix + 1 :iy];
    float v3 = [self intNoise:ix + 1 :iy + 1];
    
    return cosineInterpolate(cosineInterpolate(v0, v1, fy), cosineInterpolate(v2, v3, fy), fx);
}

- (float)interpolatedNoise:(float)x :(float)y :(float)z
{
    int ix = floorf(x);
    float fx = x - ix;
    int iy = floorf(y);
    float fy = y - iy;
    int iz = floorf(z);
    float fz = z - iz;
    
    float v0 = [self intNoise:ix :iy :iz];
    float v1 = [self intNoise:ix :iy + 1 :iz];
    float v2 = [self intNoise:ix + 1 :iy :iz];
    float v3 = [self intNoise:ix + 1 :iy + 1 :iz];
    float v4 = [self intNoise:ix :iy :iz + 1];
    float v5 = [self intNoise:ix :iy + 1 :iz + 1];
    float v6 = [self intNoise:ix + 1 :iy :iz + 1];
    float v7 = [self intNoise:ix + 1 :iy + 1 :iz + 1];
    
    float back = cosineInterpolate(cosineInterpolate(v0, v1, fy), cosineInterpolate(v2, v3, fy), fx);
    float front = cosineInterpolate(cosineInterpolate(v4, v5, fy), cosineInterpolate(v6, v7, fy), fx);
    
    return cosineInterpolate(back, front, fz);
}

@end


@implementation Processing (Math)

#pragma mark -
#pragma mark Calculation
#pragma mark -

- (float)abs:(float)x
{
    return p_abs(x);
}

- (float)ceil:(float)x
{
    return p_ceil(x);
}

- (float)constrain:(float)value :(float)min :(float)max
{
    return p_constrain(value, min, max);
}

- (float)dist:(float)x1 :(float)y1 :(float)x2 :(float)y2
{
    return p_dist(x1, y1, x2, y2, 0, 0);
}

- (float)dist:(float)x1 :(float)y1 :(float)z1 :(float)x2 :(float)y2 :(float)z2
{
    return p_dist(x1, y1, z1, x2, y2, z2);
}

- (float)exp:(float)x
{
    return p_exp(x);
}

- (float)floor:(float)x
{
    return p_floor(x);
}

- (float)lerp:(float)value1 :(float)value2 :(float)amt
{
    return p_lerp(value1, value2, amt);
}

/// Natural logrithm.
- (float)log:(float)x
{
    return p_log(x);
}

/// Vector's magtitude.
- (float)mag:(float)a :(float)b
{
    return p_mag(a, b, 0);
}

- (float)mag:(float)a :(float)b :(float)c
{
    return p_mag(a, b, c);
}

/// Re-maps a number from one range to another.
- (float)map:(float)value :(float)low1 :(float)high1 :(float)low2 :(float)high2
{
    if (p_abs(high1 - low1) < EPSILON) return low2;
    
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
    return p_sq(x);
}

- (float)sqrt:(float)x
{
    return p_sqrt(x);
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
    return p_sin(x);
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
    float n = 0;
    for (int i = 0; i < noiseOctaves_; i++) {
        n += [self interpolatedNoise:x * [self pow:2 :i]] * 0.5f * [self pow:noiseFalloff_ :i];
    }
    return n;
}

- (float)noise:(float)x :(float)y
{
    float n = 0;
    for (int i = 0; i < noiseOctaves_; i++) {
        float f = [self pow:2 :i];
        n += [self interpolatedNoise:x * f :y * f] * 0.5f * [self pow:noiseFalloff_ :i];
    }
    return n;
}

- (float)noise:(float)x :(float)y :(float)z
{
    float n = 0;
    for (int i = 0; i < noiseOctaves_; i++) {
        float f = [self pow:2 :i];
        n += [self interpolatedNoise:x * f :y * f :z * f] * 0.5f * [self pow:noiseFalloff_ :i];
    }
    return n;
}

- (void)noiseDetail:(int)octaves
{
    [self noiseDetail:octaves :0.5f];
}

- (void)noiseDetail:(int)octaves :(float)falloff
{
    noiseOctaves_ = (octaves < 1) ? 1 : octaves;
    noiseFalloff_ = [self constrain:falloff :0 :1];
}


- (void)noiseSeed:(int)x
{
    noiseSeed_ = x;
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
