//
//  PGraphics.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-16.
//  Copyright 2009 campl software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProcessingTypes.h"

@class Processing;

@protocol PGraphics <NSObject>

@required

/// Set the background. Four values have been clamped to the range [0, 1]
- (void)background:(float)red :(float)green :(float)blue :(float)alpha;
- (void)noFill;
- (void)fill:(float)red :(float)green :(float)blue :(float)alpha;
- (void)noStroke;
- (void)stroke:(float)red :(float)green :(float)blue :(float)alpha;
- (void)strokeCap:(int)mode;
- (void)strokeJoin:(int)mode;
- (void)strokeWeight:(NSUInteger)pixel;
- (void)noTint;
- (void)tint:(float)red :(float)green :(float)blue :(float)alpha;

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

- (void)drawShapeWithVertices:(const PVertex *)v 
                      indices:(const Byte *)i 
                 vertexNumber:(NSUInteger)n
                         mode:(int)m 
                        close:(BOOL)toClose;

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

// Typography
/// Draw a single line of text.
- (void)textFont:(UIFont *)font;
- (void)showText:(NSString *)str :(float)x :(float)y :(float)z;

/// Called by associated Processing.
- (void)draw;

- (id)initWithController:(Processing *)p width:(NSUInteger)w height:(NSUInteger)h;

@optional

// Shape
- (void)smooth;
- (void)noSmooth;
- (void)bezierDetail:(int)res;
- (void)curveDetail:(int)aInt;

// 3D

@end

@interface PGraphics2D : UIView <PGraphics> {
    
@private
    CGContextRef ctx;
    Processing *p_;
    BOOL doFill_;
    BOOL doStroke_;
    UIFont *curFont_;
    
    PColor fillColor_;
}

@end
