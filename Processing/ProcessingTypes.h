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

typedef enum {
    PBlackColor = ALPHA_MASK,
    PWhiteColor = 0xFFFFFFFF,
    PRedColor = ALPHA_MASK | RED_MASK,
    PGreenColor = ALPHA_MASK | GREEN_MASK,
    PBlueColor = ALPHA_MASK | BLUE_MASK,
    PGrayColor = 0xFF808080,
} PColorConstants;

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

typedef PVertex PVector;

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
    kPVectorNormal,
    kPColorFill,
    kPColorStroke,
} PVertexType;

#define PVertexNormal       kPVertextNormal
#define PVertexBezier       kPVertextBezier
#define PVertexCurve        kPVertextCurve
#define PVectorNormal       kPVectorNormal
#define PColorFill          kPColorFill
#define PColorStroke        kPColorStroke

#pragma mark -
#pragma mark Matrix3D
#pragma mark -

typedef float Matrix3D[16];
