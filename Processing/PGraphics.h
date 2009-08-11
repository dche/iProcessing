//
//  PGraphics.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-30.
//  Copyright 2009 campl software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProcessingFunctions.h"
#import "PGraphicsProtocol.h"
#import "PStyle.h"
#import "PImage.h"

@interface PGraphics : UIViewController {

@private
    /// The render.
    id<PGraphics> graphics_;
    
    /// Width
    float width_;
    /// Height
    float height_;
    /// QUARTZ2D, P2D or P3D (OPENGL)
    int mode_;
    
    //..........................
    //  Noise parameters
    //..........................
    
    int noiseOctaves_;
    float noiseFalloff_;
    int noiseSeed_;
    
    //..........................
    //  Image
    //..........................
    
    /// The pixels array
    color *pixels_;
    
    //..........................
    //  Shape
    //..........................
    
    /// Flag between beginShape() and endShape()
    BOOL shapeBegan_;
    /// Current vertex mode. Because bezierVertex and curveVertex can be
    /// used in PATH mode only.
    int vertexMode_;
    /// The vertex list.
    NSMutableData *vertices_;
    /// The index list, contains vertex types.
    NSMutableData *indices_;
    /// Flag when per-vertex color is provided.
    BOOL perVertexFillColor_;
    BOOL perVertexStrokeColor_;
    /// Flag when custom normal is provided.
    BOOL customNormal_;
    
    /// How many curveVertex have been specified.
    NSUInteger collectedCurveVertices_;
    /// The index of first curve vertex in curveVertices_.
    NSUInteger firstCurveVertex_;
    /// The curve vertex collector.
    PVertex curveVertices_[4];
    /// CurveDetail
    int curveDetail_;
    /// BezierDetail
    int bezierDetail_;
    /// The basis matrix for Catmull–Rom spline. 
    /// It is a function of curveTighness.
    Matrix3D curveBasisMatrix_;
    /// The draw matrix, which is E(delta) * Basis * Points
    Matrix3D curveDrawMatrix_;
    /// The draw matrix for Bezier
    Matrix3D bezierDrawMatrix_;
    
    //..........................
    //  3D
    //..........................
    
    /// YES if perspective projection is used, o.w., ortho projection. Default is YES.
    BOOL perspective_;
    /// Weak reference of Texture to be applied. Used only in P3D mode.
    NSObject<PTexture> *texture_;
    /// How to set texture cord. Default is IMAGE.
    int textureMode_;
    /// List for color, normal for vertices. Used only if in P3D mode.
    NSMutableData *accessories_;
    
    
    /// For pushStyle() and popStyle()
    NSMutableArray *styleStack_;
    PStyle *curStyle_;    
}

@property (nonatomic, readonly) color *pixels;
@property (nonatomic, readonly) int mode;
@property (nonatomic, readonly) float width;
@property (nonatomic, readonly) float height;

@property (readonly) int day;
@property (readonly) int month;
@property (readonly) int year;
@property (readonly) int hour;
@property (readonly) int minute;
@property (readonly) int second;

- (id)initWithWidth:(float)w height:(float)h;
- (void)createRenderWithMode:(int)mode frame:(CGRect)frame;

- (void)beginDraw;
- (void)endDraw;

/// Called by Processing
- (void)drawView;

/// restore original style
- (void)popStyle;
/// save current style
- (void)pushStyle;

@end
