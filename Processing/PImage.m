//
//  PImage.m
//  Processing Touch
//
//  Created by Kenan Che on 09-06-08.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PImage.h"

@interface PImage ()

- (CGContextRef)createBitmapCGContextWithWidth:(NSUInteger)w 
                                        height:(NSUInteger)h 
                                          mode:(int)imgMode 
                                          data:(const void *)d;

@end


@implementation PImage
@synthesize width, height;
@synthesize pixels;

- (id)initWithWidth:(NSUInteger)w 
             height:(NSUInteger)h 
               mode:(int)imgMode 
               data:(const void *)d
{
    if (self = [super init]) {
        bitmapContext_ = [self createBitmapCGContextWithWidth:w 
                                                       height:h 
                                                         mode:imgMode
                                                         data:d];
        if (bitmapContext_ == NULL) {
            [self release];
            return nil;
        }
        width = w;
        height = h;
        mode_ = imgMode;
        
        // Flip the y-axis.
        CGContextConcatCTM(bitmapContext_, CGAffineTransformMake(1, 0, 0, -1, 0, h));
    }
    return self;
}

- (id)initWithWidth:(NSUInteger)w height:(NSUInteger)h mode:(int)imgMode
{
    return [self initWithWidth:w height:h mode:imgMode data:nil];
}

- (id)initWithCGImage:(CGImageRef)img
{
    if (img == NULL) return nil;
    
    NSUInteger w = CGImageGetWidth(img);
    NSUInteger h = CGImageGetHeight(img);
    
    [self initWithWidth:w height:h mode:RGBA];
    CGContextDrawImage(bitmapContext_, CGRectMake(0, 0, w, h), img);
    
    return self;
}

- (void)dealloc
{
    CGContextRelease(bitmapContext_);
    free(data_);
    if (pixels != NULL) free(pixels);
    [super dealloc];
}

- (CGContextRef)createBitmapCGContextWithWidth:(NSUInteger)w 
                                        height:(NSUInteger)h 
                                          mode:(int)imgMode 
                                          data:(const void *)d
{
    CGContextRef    context = NULL;    
    CGColorSpaceRef colorSpace;    
    int             bitmapBytesPerRow;
    
    bitmapBytesPerRow   = (w * 4);
    data_ = (color *)calloc(w * h, sizeof(color));
    if (NULL == data_) {
        return NULL;
    }
    if (NULL != d) {
        memcpy(data_, d, w * h * sizeof(color));
    }
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = (imgMode == ARGB) ? (kCGImageAlphaPremultipliedLast) : (kCGImageAlphaNoneSkipLast);
    
    context = CGBitmapContextCreate (data_,
                                     w,
                                     h,
                                     8,
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     bitmapInfo);
    
    CGColorSpaceRelease( colorSpace );
    return context;
}

- (CGImageRef)CGImage
{
    return CGBitmapContextCreateImage(bitmapContext_);
}

- (color)get:(int)x :(int)y
{
    UInt32 val = data_[cordsToIndex(x, y, width, height, YES)];
    if (mode_ == RGB) {
        return val;
    } else {
        return dePremultiplyColor(val);
    }
}

- (PImage *)get
{
    PImage *img = [[PImage alloc] initWithWidth:width height:height mode:mode_ data:data_];
    return [img autorelease];
}

- (PImage *)get:(int)x1 :(int)y1 :(int)x2 :(int)y2
{
    return nil;
}

- (void)set:(int)x :(int)y :(color)clr
{
    color c = (mode_ == RGB) ? clr : premultiplyColor(clr);
    data_[cordsToIndex(x, y, width, height, YES)] = premultiplyColor(c);
}


- (void)copy:(int)sx :(int)sy :(int)swidth :(int)sheight 
            :(int)dx :(int)dy :(int)dwidth :(int)dheight
{
    CGImageRef imgInRect = CGImageCreateWithImageInRect([self CGImage], CGRectMake(sx, sy, swidth, sheight));
    CGContextDrawImage(bitmapContext_, CGRectMake(dx, dy, dwidth, dheight), imgInRect);
}

- (void)copy:(PImage *)srcImg 
            :(int)sx :(int)sy :(int)swidth :(int)sheight 
            :(int)dx :(int)dy :(int)dwidth :(int)dheight
{
    if (nil == srcImg) return;

    CGImageRef imgInRect = CGImageCreateWithImageInRect([srcImg CGImage], CGRectMake(sx, sy, swidth, sheight));
    CGContextDrawImage(bitmapContext_, CGRectMake(dx, dy, dwidth, dheight), imgInRect);
}

- (void)mask:(PImage *)mask
{
    // In RGB mode, alpha chanel is ignored.
    if (mode_ == RGB) return;
    // Must be the same size as self.
    if (mask.width != width || mask.height != height) return;
    
    [mask loadPixels];
    for (int i = 0; i < width * height; i++) {
        UInt32 alpha = (mask.pixels[i] & BLUE_MASK) >> BLUE_SHIFT;
        
        color c = data_[i];
        UInt8 currentAlpha = (c & ALPHA_MASK) >> ALPHA_SHIFT;
        
        if (currentAlpha == 0xFF) {
            if (alpha != 0xFF) {
                c = c & ~ALPHA_MASK ^ (alpha << ALPHA_SHIFT);
                data_[i] = premultiplyColor(c);               
            }
        } else {
            c = dePremultiplyColor(c);
            c = c & ~ALPHA_MASK ^ (alpha << ALPHA_SHIFT);
            data_[i] = premultiplyColor(c);            
        }
    }
}

- (void)blend:(int)x :(int)y :(int)w :(int)h 
             :(int)dx :(int)dy :(int)dwidth :(int)dheight 
             :(int)mode
{
    
}

- (void)blend:(PImage *)srcImg 
             :(int)x :(int)y :(int)w :(int)h 
             :(int)dx :(int)dy :(int)dwidth :(int)dheight 
             :(int)mode
{
    
}


- (void)filter:(int)mode
{
    [self filter:mode :1.0f];
}

- (void)filter:(int)mode :(float)param
{
    switch (mode) {
        case GRAY:
            break;
        case BLUR:
        case POSTERIZE:
        case INVERT:
        case THRESHOLD:
        case OPAQUE:
        default:
            break;
    }
}


/// Save to the camera roll album.
- (void)save:(NSString *)name
{}

- (void)resize:(int)w :(int)h
{
    if (width == w && height == h) return;
    
    CGImageRef cgImg = [self CGImage];
    
    CGContextRelease(bitmapContext_);
    free(data_);
    
    bitmapContext_ = [self createBitmapCGContextWithWidth:w 
                                                   height:h 
                                                     mode:mode_ 
                                                     data:NULL];
    width = w;
    height = h;
    CGContextDrawImage(bitmapContext_, CGRectMake(0, 0, w, h), cgImg);
    CGImageRelease(cgImg);
}

- (void)loadPixels
{
    size_t sz = width * height * sizeof(color);
    if (pixels == NULL) {
        pixels = (color *)malloc(sz);
    }
    
    if (mode_ == RGB) {
        memcpy(pixels, data_, sz);
    } else {
        for (int i  = 0; i < width * height; i++) {
            pixels[i] = dePremultiplyColor(data_[i]);
        }        
    }
}

- (void)updatePixels
{
    if (mode_ == RGB) {
        memcpy(data_, pixels, width * height * sizeof(color));
    } else {
        for (int i  = 0; i < width * height; i++) {
            data_[i] = premultiplyColor(pixels[i]);
        }        
    }
}

@end
