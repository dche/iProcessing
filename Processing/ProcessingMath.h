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

static inline float p_map(float x, float low1, float high1, float low2, float high2)
{
    if (p_abs(high1 - low1) < EPSILON) return low2;
    
    return (x - low1) * (high2 - low2) / (high1 - low1)  + low2;    
}

static inline float p_max(float x, float y)
{
    return x > y ? x : y;
}

static inline float p_max3(float x, float y, float z)
{
    return p_max(p_max(x, y), z);
}

static inline float p_min(float x, float y)
{
    return x < y ? x : y;
}

static inline float p_min3(float x, float y, float z)
{
    return p_min(p_min(x, y), z);
}

static inline float p_norm(float x, float low, float high)
{
    return p_map(x, low, high, 0, 1);
}

static inline float p_pow(float x, float exp)
{
    if (x < 0 && (exp != p_floor(exp))) {
        return powf(-x, p_floor(exp));
    }
    return powf(x, exp);
}

static inline float p_round(float x)
{
    return roundf(x);
}

static inline float p_sq(float x)
{
    return x * x;
}

//
//=== Trigonometry
//
static inline float p_acos(float x)
{
    return acosf(p_constrain(x, -1, 1));
}

static inline float p_asin(float x)
{
    return asinf(p_constrain(x, -1, 1));
}

static inline float p_atan(float x)
{
    return atanf(x);
}

static inline float p_atan2(float y, float x)
{
    return atan2f(y, x);
}

static inline float p_cos(float x)
{
    return cosf(x);
}

static inline float p_degrees(float x)
{    
    return x * 180.0f / PI;
}

static inline float p_radians(float x)
{
    return x * PI / 180.0f;
}

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

static inline float p_tan(float x)
{
    if (fabs(fmodf(x / HALF_PI, 2.0f) - 1.0f) < EPSILON) return 0;
    
    return tanf(x);
}

static inline float cosineInterpolate(float a, float b, float x)
{
    if (x == 0) return a;
    if (x == 1) return b;
    
    float ft = x * PI;
	float f = (1 - cosf(ft)) * 0.5f;
    
	return a*(1-f) + b*f;    
}
