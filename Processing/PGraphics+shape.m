//
//  PGraphics+shape.m
//  Processing Touch
//
//  Created by Kenan Che on 09-06-05.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PGraphics+shape.h"

#define kDefaultVerticesArrayLength     30

/// The basis matrix for Bezier curve. 
static const Matrix3D bezierBasisMatrix = {
    -1,  3, -3, 1,
     3, -6,  3, 0,
    -3,  3,  0, 0,
     1,  0,  0, 0,
};

static inline void forwardDifferences(int segments, Matrix3D *m)
{
    float f = 1.0f / segments;
    float ff = f * f;
    float fff = ff * f;
    
    Matrix3DSet(m, 
                0,     0,    0, 1,
                fff,   ff,   f, 0,
                6*fff, 2*ff, 0, 0,
                6*fff, 0,    0, 0);
}

@interface PGraphics (Vertices)

- (void)addVertex:(PVertex)v :(PTextureCoord)tc;
- (void)resetVertices;
- (void)resetCurveVertices;

- (void)segmentCurve:(Matrix3D *)drawMatrix :(int)segments
                    :(float)x0 :(float)y0 :(float)z0 
                    :(float)x1 :(float)y1 :(float)z1 
                    :(float)x2 :(float)y2 :(float)z2                 
                    :(float)x3 :(float)y3 :(float)z3
                    :(float)x4 :(float)y4 :(float)z4;
@end

@implementation PGraphics (Vertices)

- (void)addVertex:(PVertex)v :(PTextureCoord)tc
{
    Byte vt = PVertexNormal;
    [vertices_ appendBytes:&v length:sizeof(PVertex)];
    [indices_ appendBytes:&vt length:1];
    
    if (self.mode == P3D) {
        [accessories_ appendBytes:&tc length:sizeof(PTextureCoord)];
    }
}

- (void)resetVertices
{
    [vertices_ setLength:0];
    [indices_ setLength:0];
    [accessories_ setLength:0];
    
    perVertexFillColor_ = perVertexStrokeColor_ = customNormal_ = NO;
    
    texture_ = nil;
}

- (void)resetCurveVertices
{
    collectedCurveVertices_ = 0;
    firstCurveVertex_ = 0;
}

- (void)segmentCurve:(Matrix3D *)drawMatrix :(int)segments
                    :(float)x0 :(float)y0 :(float)z0 
                    :(float)x1 :(float)y1 :(float)z1 
                    :(float)x2 :(float)y2 :(float)z2                 
                    :(float)x3 :(float)y3 :(float)z3
                    :(float)x4 :(float)y4 :(float)z4
{
    Matrix3D m, eDelta;
    Matrix3DSet(&m, 
                x1, y1, z1, 0, 
                x2, y2, z2, 0, 
                x3, y3, z3, 0, 
                x4, y4, z4, 0);
    Matrix3DMultiply(drawMatrix, &m, &eDelta);
    
    float xplot1 = eDelta.m10;
    float xplot2 = eDelta.m20;
    float xplot3 = eDelta.m30;
    
    float yplot1 = eDelta.m11;
    float yplot2 = eDelta.m21;
    float yplot3 = eDelta.m31;
    
    float zplot1 = eDelta.m12;
    float zplot2 = eDelta.m22;
    float zplot3 = eDelta.m32;
    
    [self vertex:x0 :y0 :z0];
    for (int i = 0; i < segments; i++) {
        x0 += xplot1; xplot1 += xplot2; xplot2 += xplot3;
        y0 += yplot1; yplot1 += yplot2; yplot2 += yplot3;
        z0 += zplot1; zplot1 += zplot2; zplot2 += zplot3;
        
        [self vertex:x0 :y0 :z0];
    }
}

@end


@implementation PGraphics (Shape)

#pragma mark -
#pragma mark Shape - 2D primitive
#pragma mark -
// arc()
- (void)arc:(float)x 
           :(float)y 
           :(float)width
           :(float)height
           :(float)start 
           :(float)stop
{
    if (shapeBegan_) return;
    
    CGRect rect = normalizedRectangle(x, y, width, height, curStyle_.ellipseMode);
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect) || CGRectIsInfinite(rect))
        return;
    
    [renderer_ arc:CGRectGetMinX(rect) 
                  :CGRectGetMinY(rect) 
                  :CGRectGetWidth(rect) 
                  :CGRectGetHeight(rect)
                  :start
                  :stop];
    
}

// ellipse()
- (void)ellipse:(float)x1 
               :(float)y1 
               :(float)x2 
               :(float)y2
{
    if (shapeBegan_) return;
    
    CGRect rect = normalizedRectangle(x1, y1, x2, y2, curStyle_.ellipseMode);
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect) || CGRectIsInfinite(rect))
        return;
    
    [renderer_ ellipse:CGRectGetMinX(rect) 
                      :CGRectGetMinY(rect) 
                      :CGRectGetWidth(rect) 
                      :CGRectGetHeight(rect)];
}

// line()
- (void)line:(float)x1 
            :(float)y1 
            :(float)x2 
            :(float)y2
{
    [self line:x1 :y1 :0.0f :x2 :y2 :0.0f];
}

- (void)line:(float)x1 
            :(float)y1 
            :(float)z1 
            :(float)x2 
            :(float)y2 
            :(float)z2
{
    if (shapeBegan_) return;
    
    [self beginShape:LINES];
    [self vertex:x1 :y1 :z1];
    [self vertex:x2 :y2 :z2];
    [self endShape];
}

// point()
- (void)point:(float)x 
             :(float)y
{
    [self point:x :y :0];
}

- (void)point:(float)x 
             :(float)y 
             :(float)z
{
    if (shapeBegan_) return;
    
    [self beginShape:POINTS];
    [self vertex:x :y :z];
    [self endShape];
}

// quad()
- (void)quad:(float)x1 
            :(float)y1 
            :(float)x2 
            :(float)y2 
            :(float)x3 
            :(float)y3 
            :(float)x4 
            :(float)y4
{
    if (shapeBegan_) return;
    
    [self beginShape:QUADS];
    [self vertex:x1 :y1];
    [self vertex:x2 :y2];
    [self vertex:x3 :y3];
    [self vertex:x4 :y4];
    [self endShape];
}

// rect()
- (void)rect:(float)x1 :(float)y1 :(float)x2 :(float)y2
{
    if (shapeBegan_) return;
    
    CGRect rect = normalizedRectangle(x1, y1, x2, y2, curStyle_.rectMode);
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect) || CGRectIsInfinite(rect))
        return;
    [renderer_ rect:CGRectGetMinX(rect) 
                   :CGRectGetMinY(rect) 
                   :CGRectGetWidth(rect) 
                   :CGRectGetHeight(rect)];
}

// triangle()
- (void)triangle:(float)x1 
                :(float)y1 
                :(float)x2 
                :(float)y2 
                :(float)x3 
                :(float)y3
{
    if (shapeBegan_) return;
    
    [self beginShape:TRIANGLES];
    [self vertex:x1 :y1];
    [self vertex:x2 :y2];
    [self vertex:x3 :y3];
    [self endShape];    
}

#pragma mark -
#pragma mark Shape - Curve
#pragma mark -

// bezier
- (void)bezier:(float)x1 
              :(float)y1 
              :(float)cx1 
              :(float)cy1 
              :(float)cx2 
              :(float)cy2 
              :(float)x2 
              :(float)y2
{
    [self bezier:x1 :y1 :0 :cx1 :cy1 :0 :cx2 :cy2 :0 :x2 :y2 :0];
}

- (void)bezier:(float)x1 
              :(float)y1 
              :(float)z1 
              :(float)cx1 
              :(float)cy1 
              :(float)cz1
              :(float)cx2 
              :(float)cy2 
              :(float)cz2
              :(float)x2 
              :(float)y2 
              :(float)z2
{
    if (shapeBegan_) return;
    
    [self beginShape:PATH];
    [self vertex:x1 :y1 :z1];
    [self bezierVertex:cx1 :cy1 :cz1 :cx2 :cy2 :cz2 :x2 :y2 :z2];
    [self endShape];
}

// bezierDetail()
- (void)bezierDetail:(int)res
{
    if (res < 1) res = 1;
    
    bezierDetail_ = res;
    forwardDifferences(res, &bezierDrawMatrix_);
    Matrix3DApply(&bezierDrawMatrix_, &bezierBasisMatrix);
}

// bezierPoint()
- (float)bezierPoint:(float)a 
                   :(float)b 
                   :(float)c 
                   :(float)d 
                   :(float)t
{
    float t1 = 1.0f - t;
    return a * t1 * t1 * t1 + 3 * b * t * t1 * t1 + 3 * c * t * t * t1 + d * t * t * t;
}

// bezierTangent()
- (float)bezierTangent:(float)a 
                     :(float)b 
                     :(float)c 
                     :(float)d 
                     :(float)t
{
    return 3 * t * t * (-a + 3 * b - 3 * c + d) + 6 * t * (a - 2 * b + c) + 3 * (-a + b);
}

// curve()
- (void)curve:(float)x1 
             :(float)y1 
             :(float)x2 
             :(float)y2 
             :(float)x3 
             :(float)y3 
             :(float)x4 
             :(float)y4
{
    [self curve:x1 :y1 :0 :x2 :y2 :0 :x3 :y3 :0 :x4 :y4 :0];
}

- (void)curve:(float)x1
             :(float)y1 
             :(float)z1 
             :(float)x2 
             :(float)y2 
             :(float)z2                 
             :(float)x3
             :(float)y3 
             :(float)z3
             :(float)x4
             :(float)y4
             :(float)z4
{
    if (shapeBegan_) return;
    
    [self beginShape:PATH];
    [self curveVertex:x1 :y1 :z1];
    [self curveVertex:x2 :y2 :z2];
    [self curveVertex:x3 :y3 :z3];
    [self curveVertex:x4 :y4 :z4];
    [self endShape];
}

// curveDetail()
- (void)curveDetail:(int)segments
{
    if (segments < 1) segments = 1;
    
    curveDetail_ = segments;
    forwardDifferences(segments, &curveDrawMatrix_);
    Matrix3DApply(&curveDrawMatrix_, &curveBasisMatrix_);
}

// curvePoint()
- (float)curvePoint:(float)a 
                   :(float)b 
                   :(float)c 
                   :(float)d 
                   :(float)t
{
    float tt = t * t;
    float ttt = t * tt;
    Matrix3D *pm = &curveBasisMatrix_;
    
    // TODO: write the matrix * vecter in asm.
    return (a * (ttt*pm->m00 + tt*pm->m10 + t*pm->m20 + pm->m30) +
            b * (ttt*pm->m01 + tt*pm->m11 + t*pm->m21 + pm->m31) +
            c * (ttt*pm->m02 + tt*pm->m12 + t*pm->m22 + pm->m32) +
            d * (ttt*pm->m03 + tt*pm->m13 + t*pm->m23 + pm->m33));
}

// curveTangent()
- (float)curveTangent:(float)a 
                     :(float)b 
                     :(float)c 
                     :(float)d 
                     :(float)t
{
    float tt3 = t * t * 3;
    float t2 = t * 2;
    Matrix3D *pm = &curveBasisMatrix_;
    
    return (a * (tt3*pm->m00 + t2*pm->m10 + pm->m20) +
            b * (tt3*pm->m01 + t2*pm->m11 + pm->m21) +
            c * (tt3*pm->m02 + t2*pm->m12 + pm->m22) +
            d * (tt3*pm->m03 + t2*pm->m13 + pm->m23));
}

// curveTightness()
- (void)curveTightness:(float)s
{
    Matrix3DSet(&curveBasisMatrix_, 
                (s-1)/2,  (s+3)/2,   (-3-s)/2,  (1-s)/2,
                (1-s),    (-5-s)/2,  (s+2),     (s-1)/2,
                (s-1)/2,  0,         (1-s)/2,   0,
                0,        1,         0,         0);
    // rebuild curveDrawMatrix.
    [self curveDetail:curveDetail_];
}

#pragma mark -
#pragma mark Shape - Attributes
#pragma mark -
- (void)ellipseMode:(int)mode
{
    switch (mode) {
        case CENTER:
        case CORNER:
        case RADIUS:
        case CORNERS:
            curStyle_.ellipseMode = mode;
            break;
        default:
            break;
    }
}

- (void)rectMode:(int)mode
{
    switch (mode) {
        case CENTER:
        case CORNER:
        case RADIUS:
        case CORNERS:
            curStyle_.rectMode = mode;
            break;
        default:
            break;
    }
    
}

- (void)smooth
{
    if ([renderer_ respondsToSelector:@selector(smooth)]) {
        [renderer_ smooth];
    }
}

- (void)noSmooth
{
    if ([renderer_ respondsToSelector:@selector(noSmooth)]) {
        [renderer_ noSmooth];
    }
}

- (void)strokeCap:(int)mode
{
    if (shapeBegan_) return;
    
    switch (mode) {
        case SQUARE:
        case PROJECT:
        case ROUND:
            curStyle_.strokeCap = mode;
            [renderer_ strokeCap:mode];
            break;
        default:
            break;
    }
}

- (void)strokeJoin:(int)mode
{
    if (shapeBegan_) return;
    
    switch (mode) {
        case MITER:
        case BEVEL:
        case ROUND:
            curStyle_.strokeJoin = mode;
            [renderer_ strokeJoin:mode];
            break;
        default:
            break;
    }
}

// stroke width in pixel
- (void)strokeWeight:(float)w
{
    if (shapeBegan_ || w < EPSILON) return;
    
    curStyle_.strokeWeight = w;
    [renderer_ strokeWeight:w];
}

#pragma mark -
#pragma mark Shape - Vertex
#pragma mark -

- (void)beginShape
{
    [self beginShape:PATH];
}

- (void)beginShape:(int)mode
{
    if (shapeBegan_) return;
    
    if (vertices_ == nil) {
        vertices_ = [[NSMutableData alloc] initWithCapacity:kDefaultVerticesArrayLength * sizeof(PVertex)];
        indices_ = [[NSMutableData alloc] initWithCapacity:kDefaultVerticesArrayLength];
    }
    
    if (accessories_ == nil && self.mode == OPENGL) {
        accessories_ = [[NSMutableData alloc] initWithCapacity:kDefaultVerticesArrayLength];
    }
    
    switch (mode) {
        case PATH:
        case POINTS:
        case LINES:
        case TRIANGLES:
        case TRIANGLE_FAN:
        case TRIANGLE_STRIP:
        case QUADS:
        case QUAD_STRIP:
            shapeBegan_ = YES;
            vertexMode_ = mode;
            break;
        default:
            break;
    }
}

- (void)endShape
{
    [self endShape:OPEN];
}

- (void)endShape:(int)mode
{
    if (!shapeBegan_) return;
    
    if (mode == OPEN || mode == CLOSE) {
        
        if (self.mode == QUARTZ2D) {
            [renderer_ draw2DShapeWithVertices:[vertices_ bytes] 
                                  vertexNumber:[indices_ length]
                                       indices:[indices_ bytes] 
                                          mode:vertexMode_ 
                                         close:(mode == CLOSE)];
        } else {
            [renderer_ draw3DShapeWithVertices:[vertices_ bytes] 
                                  vertexNumber:[vertices_ length]/sizeof(PVertex)
                                       indices:[indices_ bytes] 
                                   indexNumber:[indices_ length]
                                   accessories:[accessories_ bytes] 
                                       texture:texture_ 
                            perVertexFillColor:perVertexFillColor_ 
                          perVertexStrokeColor:perVertexStrokeColor_ 
                                  customNormal:customNormal_
                                          mode:vertexMode_ 
                                         close:(mode == CLOSE)];
        }
    }
    
    [self resetVertices];
    [self resetCurveVertices];
    shapeBegan_ = NO;
}

// vertex()
- (void)vertex:(float)x :(float)y
{
    [self vertex:x :y :0];
}

- (void)vertex:(float)x :(float)y :(float)z
{
    [self vertex:x :y :z :-1.0f :-1.0f];
}

- (void)vertex:(float)x :(float)y :(float)z :(float)u :(float)v
{
    if (!shapeBegan_) return;
    [self addVertex:PVertexMake(x, y, z) :PTextureCoordMake(u, v)];
    
    [self resetCurveVertices];
}

- (void)curveVertex:(float)x :(float)y
{
    [self curveVertex:x :y :0];
}

- (void)curveVertex:(float)x :(float)y :(float)z
{
    if (!shapeBegan_ || vertexMode_ != PATH) return;
    
    curveVertices_[(firstCurveVertex_ + collectedCurveVertices_) % 4] = PVertexMake(x, y, z);
    if (collectedCurveVertices_ < 3) {
        collectedCurveVertices_++;
    } else {
        PVertex *pv1 = curveVertices_ + firstCurveVertex_;
        PVertex *pv2 = curveVertices_ + (firstCurveVertex_ + 1) % 4;
        PVertex *pv3 = curveVertices_ + (firstCurveVertex_ + 2) % 4;
        PVertex *pv4 = curveVertices_ + (firstCurveVertex_ + 3) % 4;
        
        [self segmentCurve:&curveDrawMatrix_ :curveDetail_ 
                          :pv2->x :pv2->y :pv2->z   // The second point is the start point.
                          :pv1->x :pv1->y :pv1->z 
                          :pv2->x :pv2->y :pv2->z 
                          :pv3->x :pv3->y :pv3->z 
                          :pv4->x :pv4->y :pv4->z];
        
        // Vertex:: will reset curve vertices counter and index, so restore them here.
        collectedCurveVertices_ = 3;
        firstCurveVertex_ = pv2 - curveVertices_;
    }
}

- (void)bezierVertex:(float)cx1 
                    :(float)cy1 
                    :(float)cx2 
                    :(float)cy2 
                    :(float)x 
                    :(float)y
{
    [self bezierVertex:cx1 :cy1 :0 :cx2 :cy2 :0 :x :y :0];
}

- (void)bezierVertex:(float)cx1 
                    :(float)cy1 
                    :(float)cz1 
                    :(float)cx2 
                    :(float)cy2 
                    :(float)cz2 
                    :(float)x 
                    :(float)y 
                    :(float)z
{
    if (!shapeBegan_ || vertexMode_ != PATH) return;
    if ([vertices_ length] == 0) return;
    
    [self resetCurveVertices];
    
    // Get last vertex, which will be the first point of bezier curve.
    PVertex *v = ((PVertex *)[vertices_ bytes]) + [vertices_ length] / sizeof(PVertex) - 1;
    [self segmentCurve:&bezierDrawMatrix_ :bezierDetail_
                      :v->x :v->y :v->z :v->x :v->y :v->z 
                      :cx1 :cy1 :cz1 
                      :cx2 :cy2 :cz2 
                      :x :y :z];
}

@end
