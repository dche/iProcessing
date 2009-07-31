//
//  PImage.m
//  Processing Touch
//
//  Created by Kenan Che on 09-06-08.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PImage.h"

static inline GLsizei nearestExp2(NSUInteger num)
{
    if (num < 2) return 0;
    
    NSUInteger m = 2;
    while (m < num) m <<= 1;
    return m;
}

@interface PImage ()

- (CGContextRef)createBitmapCGContextWithWidth:(NSUInteger)w 
                                        height:(NSUInteger)h 
                                        format:(int)imgFormat
                                          data:(const color *)d;

- (void)createBitmapCGContext;
- (void)releaseBitmapCGContext;
- (void)copyFromBitmapCGContextAndReleaseIt;

@end


@implementation PImage
@synthesize width, height;
@synthesize pixels;

- (id)initWithWidth:(NSUInteger)w 
             height:(NSUInteger)h 
             format:(int)imgFormat
               data:(const void *)d
{
    if (self = [super init]) {
        pixels = calloc(w * h, sizeof(color));

        if (pixels == NULL) {
            [self release];
            return nil;
        }
        
        width = w;
        height = h;
        format_ = imgFormat;
        
        if (d != NULL) {
            memcpy(pixels, d, w * h * sizeof(color));
        }
    }
    return self;
}

- (id)initWithWidth:(NSUInteger)w height:(NSUInteger)h format:(int)imgFormat
{
    return [self initWithWidth:w height:h format:imgFormat data:nil];
}

- (id)initWithCGImage:(CGImageRef)img
{
    if (img == NULL) return nil;
    
    width = CGImageGetWidth(img);
    height = CGImageGetHeight(img);

    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(img);
    format_ = RGBA;
    if (alpha == kCGImageAlphaNone || alpha == kCGImageAlphaNoneSkipFirst || alpha == kCGImageAlphaNoneSkipLast) {
        format_ = RGB;
    }
    
    if (self = [super init]) {
        pixels = malloc(width * height * sizeof(color));
        bitmapContext_ = [self createBitmapCGContextWithWidth:width 
                                                       height:height 
                                                       format:format_
                                                         data:NULL];
        if (pixels == NULL || bitmapContext_ == NULL) {
            [self release];
            return nil;
        }
        CGContextDrawImage(bitmapContext_, CGRectMake(0, 0, width, height), img);

        [self copyFromBitmapCGContextAndReleaseIt];
    }
    return self;
}

- (void)dealloc
{
    [self releaseBitmapCGContext];
    free(pixels);
    
    if (textureObject_ > 0) {
        glDeleteTextures(1, &textureObject_);
    }
    
    [super dealloc];
}

- (CGContextRef)createBitmapCGContextWithWidth:(NSUInteger)w 
                                        height:(NSUInteger)h 
                                        format:(int)imgFormat
                                          data:(const color *)d
{
    CGContextRef    context = NULL;    
    CGColorSpaceRef colorSpace;    

    if (imgFormat == RGB) {
        data_ = pixels;
        
        if (d != NULL && d != pixels) {
            memcpy(data_, d, w * h * sizeof(color));
        }
    } else {
        data_ = (color *)calloc(w * h, sizeof(color));
        if (data_ == NULL) {
            return NULL;
        }
        if (d != NULL) {
            for (int i = 0; i < w * h; i++) {
                data_[i] = premultiplyColor(d[i]);
            }
        }        
    }
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = (imgFormat == RGBA) ? (kCGImageAlphaPremultipliedLast) : (kCGImageAlphaNoneSkipLast);
    
    context = CGBitmapContextCreate (data_,
                                     w,
                                     h,
                                     8,
                                     w * 4,
                                     colorSpace,
                                     bitmapInfo);
    
    CGColorSpaceRelease( colorSpace );
    return context;
}

- (void)createBitmapCGContext
{
    if (bitmapContext_ == NULL) {
        bitmapContext_ = [self createBitmapCGContextWithWidth:width 
                                                       height:height 
                                                       format:format_ 
                                                         data:pixels];
    }
}

- (void)releaseBitmapCGContext
{
    if (bitmapContext_ != NULL) {
        CGContextRelease(bitmapContext_);        
        if (pixels != data_) free(data_);
        
        bitmapContext_ = NULL;
        data_ = NULL;
    }
}

- (void)copyFromBitmapCGContextAndReleaseIt
{
    if (bitmapContext_ != NULL) {
        if (format_ == RGBA) {
            for (int i = 0; i < width * height; i++) {
                pixels[i] = dePremultiplyColor(data_[i]);
            }            
        }
        [self releaseBitmapCGContext];
    }
}

- (CGImageRef)CGImage
{
    if (bitmapContext_ == nil) {
        [self createBitmapCGContext];
    }
    CGImageRef img = CGBitmapContextCreateImage(bitmapContext_);
    [self releaseBitmapCGContext]; 
    
    return img;
}

- (color)get:(int)x :(int)y
{
    return pixels[cordsToIndex(x, y, width, height, NO)];
}

- (PImage *)get
{
    PImage *img = [[PImage alloc] initWithWidth:width height:height format:format_ data:pixels];
    return [img autorelease];
}

- (PImage *)get:(int)x1 :(int)y1 :(int)x2 :(int)y2
{
    // TODO: honor the imageMode.
    CGRect rect = CGRectMake(x1, y1, x2, y2);
    CGImageRef imgInRect = CGImageCreateWithImageInRect([self CGImage], rect);
    
    if (imgInRect == NULL) return nil;    
    return [[[PImage alloc] initWithCGImage:imgInRect] autorelease];
}

- (void)set:(int)x :(int)y :(color)clr
{
    pixels[cordsToIndex(x, y, width, height, NO)] = clr;
}


- (void)copy:(int)sx :(int)sy :(int)swidth :(int)sheight 
            :(int)dx :(int)dy :(int)dwidth :(int)dheight
{
}

- (void)copy:(PImage *)srcImg 
            :(int)sx :(int)sy :(int)swidth :(int)sheight 
            :(int)dx :(int)dy :(int)dwidth :(int)dheight
{
}

- (void)mask:(PImage *)mask
{
    // Must be the same size as of self.
    if (mask.width != width || mask.height != height) return;
    
    for (int i = 0; i < width * height; i++) {
        UInt32 alpha = colorValue(mask.pixels[i], B);
        pixels[i] &= ~ALPHA_MASK ^ (alpha << ALPHA_SHIFT);
    }
    format_ = RGBA;
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
    [self filter:mode :defaultImageFilterParam(mode)];
}

- (void)filter:(int)mode :(float)param
{
    imageFilter(mode, param, pixels, width * height, format_ == RGBA);
}

/// Save to the camera roll album.
- (void)save:(NSString *)name
{
    UIImageWriteToSavedPhotosAlbum([UIImage imageWithCGImage:[self CGImage]], nil, nil, NULL);
}

- (void)resize:(int)w :(int)h
{
    if (width == w && height == h) return;
    
    // Store image data to CGImage
    CGImageRef cgImg = [self CGImage];
    
    free(pixels);
    pixels = malloc(w * h * sizeof(color));
    
    width = w;
    height = h;
    
    bitmapContext_ = [self createBitmapCGContextWithWidth:w 
                                                   height:h 
                                                   format:format_ 
                                                     data:NULL];
    CGContextDrawImage(bitmapContext_, CGRectMake(0, 0, w, h), cgImg);
    CGImageRelease(cgImg);
    
    [self copyFromBitmapCGContextAndReleaseIt];
}

- (void)loadPixels
{}

- (void)updatePixels
{}

#pragma mark -
#pragma mark OpenGL Texture
#pragma mark -

- (GLuint)textureObject
{
    return textureObject_;
}

- (BOOL)hasAlpha
{
    return (format_ == RGBA);
}

- (void)mipmap:(BOOL)yesno
{
    mipmap_ = yesno;
}

- (BOOL)mipmap
{
    return mipmap_;
}

- (BOOL)createTextureObject
{
    if (textureObject_ > 0) {
        glDeleteTextures(1, &textureObject_);
    }
    
    NSUInteger w = nearestExp2(width);
    NSUInteger h = nearestExp2(height);
    
    GLvoid *data;
    PImage *img;
    if (w != width || h != height) {
        img = [self get];
        [img resize:w :h];
        data = img.pixels;
    } else {
        data = pixels;
    }
    
    glGenTextures(1, &textureObject_);
    glBindTexture(GL_TEXTURE_2D, textureObject_);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, w, h, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
    
    if (mipmap_)
        glGenerateMipmapOES(GL_TEXTURE_2D);
    
    GLenum err = glGetError();
    if (err != GL_NO_ERROR)
    {
        NSLog(@"Error uploading texture. glError: 0x%04X", err);
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark Texture for text
#pragma mark -

+ (PImage *)textureOfString:(NSString *)str withFont:(UIFont *)font inColor:(PColor)clr
{
    CGSize sz = [str sizeWithFont:font];
    if (sz.width == 0 || sz.height == 0) return nil;
    
    PImage *img = [[PImage alloc] initWithWidth:nearestExp2(sz.width) height:nearestExp2(sz.width) format:RGBA];
    [img drawText:str withFont:font inColor:clr];
    
    return [img autorelease];
}

- (void)drawText:(NSString *)str withFont:(UIFont *)font inColor:(PColor)clr
{
    if (bitmapContext_ == NULL) {
        [self createBitmapCGContext];
    }
    
    // Flip the Y-axis because we use NSString#drawAtPoint::
    CGContextConcatCTM(bitmapContext_, CGAffineTransformMake(1, 0, 0, -1, 0, height));
    CGContextSetRGBFillColor(bitmapContext_, clr.red, clr.green, clr.blue, clr.alpha);    
    UIGraphicsPushContext(bitmapContext_);
    [str drawAtPoint:CGPointMake(0, 0) withFont:font];
    UIGraphicsPopContext();
    
    [self copyFromBitmapCGContextAndReleaseIt];
}

@end
