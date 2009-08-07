/*
 *  ProcessingTypes.h
 *  iProcessing
 *
 *  Created by Kenan Che on 09-06-27.
 *  Copyright 2009 campl software. All rights reserved.
 *
 */

/* 
 These defines, the fast sine function, and the vectorized version of the 
 matrix multiply function below are based on the Matrix4Mul method from 
 the vfp-math-library. Thi code has been modified, and are subject to  
 the original license terms and ownership as follow:
 
 VFP math library for the iPhone / iPod touch
 
 Copyright (c) 2007-2008 Wolfgang Engel and Matthias Grundmann
 http://code.google.com/p/vfpmathlibrary/
 
 This software is provided 'as-is', without any express or implied warranty.
 In no event will the authors be held liable for any damages arising
 from the use of this software.
 Permission is granted to anyone to use this software for any purpose,
 including commercial applications, and to alter it and redistribute it freely,
 subject to the following restrictions:
 
 1. The origin of this software must not be misrepresented; you must
 not claim that you wrote the original software. If you use this
 software in a product, an acknowledgment in the product documentation
 would be appreciated but is not required.
 
 2. Altered source versions must be plainly marked as such, and must
 not be misrepresented as being the original software.
 
 3. This notice may not be removed or altered from any source distribution.
 */

#import "ProcessingMacros.h"
#import "ProcessingMath.h"

#pragma mark -
#pragma mark Color Manipulation
#pragma mark -

typedef enum {
    PBlackColor = ALPHA_MASK,
    PWhiteColor = 0xFFFFFFFF,
    PFullColor = PBlackColor ^ PWhiteColor,
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

static inline color hexColor(UInt32 hexdec)
{
    color c = hexdec;
    if (c < 0xFF000000) {
        c = (c << 8) ^ 0xFF;
    }
    return CFSwapInt32HostToBig(c);
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
#define PNormalVector       kPNormalVector
#define PColorFill          kPColorFill
#define PColorStroke        kPColorStroke

#pragma mark -
#pragma mark Matrix3D
#pragma mark -

typedef struct {
    float m00, m10, m20, m30;
    float m01, m11, m21, m31;
    float m02, m12, m22, m32;
    float m03, m13, m23, m33;
} Matrix3D;

static inline void printMatrix3D(Matrix3D *m)
{
    NSLog(@"\n| %f\t%f\t%f\t%f |\n| %f\t%f\t%f\t%f |\n| %f\t%f\t%f\t%f |\n| %f\t%f\t%f\t%f |\n", 
          m->m00, m->m01, m->m02, m->m03,
          m->m10, m->m11, m->m12, m->m13,
          m->m20, m->m21, m->m22, m->m23,
          m->m30, m->m31, m->m32, m->m33);    
}

static inline void Matrix3DSet(Matrix3D *m, float m00, float m01, float m02, float m03, 
                               float m10, float m11, float m12, float m13, 
                               float m20, float m21, float m22, float m23, 
                               float m30, float m31, float m32, float m33)
{
    m->m00 = m00;m->m01 = m01;m->m02 = m02;m->m03 = m03;
    m->m10 = m10;m->m11 = m11;m->m12 = m12;m->m13 = m13;
    m->m20 = m20;m->m21 = m21;m->m22 = m22;m->m23 = m23;
    m->m30 = m30;m->m31 = m31;m->m32 = m32;m->m33 = m33;
}

#if TARGET_OS_IPHONE && !TARGET_IPHONE_SIMULATOR
#define VFP_CLOBBER_S0_S31 "s0", "s1", "s2", "s3", "s4", "s5", "s6", "s7", "s8",  \
"s9", "s10", "s11", "s12", "s13", "s14", "s15", "s16",  \
"s17", "s18", "s19", "s20", "s21", "s22", "s23", "s24",  \
"s25", "s26", "s27", "s28", "s29", "s30", "s31"
#define VFP_VECTOR_LENGTH(VEC_LENGTH) "fmrx    r0, fpscr                         \n\t" \
"bic     r0, r0, #0x00370000               \n\t" \
"orr     r0, r0, #0x000" #VEC_LENGTH "0000 \n\t" \
"fmxr    fpscr, r0                         \n\t"
#define VFP_VECTOR_LENGTH_ZERO "fmrx    r0, fpscr            \n\t" \
"bic     r0, r0, #0x00370000  \n\t" \
"fmxr    fpscr, r0            \n\t" 
#endif
static inline void Matrix3DMultiply(const Matrix3D *m1, const Matrix3D *m2, Matrix3D *result)
{
#if TARGET_OS_IPHONE && !TARGET_IPHONE_SIMULATOR
    __asm__ __volatile__ ( VFP_VECTOR_LENGTH(3)
                          
                          // Interleaving loads and adds/muls for faster calculation.
                          // Let A:=src_ptr_1, B:=src_ptr_2, then
                          // function computes A*B as (B^T * A^T)^T.
                          
                          // Load the whole matrix into memory.
                          "fldmias  %2, {s8-s23}    \n\t"
                          // Load first column to scalar bank.
                          "fldmias  %1!, {s0-s3}    \n\t"
                          // First column times matrix.
                          "fmuls s24, s8, s0        \n\t"
                          "fmacs s24, s12, s1       \n\t"
                          
                          // Load second column to scalar bank.
                          "fldmias %1!,  {s4-s7}    \n\t"
                          
                          "fmacs s24, s16, s2       \n\t"
                          "fmacs s24, s20, s3       \n\t"
                          // Save first column.
                          "fstmias  %0!, {s24-s27}  \n\t" 
                          
                          // Second column times matrix.
                          "fmuls s28, s8, s4        \n\t"
                          "fmacs s28, s12, s5       \n\t"
                          
                          // Load third column to scalar bank.
                          "fldmias  %1!, {s0-s3}    \n\t"
                          
                          "fmacs s28, s16, s6       \n\t"
                          "fmacs s28, s20, s7       \n\t"
                          // Save second column.
                          "fstmias  %0!, {s28-s31}  \n\t" 
                          
                          // Third column times matrix.
                          "fmuls s24, s8, s0        \n\t"
                          "fmacs s24, s12, s1       \n\t"
                          
                          // Load fourth column to scalar bank.
                          "fldmias %1,  {s4-s7}    \n\t"
                          
                          "fmacs s24, s16, s2       \n\t"
                          "fmacs s24, s20, s3       \n\t"
                          // Save third column.
                          "fstmias  %0!, {s24-s27}  \n\t" 
                          
                          // Fourth column times matrix.
                          "fmuls s28, s8, s4        \n\t"
                          "fmacs s28, s12, s5       \n\t"
                          "fmacs s28, s16, s6       \n\t"
                          "fmacs s28, s20, s7       \n\t"
                          // Save fourth column.
                          "fstmias  %0!, {s28-s31}  \n\t" 
                          
                          VFP_VECTOR_LENGTH_ZERO
                          : "=r" (result), "=r" (m2)
                          : "r" (m1), "0" (result), "1" (m2)
                          : "r0", "cc", "memory", VFP_CLOBBER_S0_S31
                          );
#else
    result->m00 = m2->m00 * m1->m00 + m2->m10 * m1->m01 + m2->m20 * m1->m02 + m2->m30 * m1->m03;
    result->m01 = m2->m01 * m1->m00 + m2->m11 * m1->m01 + m2->m21 * m1->m02 + m2->m31 * m1->m03;
    result->m02 = m2->m02 * m1->m00 + m2->m12 * m1->m01 + m2->m22 * m1->m02 + m2->m32 * m1->m03;
    result->m03 = m2->m03 * m1->m00 + m2->m13 * m1->m01 + m2->m23 * m1->m02 + m2->m33 * m1->m03;
    
    result->m10 = m2->m00 * m1->m10 + m2->m10 * m1->m11 + m2->m20 * m1->m12 + m2->m30 * m1->m13;
    result->m11 = m2->m01 * m1->m10 + m2->m11 * m1->m11 + m2->m21 * m1->m12 + m2->m31 * m1->m13;
    result->m12 = m2->m02 * m1->m10 + m2->m12 * m1->m11 + m2->m22 * m1->m12 + m2->m32 * m1->m13;
    result->m13 = m2->m03 * m1->m10 + m2->m13 * m1->m11 + m2->m23 * m1->m12 + m2->m33 * m1->m13;
    
    result->m20 = m2->m00 * m1->m20 + m2->m10 * m1->m21 + m2->m20 * m1->m22 + m2->m30 * m1->m23;
    result->m21 = m2->m01 * m1->m20 + m2->m11 * m1->m21 + m2->m21 * m1->m22 + m2->m31 * m1->m23;
    result->m22 = m2->m02 * m1->m20 + m2->m12 * m1->m21 + m2->m22 * m1->m22 + m2->m32 * m1->m23;
    result->m23 = m2->m03 * m1->m20 + m2->m13 * m1->m21 + m2->m23 * m1->m22 + m2->m33 * m1->m23;
    
    result->m30 = m2->m00 * m1->m30 + m2->m10 * m1->m31 + m2->m20 * m1->m32 + m2->m30 * m1->m33;
    result->m31 = m2->m01 * m1->m30 + m2->m11 * m1->m31 + m2->m21 * m1->m32 + m2->m31 * m1->m33;
    result->m32 = m2->m02 * m1->m30 + m2->m12 * m1->m31 + m2->m22 * m1->m32 + m2->m32 * m1->m33;
    result->m33 = m2->m03 * m1->m30 + m2->m13 * m1->m31 + m2->m23 * m1->m32 + m2->m33 * m1->m33;
#endif
}

static void inline Matrix3DApply(Matrix3D *m, const Matrix3D *mm) 
{
    Matrix3D r;
    Matrix3DMultiply(m, mm, &r);
    memcpy(m, &r, sizeof(Matrix3D));
}

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
