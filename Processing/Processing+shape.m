//
//  Processing+shape.m
//  Processing Touch
//
//  Created by Kenan Che on 09-06-05.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Processing+shape.h"

@interface Processing (Vertices)

- (void)addVertex:(PVertex)v :(PTextureCord)tc;
- (void)addCurveVertex:(PVertex)v;
- (void)addBezierVertices:(PVertex)cp1 :(PVertex)cp2 :(PVertex)p;
- (void)resetVertices;

@end

@implementation Processing (Vertices)

- (void)addVertex:(PVertex)v :(PTextureCord)tc
{
    Byte vt = PVertexNormal;
    [vertices_ appendBytes:&v length:sizeof(PVertex)];
    [indices_ appendBytes:&vt length:1];
    
    if (self.mode == P3D) {
        [accessories_ appendBytes:&tc length:sizeof(PTextureCord)];
    }
}

- (void)addCurveVertex:(PVertex)v
{
    Byte vt = PVertexCurve;
    [vertices_ appendBytes:&v length:sizeof(PVertex)];
    [indices_ appendBytes:&vt length:1];    
}

- (void)addBezierVertices:(PVertex)cp1 :(PVertex)cp2 :(PVertex)p
{
    Byte vt = PVertexBezier;
    PVertex vs[] = { cp1, cp2, p };
    [vertices_ appendBytes:vs length:sizeof(PVertex) * 3];
    [indices_ appendBytes:&vt length:1];        
}

- (void)resetVertices
{
    [vertices_ setLength:0];
    [indices_ setLength:0];
    [accessories_ setLength:0];
    
    perVertexFillColor_ = perVertexStrokeColor_ = customNormal_ = NO;
    
    texture_ = nil;
}

@end


@implementation Processing (Shape)

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
    
    [graphics_ arc:CGRectGetMinX(rect) 
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
    
    [graphics_ ellipse:CGRectGetMinX(rect) 
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
    [graphics_ rect:CGRectGetMinX(rect) 
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
- (void)curveDetail:(int)aInt
{
    
}

// curvePoint()
- (float)curvePoint:(float)a 
                  :(float)b 
                  :(float)c 
                  :(float)d 
                  :(float)t
{
    return 0;
}

// curveTangent()
- (float)curveTangent:(float)a 
                    :(float)b 
                    :(float)c 
                    :(float)d 
                    :(float)t
{
    return 0;
}

// curveTightness()
- (void)curveTightness:(float)squishy
{
    
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
    if ([graphics_ respondsToSelector:@selector(smooth)]) {
        [graphics_ smooth];
    }
}

- (void)noSmooth
{
    if ([graphics_ respondsToSelector:@selector(noSmooth)]) {
        [graphics_ noSmooth];
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
            [graphics_ strokeCap:mode];
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
            [graphics_ strokeJoin:mode];
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
    [graphics_ strokeWeight:w];
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
            [graphics_ draw2DShapeWithVertices:[vertices_ bytes] 
                                  vertexNumber:[indices_ length]
                                       indices:[indices_ bytes] 
                                          mode:vertexMode_ 
                                         close:(mode == CLOSE)];
        } else {
            [graphics_ draw3DShapeWithVertices:[vertices_ bytes] 
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
    [self addVertex:PVertexMake(x, y, z) :PTextureCordMake(u, v)];    
}

- (void)curveVertex:(float)x :(float)y
{
    [self curveVertex:x :y :0];
}

- (void)curveVertex:(float)x :(float)y :(float)z
{
    if (!shapeBegan_ || vertexMode_ != PATH) return;
    [self addCurveVertex:PVertexMake(x, y, z)];
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
    [self addBezierVertices:PVertexMake(cx1, cy1, cz1) 
                           :PVertexMake(cx2, cy2, cz2) 
                           :PVertexMake(x, y, z)];
}

@end
