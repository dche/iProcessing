//
//  PImage.h
//  Processing Touch
//
//  Created by Kenan Che on 09-06-08.
//  Copyright 2009 campl software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProcessingFunctions.h"

@interface PImage : NSObject {

@private
    // For resize, mask and blend.
    CGContextRef bitmapContext_;
    int mode_;
    
    int width, height;
    color *data_;
    color *pixels;
}

@property (readonly) int width;
@property (readonly) int height;
@property (readonly) color *pixels;

- (id)initWithWidth:(NSUInteger)w height:(NSUInteger)h mode:(int)imgMode 
               data:(const void *)d;
- (id)initWithWidth:(NSUInteger)w height:(NSUInteger)h mode:(int)imgMode;
- (id)initWithCGImage:(CGImageRef)img;

/// Return the CGImage of the pixel data.
/// You should call CGImageRelease after using the returned value.
- (CGImageRef)CGImage;

- (color)get:(int)x :(int)y;
- (PImage *)get;
- (PImage *)get:(int)x1 :(int)y1 :(int)x2 :(int)y2;

- (void)set:(int)x :(int)y :(color)clr;

- (void)copy:(int)sx :(int)sy :(int)swidth :(int)sheight 
            :(int)dx :(int)dy :(int)dwidth :(int)dheight;
- (void)copy:(PImage *)srcImg :(int)sx :(int)sy :(int)swidth :(int)sheight 
            :(int)dx :(int)dy :(int)dwidth :(int)dheight;

- (void)mask:(PImage *)mask;

- (void)blend:(int)x :(int)y :(int)w :(int)h 
             :(int)dx :(int)dy :(int)dwidth :(int)dheight :(int)mode;
- (void)blend:(PImage *)srcImg :(int)x :(int)y :(int)w :(int)h 
             :(int)dx :(int)dy :(int)dwidth :(int)dheight :(int)mode;

- (void)filter:(int)mode;
- (void)filter:(int)mode :(float)param;

/// Save to the camera roll album.
- (void)save:(NSString *)name;

- (void)resize:(int)w :(int)h;

/// Loads the pixel data for the image into its pixels[] array
- (void)loadPixels;
/// Updates the image with the data in its pixels[] array
- (void)updatePixels;

@end
