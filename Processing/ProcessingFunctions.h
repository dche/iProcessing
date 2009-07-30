/*
 *  ProcessingFunctions.h
 *  iProcessing
 *
 *  Created by Kenan Che on 09-07-02.
 *  Copyright 2009 campl software. All rights reserved.
 *
 */

#import "ProcessingTypes.h"

#pragma mark -
#pragma mark Shape
#pragma mark -

static inline CGRect normalizedRectangle(float x1, float y1, float x2, float y2 , int mode)
{
    float ox, oy, w, h;
    switch (mode) {
        case CENTER:
            ox = x1 - x2 / 2.0f;
            oy = y1 - y2 / 2.0f;
            w = x2; h = y2;
            break;
        case RADIUS:
            ox = x1 - x2;
            oy = y1 - y2;
            w = x2 * 2.0f;
            h = y2 * 2.0f;
            break;
        case CORNERS:
            ox = x1; oy = y1;
            w = x2 - x1; h = y2 - y1;
            break;
        case CORNER:
            ox = x1; oy = y1;
            w = x2; h = y2;
        default:
            break;
    }
    return CGRectMake(ox, oy, w, h);    
}

#pragma mark -
#pragma mark Pixel by pixel
#pragma mark -

static inline NSUInteger cordsToIndex(NSUInteger x, NSUInteger y, NSUInteger width, NSUInteger height, BOOL flipY)
{
    if (x >= width) x = width - 1;
    if (y >= height) y = height - 1;
    
    y = (flipY) ? (height - y - 1) : (y);
    return y * width + x;
}

static inline UInt32 premultiplyColor(color clr)
{
    UInt32 a = colorValue(clr, A);
    if (a == 0xFF) return clr;
    
    UInt8 r = (a * colorValue(clr, R)) >> 8;
    UInt8 g = (a * colorValue(clr, G)) >> 8;
    UInt8 b = (a * colorValue(clr, B)) >> 8;
    
    return (a << ALPHA_SHIFT) ^ (b << BLUE_SHIFT) ^ (g << GREEN_SHIFT) ^ (r << RED_SHIFT);
}

static inline color dePremultiplyColor(UInt32 clr)
{
    UInt32 a = colorValue(clr, A);
    if (a == 0xFF) return clr;
    
    float ia = 255.0f / a;
    UInt8 r = ia * colorValue(clr, R);
    UInt8 g = ia * colorValue(clr, G);
    UInt8 b = ia * colorValue(clr, B);
    
    return (a << ALPHA_SHIFT) ^ (b << BLUE_SHIFT) ^ (g << GREEN_SHIFT) ^ (r << RED_SHIFT);
}

#pragma mark -
#pragma mark Image Processing
#pragma mark -

