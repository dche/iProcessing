//
//  Processing+image.m
//  Processing Touch
//
//  Created by Kenan Che on 09-06-06.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Processing+image.h"
#import "Processing.h"

@implementation Processing (Image)

- (PImage *)createImage:(int)width :(int)height :(int)mode
{
    return nil;
}

- (void)image:(PImage *)img :(float)x :(float)y
{
    
}

- (void)image:(PImage *)img :(float)x :(float)y :(float)width :(float)height
{
    
}

- (void)imageMode:(int)mode
{
    switch (mode) {
        case CORNER:
        case CORNERS:
        case CENTER:
            curStyle_.imageMode = mode;
            break;
        default:
            break;
    }
}

- (PImage *)loadImage:(NSString *)name
{
    return nil;
}

- (void)noTint
{
    [graphics_ noTint];
    curStyle_.doTint = NO;
}

- (PImage *)requestImage:(NSString *)name
{
    return [self loadImage:name];
}

- (void)tint:(color)clr
{
    if (clr < 0x1000000) {
        [self tint:[self color:clr]];
    } else {
        PColor pc = PColorMake(clr);
        
        [graphics_ tint:pc.red :pc.green :pc.blue :pc.alpha];
        curStyle_.tintColor = clr;
        curStyle_.doTint = YES;
    }
}

- (void)tint:(float)gray :(float)alpha
{
    [self tint:[self color:gray :alpha]];
}

- (void)tint:(float)val1 :(float)val2 :(float)val3
{
    [self tint:[self color:val1 :val2 :val3]];
}

- (void)tint:(float)val1 :(float)val2 :(float)val3 :(float)alpha
{
    [self tint:[self color:val1 :val2 :val3 :alpha]];
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

- (void)copy:(int)sx :(int)sy :(int)swidth :(int)sheight 
            :(int)dx :(int)dy :(int)dwidth :(int)dheight
{
    
}

- (void)copy:(PImage *)srcImg 
            :(int)sx :(int)sy :(int)swidth :(int)sheight 
            :(int)dx :(int)dy :(int)dwidth :(int)dheight
{
    
}

- (void)filter:(int)mode
{
    
}

- (void)filter:(int)mode :(float)param
{
    
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

- (void)loadPixels
{
    
}

- (void)set:(int)x :(int)y :(color)clr
{
    
}

- (void)updatePixels
{
    
}

@end
