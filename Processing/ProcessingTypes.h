/*
 *  ProcessingTypes.h
 *  iProcessing
 *
 *  Created by Kenan Che on 09-06-27.
 *  Copyright 2009 campl software. All rights reserved.
 *
 */

#import "ProcessingMacros.h"

#pragma mark -
#pragma mark Color Manipulation
#pragma mark -

typedef struct {
    float red;
    float green;
    float blue;
    float alpha;
} PColor;

static inline UInt8 colorValue(color clr, unsigned int component)
{
    if (component > 3) return 0;
    return (clr >> ((3 - component) * 8) & 0xFF);
}

static inline float originalRGBValue(color clr, unsigned int component, float range)
{
    if (component > 3) return 0;
    return colorValue(clr, component) * range / 255.0f;
}

static inline float PColorNorm(color clr, unsigned int component)
{
    UInt8 cv = colorValue(clr, component);
    return cv / 255.0f;
}

static inline PColor PColorMake(color clr)
{
    PColor pc;
    pc.red = PColorNorm(clr, R);
    pc.green = PColorNorm(clr, G);
    pc.blue = PColorNorm(clr, B);
    pc.alpha = PColorNorm(clr, A);
    return pc;
}

static inline void PColorSet(PColor *pc, float r, float g, float b, float a)
{
    pc->red = r;
    pc->green = g;
    pc->blue = b;
    pc->alpha = a;
}

#pragma mark -
#pragma mark Vertex
#pragma mark -

typedef struct {
    float x;
    float y;
    float z;
} PVertex;

static inline PVertex PVertexMake(float fx, float fy, float fz)
{
	PVertex pv;
	pv.x = fx;
	pv.y = fy;
	pv.z = fz;
	return pv;
}

typedef enum {
    kPVertextNormal = 0,
    kPVertextBezier,
    kPVertextCurve,
} PVertexType;

#define PVertexNormal       kPVertextNormal
#define PVertexBezier       kPVertextBezier
#define PVertexCurve        kPVertextCurve

