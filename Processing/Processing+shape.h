//
//  Processing+shape.h
//  BubbleTalk
//
//  Created by Kenan Che on 09-06-05.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Processing+core.h"

@interface Processing (Shape)

#pragma mark -
#pragma mark Shape - 2D primitive
#pragma mark -
/// Draws an arc in the display window.
- (void)arc:(float)x 
           :(float)y 
           :(float)width
           :(float)height
           :(float)start 
           :(float)stop;
// ellipse()
- (void)ellipse:(float)x1
               :(float)y1 
               :(float)x2 
               :(float)y2;
// line()
- (void)line:(float)x1 
            :(float)y1 
            :(float)x2 
            :(float)y2;
- (void)line:(float)x1 
            :(float)y1 
            :(float)z1 
            :(float)x2 
            :(float)y2 
            :(float)z2;
// point()
- (void)point:(float)x 
             :(float)y;
- (void)point:(float)x 
             :(float)y 
             :(float)z;
// quad()
- (void)quad:(float)x1 
            :(float)y1 
            :(float)x2 
            :(float)y2 
            :(float)x3 
            :(float)y3 
            :(float)x4 
            :(float)y4;
// rect()
- (void)rect:(float)x1 :(float)y1 :(float)x2 :(float)y2;
// triangle()
- (void)triangle:(float)x1 
                :(float)y1 
                :(float)x2 
                :(float)y2 
                :(float)x3 
                :(float)y3;

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
              :(float)y2;
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
              :(float)z2;
// bezierDetail()
- (void)bezierDetail:(int)res;
// bezierPoint()
- (void)bezierPoint:(float)a 
                   :(float)b 
                   :(float)c 
                   :(float)d 
                   :(float)t;
// bezierTangent()
- (void)bezierTangent:(float)fa 
                     :(float)b 
                     :(float)c 
                     :(float)d 
                     :(float)t;
// curve()
- (void)curve:(float)x1 
             :(float)y1 
             :(float)x2 
             :(float)y2 
             :(float)x3 
             :(float)y3 
             :(float)x4 
             :(float)y4;
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
             :(float)z4;
// curveDetail()
- (void)curveDetail:(int)aInt;
// curvePoint()
- (void)curvePoint:(float)fa 
                  :(float)fb 
                  :(float)fc 
                  :(float)fd 
                  :(float)t;
// curveTangent()
- (void)curveTangent:(float)a 
                    :(float)fb 
                    :(float)c 
                    :(float)d 
                    :(float)t;
// curveTightness()
- (void)curveTightness:(float)squishy;

#pragma mark -
#pragma mark Shape - 3D primitives
#pragma mark -

// box()
- (void)box:(float)size;
- (void)box:(float)width 
           :(float)height 
           :(float)depth;
// sphere()
- (void)sphere:(float)radius;
// sphereDetail()
- (void)sphereDetail:(float)res;
- (void)sphereDetail:(float)ures 
                    :(float)vres;

#pragma mark -
#pragma mark Shape - Attributes
#pragma mark -
- (void)ellipseMode:(int)mode;
- (void)rectMode:(int)mode;
- (void)smooth;
- (void)noSmooth;   // no effect at OPENGL
- (void)strokeCap:(int)mode;    // no effect at OPENGL
- (void)strokeJoin:(int)mode;   // no effect at OPENGL
// stroke width in pixel
- (void)strokeWeight:(NSUInteger)pixel;

#pragma mark -
#pragma mark Shape - Vertex
#pragma mark -

- (void)beginShape;
- (void)beginShape:(int)mode;
- (void)endShape;
- (void)endShape:(int)mode;
- (void)vertex:(float)x :(float)y;
- (void)vertex:(float)x :(float)y :(float)z;
- (void)vertexWithX;
- (void)curveVertex:(float)x :(float)y;
- (void)curveVertex:(float)x :(float)y :(float)z;
- (void)bezierVertex:(float)cx1 
                    :(float)cy1 
                    :(float)cx2 
                    :(float)cy2 
                    :(float)x 
                    :(float)y;
- (void)bezierVertex:(float)cx1 
                    :(float)cy1 
                    :(float)cz1 
                    :(float)cx2 
                    :(float)cy2 
                    :(float)cz2 
                    :(float)x 
                    :(float)y 
                    :(float)z;

#pragma mark -
#pragma mark Shape - Loading & Displaying
#pragma mark Not supported
#pragma mark -

@end
