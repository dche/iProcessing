//
//  Processing+shape.m
//  BubbleTalk
//
//  Created by Kenan Che on 09-06-05.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Processing+shape.h"

static CGRect normalizedRectangle(float x1, float y1, float x2, float y2 , int mode)
{
    float ox, oy, w, h;
    switch (mode) {
        case CENTER:
            ox = x1 - x2 / 2.0f;
            oy = y1 - y2 / 2.0f;
            w = x2; h = y2;
            break;
        case RADIUS:
            ox = x1 - x2;
            oy = y1 - y2;
            w = x2 * 2.0f;
            h = y2 * 2.0f;
            break;
        case CORNERS:
            ox = x1; oy = y1;
            w = x2 - x1; h = y2 - y1;
            break;
        case CORNER:
            ox = x1; oy = y1;
            w = x2; h = y2;
        default:
            break;
    }
    return CGRectMake(ox, oy, w, h);    
}

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
    CGRect rect = normalizedRectangle(x, y, width, height, ellipseMode_);
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
    CGRect rect = normalizedRectangle(x1, y1, x2, y2, ellipseMode_);
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
    [graphics_ line:x1 :y1 :z1 :x2 :y2 :z2];
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
    [graphics_ point:x :y :z];
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
    [self beginShape];
    [self vertex:x1 :y1];
    [self vertex:x2 :y2];
    [self vertex:x3 :y3];
    [self vertex:x4 :y4];
    [self endShape:CLOSE];
}

// rect()
- (void)rect:(float)x1 :(float)y1 :(float)x2 :(float)y2
{
    CGRect rect = normalizedRectangle(x1, y1, x2, y2, rectMode_);
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
    [self beginShape];
    [self vertex:x1 :y1];
    [self vertex:x2 :y2];
    [self vertex:x3 :y3];
    [self endShape:CLOSE];    
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
    
}

// bezierDetail()
- (void)bezierDetail:(int)res
{
    
}

// bezierPoint()
- (void)bezierPoint:(float)a 
                   :(float)b 
                   :(float)c 
                   :(float)d 
                   :(float)t
{
    
}

// bezierTangent()
- (void)bezierTangent:(float)fa 
                     :(float)b 
                     :(float)c 
                     :(float)d 
                     :(float)t
{
    
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
    
}

// curveDetail()
- (void)curveDetail:(int)aInt
{
    
}

// curvePoint()
- (void)curvePoint:(float)fa 
                  :(float)fb 
                  :(float)fc 
                  :(float)fd 
                  :(float)t
{
    
}

// curveTangent()
- (void)curveTangent:(float)a 
                    :(float)fb 
                    :(float)c 
                    :(float)d 
                    :(float)t
{
    
}

// curveTightness()
- (void)curveTightness:(float)squishy
{
    
}

#pragma mark -
#pragma mark Shape - 3D primitives
#pragma mark -

// box()
- (void)box:(float)size
{
    
}

- (void)box:(float)width 
           :(float)height 
           :(float)depth
{
    
}

// sphere()
- (void)sphere:(float)radius
{
    
}

// sphereDetail()
- (void)sphereDetail:(float)res
{
    
}

- (void)sphereDetail:(float)ures 
                    :(float)vres
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
            ellipseMode_ = mode;
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
            rectMode_ = mode;
            break;
        default:
            break;
    }
    
}

- (void)smooth
{
    smooth_ = YES;
}

- (void)noSmooth
{}

- (void)strokeCap:(int)mode
{
    switch (mode) {
        case SQUARE:
        case PROJECT:
        case ROUND:
            strokeCap_ = mode;
            [graphics_ strokeCap:mode];
            break;
        default:
            break;
    }
}

- (void)strokeJoin:(int)mode
{
    switch (mode) {
        case MITER:
        case BEVEL:
        case ROUND:
            strokeJoin_ = mode;
            [graphics_ strokeJoin:mode];
            break;
        default:
            break;
    }
}

// stroke width in pixel
- (void)strokeWeight:(NSUInteger)pixel
{
    strokeWeight_ = pixel;
    [graphics_ strokeWeight:pixel];
}

#pragma mark -
#pragma mark Shape - Vertex
#pragma mark -

- (void)beginShape
{
    
}

- (void)beginShape:(int)mode
{
    
}

- (void)endShape
{
    
}

- (void)endShape:(int)mode
{
    
}

// vertex()
- (void)vertex:(float)x :(float)y
{
    
}

- (void)vertex:(float)x :(float)y :(float)z
{
    
}

- (void)vertexWithX
{
    
}

- (void)curveVertex:(float)x :(float)y
{
    
}

- (void)curveVertex:(float)x :(float)y :(float)z
{
    
}

- (void)bezierVertex:(float)cx1 
                    :(float)cy1 
                    :(float)cx2 
                    :(float)cy2 
                    :(float)x 
                    :(float)y
{
    
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
    
}

@end
