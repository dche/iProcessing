/*
 *  ProcessingMath.h
 *  iProcessing
 *
 *  Created by Kenan Che on 09-07-31.
 *  Copyright 2009 campl software. All rights reserved.
 *
 */

//+abs()
//+ceil()
//+constrain()
//+dist()
//+exp()
//+floor()
//+lerp()
//+log()
//+mag()
//+map()
//+max()
//+min()
//+norm()
//+pow()
//+round()
//+sq()
//+sqrt()
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
//+sin()
//+tan()
//
//=== Random
//+noise()
//+noiseDetail()
//+noiseSeed()
//+random()
//+randomSeed()

static inline float cosineInterpolate(float a, float b, float x)
{
    if (x == 0) return a;
    if (x == 1) return b;
    
    float ft = x * PI;
	float f = (1 - cosf(ft)) * 0.5f;
    
	return a*(1-f) + b*f;    
}
