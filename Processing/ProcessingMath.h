/*
 *  ProcessingMath.h
 *  iProcessing
 *
 *  Created by Kenan Che on 09-07-31.
 *  Copyright 2009 campl software. All rights reserved.
 *
 */
static inline float p_sqrt(float x)
{
    if (x < 0) 
        return sqrtf(-x);
    else 
        return sqrtf(x);
}

static inline float p_abs(float x)
{
    return (x < 0) ? (-x) : (x);
}

static inline float p_ceil(float x)
{
    return ceilf(x);
}

static inline float p_constrain(float x, float min, float max)
{
    return (x < min) ? (min) : ((x > max) ? (max) : (x));
}

static inline float p_dist(float x1, float y1, float z1, float x2, float y2, float z2)
{
    return p_sqrt(powf((x2 - x1), 2) + powf((y2 - y1), 2) + powf((z2 - z1), 2));
}

static inline float p_exp(float x)
{
    return expf(x);
}

static inline float p_floor(float x)
{
    return floorf(x);
}

static inline float p_lerp(float a, float b, float amt)
{
    if (amt == 0) return a;
    if (amt == 1) return b;
    
    return a + amt * (b - a);
}

static inline float p_log(float x)
{
    if (x <= EPSILON)
        return -MAXFLOAT;
    return logf(x);
}

static inline float p_mag(float a, float b, float c)
{
    return p_sqrt(a * a + b * b + c * c);
}

static inline float p_mag_inv(float a, float b, float c)
{
    return 0;
}

//+map()
//+max()
//+min()
//+norm()
//+pow()
//+round()
static inline float p_sq(float x)
{
    return x * x;
}

//
//=== Trigonometry
//
//+acos()
//+asin()
//+atan()
//+atan2()
//+cos()
//+degrees()
//+radians()

static inline float p_sin(float x)
{
	const float P = 0.225f;
	
	x = x * M_1_PI;
	int k = (int)round(x);
	x = x - k;
    
	float y = (4 - 4 * p_abs(x)) * x;    
	y = P * (y * p_abs(y) - y) + y;
    
	return (k&1) ? -y : y;
}

//+tan()
//

static inline float cosineInterpolate(float a, float b, float x)
{
    if (x == 0) return a;
    if (x == 1) return b;
    
    float ft = x * PI;
	float f = (1 - cosf(ft)) * 0.5f;
    
	return a*(1-f) + b*f;    
}
