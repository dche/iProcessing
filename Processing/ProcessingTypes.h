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
    PGrayColor = ALPHA_MASK | 0x80808080,
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

static inline void PVertexSet(PVertex *v, float x, float y, float z)
{
    v->x = x;
    v->y = y;
    v->z = z;
}

static inline void PVectorAdd(PVector *v, const PVector *va)
{
    v->x += va->x;
    v->y += va->y;
    v->z += va->z;
}

static inline void PVectorSub(PVector *v, const PVector *vs)
{
    v->x -= vs->x;
    v->y -= vs->y;
    v->z -= vs->z;
}

static inline void PVectorScalarMult(PVector *v, float f)
{
    v->x *= f;
    v->y *= f;
    v->z *= f;
}

static inline PVector PVectorCross(PVector vr, PVector vl)
{
    PVector v;
    v.x = vr.y * vl.z - vr.z * vl.y;
    v.y = vr.z * vl.x - vr.x * vl.z;
    v.z = vr.x * vl.y - vr.y * vl.x;
    return v;
}

static inline void PVectorNormalize(PVector *v)
{
    float mag = sqrtf(v->x * v->x + v->y * v->y + v->z * v->z);

    if (mag > 0) {
        v->x /= mag;
        v->y /= mag;
        v->z /= mag;
    }
}

static inline PVector PVertexSub(PVertex vs, PVertex ve)
{
    PVector v;
    v.x = ve.x - vs.x;
    v.y = ve.y - vs.y;
    v.z = ve.z - vs.z;
    return v;
}

typedef enum {
    kPVertexNormal = 0,
    kPVertexBezier,
    kPVertexCurve,
    kPNormalVector,
    kPColorFill,
    kPColorStroke,
} PVertexType;

#define PVertexNormal       kPVertexNormal
#define PVertexBezier       kPVertexBezier
#define PVertexCurve        kPVertexCurve
#define PNormalVector       kPNormalVector
#define PColorFill          kPColorFill
#define PColorStroke        kPColorStroke

#pragma mark -
#pragma mark Matrix3D
#pragma mark -

typedef struct {
    float m0, m1, m2, m3;
    float m4, m5, m6, m7;
    float m8, m9, m10, m11;
    float m12, m13, m14, m15;
} Matrix3D;

// TODO: matrix code in asm.

#pragma mark -
#pragma mark Texture
#pragma mark -

typedef struct {
    float u;
    float v;
} PTextureCoord;


static inline PTextureCoord PTextureCoordMake(float u, float v)
{
    PTextureCoord tc;
    tc.u = u; tc.v = v;
    
    return tc;
}
