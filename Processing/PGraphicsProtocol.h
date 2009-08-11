/*
 *  PGraphicsProtocol.h
 *  iProcessing
 *
 *  Created by Kenan Che on 09-06-30.
 *  Copyright 2009 campl software. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>
#import "ProcessingTypes.h"

@class PGraphics;
@class PImage;
@protocol PTexture;

@protocol PGraphics <NSObject>

@required

- (void)background:(float)red :(float)green :(float)blue :(float)alpha;
- (void)noFill;
- (void)fill:(float)red :(float)green :(float)blue :(float)alpha;
- (void)noStroke;
- (void)stroke:(float)red :(float)green :(float)blue :(float)alpha;
- (void)strokeCap:(int)mode;
- (void)strokeJoin:(int)mode;
- (void)strokeWeight:(float)w;
- (void)noTint;
- (void)tint:(float)red :(float)green :(float)blue :(float)alpha;

- (void)smooth;
- (void)noSmooth;

/// 2D drawing
- (void)arc:(float)ox 
           :(float)oy 
           :(float)width 
           :(float)height 
           :(float)start 
           :(float)stop;
- (void)ellipse:(float)ox 
               :(float)oy 
               :(float)width 
               :(float)height;
- (void)rect:(float)ox 
            :(float)oy 
            :(float)width 
            :(float)height;

// Transformation
- (void)multMatrix:(float)n00 :(float)n01 :(float)n02 :(float)n03
                  :(float)n04 :(float)n05 :(float)n06 :(float)n07
                  :(float)n08 :(float)n09 :(float)n10 :(float)n11
                  :(float)n12 :(float)n13 :(float)n14 :(float)n15;
- (void)pushMatrix;
- (void)popMatrix;
- (void)loadIdentity;
- (void)rotate:(float)theta :(float)x :(float)y :(float)z;
- (void)scale:(float)x :(float)y :(float)z;
- (void)translate:(float)x :(float)y :(float)z;

- (Matrix3D)matrix;
- (void)loadMatrix:(Matrix3D)m;

// Typography
/// Draw a single line of text.
- (void)textFont:(UIFont *)font;
- (void)showText:(NSString *)str :(float)x :(float)y :(float)z;

/// Called by associated Processing.
- (void)draw;

- (id)initWithFrame:(CGRect)frame controller:(PGraphics *)p;

/// Pixel data
- (color)getPixelAtPoint:(CGPoint)p;
- (void)setPixel:(color)clr atPoint:(CGPoint)p;
- (color *)loadPixels;
- (void)updatePixels;
- (void)releasePixels;

/// Image
- (void)drawImage:(PImage *)image atPoint:(CGPoint)point;
- (void)drawImage:(PImage *)image inRect:(CGRect)rect;

@optional

- (void)draw2DShapeWithVertices:(const PVertex *)v
                   vertexNumber:(NSUInteger)n 
                        indices:(const Byte *)i 
                           mode:(int)m 
                          close:(BOOL)toClose;

/// A very very fat interface that including everything can be added
/// between beginShape() endShape()
- (void)draw3DShapeWithVertices:(const PVertex *)v 
                   vertexNumber:(NSUInteger)n
                        indices:(const Byte *)i 
                    indexNumber:(NSUInteger)ni
                    accessories:(const Byte *)a 
                        texture:(const NSObject<PTexture> *)t
             perVertexFillColor:(BOOL)useFillColorArray 
           perVertexStrokeColor:(BOOL)useStrokeColorArray 
                   customNormal:(BOOL)normalProvided
                           mode:(int)m 
                          close:(BOOL)toClose;

// Shape - N/A in 3D mode, so optional
- (void)bezierDetail:(int)res;
- (void)curveDetail:(int)aInt;

#pragma mark -
#pragma mark 3D only methods
#pragma mark -

- (void)boxWithWidth:(float)w height:(float)h depth:(float)d;
- (void)sphereWithRadius:(float)r;
- (void)sphereDetailWithUres:(float)u vres:(float)v;

- (void)addAmbientLightWithColor:(PColor)pc atPosition:(PVector)pos;
- (void)addDirectionalLightWithColor:(PColor)pc toDirection:(PVector)dir;
- (void)addPointLightWithColor:(PColor)pc atPosition:(PVector)pos;
- (void)addSpotLightWithColor:(PColor)pc angle:(float)a concentration:(float)c atPosition:(PVector)pos toDirection:(PVector)dir;

- (void)noLights;

- (void)lightAttenuationConst:(float)c linear:(float)l quardratic:(float)q;
- (void)lightSpecular:(PColor)pc;

- (void)ambient:(PColor)pc;
- (void)emissive:(PColor)pc;
- (void)shininess:(float)shine;
- (void)specular:(PColor)pc;

- (void)textureMode:(int)mode;

- (void)frustum:(float)left :(float)right :(float)bottom :(float)top :(float)near :(float)far;
- (void)ortho:(float)left :(float)right :(float)bottom :(float)top :(float)near :(float)far;

@end
