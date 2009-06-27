//
//  PImage.m
//  Processing Touch
//
//  Created by Kenan Che on 09-06-08.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PImage.h"

@interface PImage ()

- (CGContextRef)createBitmapCGContextWithWidth:(NSUInteger)w height:(NSUInteger)h mode:(int)imgMode;

@end


@implementation PImage

- (id)initWithContext:(CGContextRef)c
{
    if (c == NULL) return NULL;
    
    if (self = [super init]) {
    }
    return self;
}

- (id)initWithWidth:(NSUInteger)w height:(NSUInteger)h mode:(int)imgMode
{
    CGContextRef c = [self createBitmapCGContextWithWidth:w height:h mode:imgMode];
    return [self initWithContext:c];
}

- (void)dealloc
{
    [super dealloc];
}

- (CGContextRef)createBitmapCGContextWithWidth:(NSUInteger)w 
                                        height:(NSUInteger)h 
                                          mode:(int)imgMode
{
    CGContextRef    context = NULL;    
    CGColorSpaceRef colorSpace;    
    int             bitmapBytesPerRow;    
    
    bitmapBytesPerRow   = (w * 4);        
    colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = (imgMode == ARGB) ? (kCGImageAlphaPremultipliedFirst) : (kCGImageAlphaNone);
    
    context = CGBitmapContextCreate (NULL,
                                     w,
                                     h,
                                     8,
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     bitmapInfo);
    
    CGColorSpaceRelease( colorSpace );
    return context;
}

- (color)get:(int)x :(int)y
{
    return 0;
}

- (PImage *)get
{
    return nil;
}

- (PImage *)get:(int)x1 :(int)y1 :(int)x2 :(int)y2
{
    return nil;
}

- (void)set:(int)x :(int)y :(color)clr
{
    
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
    
}

- (void)blend:(int)x :(int)y :(int)width :(int)height 
             :(int)dx :(int)dy :(int)dwidth :(int)dheight 
             :(int)mode
{
    
}

- (void)blend:(PImage *)srcImg 
             :(int)x :(int)y :(int)width :(int)height 
             :(int)dx :(int)dy :(int)dwidth :(int)dheight 
             :(int)mode
{
    
}


- (void)filter:(int)mode
{
    
}

- (void)filter:(int)mode :(float)param
{
    
}


/// Save to the camera roll album.
- (void)save:(NSString *)name
{
    
}


- (void)resize:(int)width :(int)height
{
    
}


- (void)loadPixels
{
    
}

- (void)updatePixels
{
    
}


@end
