//
//  PGraphics+image.h
//  Processing Touch
//
//  Created by Kenan Che on 09-06-06.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGraphics.h"

@class PImage;

@interface PGraphics (Image)

/// Creates a new PImage.
- (PImage *)createImage:(int)width :(int)height :(int)format;

- (void)image:(PImage *)img :(float)x :(float)y;
- (void)image:(PImage *)img :(float)x :(float)y :(float)width :(float)height;

- (void)imageMode:(int)mode;

- (PImage *)loadImage:(NSString *)name;
- (PImage *)requestImage:(NSString *)name;

- (void)noTint;

- (void)tint:(color)clr;
- (void)tint:(float)gray :(float)alpha;
- (void)tint:(float)val1 :(float)val2 :(float)val3;
- (void)tint:(float)val1 :(float)val2 :(float)val3 :(float)alpha;

- (void)blend:(int)x :(int)y :(int)width :(int)height 
             :(int)dx :(int)dy :(int)dwidth :(int)dheight 
             :(int)mode;
- (void)blend:(PImage *)srcImg :(int)x :(int)y :(int)width :(int)height 
             :(int)dx :(int)dy :(int)dwidth :(int)dheight :(int)mode;

- (void)copy:(int)sx :(int)sy :(int)swidth :(int)sheight 
            :(int)dx :(int)dy :(int)dwidth :(int)dheight;
- (void)copy:(PImage *)srcImg :(int)sx :(int)sy :(int)swidth :(int)sheight 
            :(int)dx :(int)dy :(int)dwidth :(int)dheight;

- (void)filter:(int)mode;
- (void)filter:(int)mode :(float)param;

- (color)get:(int)x :(int)y;
- (PImage *)get;
- (PImage *)get:(int)x1 :(int)y1 :(int)x2 :(int)y2;

- (void)loadPixels;

- (void)set:(int)x :(int)y :(color)clr;

- (void)updatePixels;

@end
