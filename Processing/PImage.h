//
//  PImage.h
//  Processing Touch
//
//  Created by Kenan Che on 09-06-08.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Processing+core.h"

@interface PImage : NSObject {

@private
    // Processing for updating pixels.
    Processing *p_;
    CGImageRef image_;
}

@property (readonly) int width;
@property (readonly) int height;
@property (readonly) color *pixels;

- (id)initWithContext:(CGContextRef)c;
- (id)initWithWidth:(NSUInteger)w height:(NSUInteger)h mode:(int)imgMode;

- (color)get:(int)x :(int)y;
- (PImage *)get;
- (PImage *)get:(int)x1 :(int)y1 :(int)x2 :(int)y2;

- (void)set:(int)x :(int)y :(color)clr;

- (void)copy:(int)sx :(int)sy :(int)swidth :(int)sheight :(int)dx :(int)dy :(int)dwidth :(int)dheight;
- (void)copy:(PImage *)srcImg :(int)sx :(int)sy :(int)swidth :(int)sheight :(int)dx :(int)dy :(int)dwidth :(int)dheight;

- (void)mask:(PImage *)mask;

- (void)blend:(int)x :(int)y :(int)width :(int)height :(int)dx :(int)dy :(int)dwidth :(int)dheight :(int)mode;
- (void)blend:(PImage *)srcImg :(int)x :(int)y :(int)width :(int)height :(int)dx :(int)dy :(int)dwidth :(int)dheight :(int)mode;

- (void)filter:(int)mode;
- (void)filter:(int)mode :(float)param;

/// Save to the camera roll album.
- (void)save:(NSString *)name;

- (void)resize:(int)width :(int)height;

- (void)loadPixels;
- (void)updatePixels;

@end
