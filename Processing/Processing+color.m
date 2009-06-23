//
//  Processing+color.m
//  BubbleTalk
//
//  Created by Kenan Che on 09-06-06.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Processing.h"

#define FULL_ALPHA                      (colorRanges_[3])
#define BLACK                           0xFF000000

static UInt8 colorValue(color clr, unsigned int component)
{
    if (component > 3) return 0;
    return (clr >> ((3 - component) * 8) & 0xFF);
}

@implementation Processing (Color)

- (void)background:(color)clr
{
    if (clr <= 255) {
        [self background:[self color:clr]];
    } else {
        float r, g, b, a;
        
        r = [self norm:colorValue(clr, R) :0.0f :255.0f];
        g = [self norm:colorValue(clr, G) :0.0f :255.0f];
        b = [self norm:colorValue(clr, B) :0.0f :255.0f];
        a = [self norm:colorValue(clr, A) :0.0f :255.0f];
        
        [graphics_ background:r :g :b :a];
        backgroundColor_ = clr;        
    }
}

- (void)background:(float)gray :(float)alpha
{
    [self background:[self color:gray :alpha]];
}

- (void)background:(float)val1 :(float)val2 :(float)val3
{
    [self background:[self color:val1 :val2 :val3]];
}

- (void)background:(float)val1 :(float)val2 :(float)val3 :(float)alpha
{
    [self background:[self color:val1 :val2 :val3 :alpha]];
}

/// Defautl color mode is (RGB, 255)
- (void)colorMode:(int)mode
{
    [self colorMode:mode :255.0f];
}

- (void)colorMode:(int)mode :(float)range
{
    [self colorMode:mode :range :range :range :range];
}

- (void)colorMode:(int)mode 
                 :(float)range1 
                 :(float)range2 
                 :(float)range3
{
    [self colorMode:mode :range1 :range2 :range3 :255.0f];
}

- (void)colorMode:(int)mode 
                 :(float)range1 
                 :(float)range2 
                 :(float)range3
                 :(float)range4
{
    switch (mode) {
        case HSB:
        case RGB:
            colorMode_ = mode;
            colorRanges_[0] = range1;
            colorRanges_[1] = range2;
            colorRanges_[2] = range3;
            colorRanges_[3] = range4;
            break;
        default:
            break;
    }
}

- (void)fill:(color)clr
{
    if (clr <= 255) {
        [self fill:[self color:clr]];
    } else {
        float r, g, b, a;
        
        r = [self norm:colorValue(clr, R) :0.0f :255.0f];
        g = [self norm:colorValue(clr, G) :0.0f :255.0f];
        b = [self norm:colorValue(clr, B) :0.0f :255.0f];
        a = [self norm:colorValue(clr, A) :0.0f :255.0f];
        
        [graphics_ fill:r :g :b :a];
        fillColor_ = clr;        
    }
}

- (void)fill:(float)gray :(float)alpha
{
    [self fill:[self color:gray :alpha]];
}

- (void)fill:(float)val1 :(float)val2 :(float)val3
{
    [self fill:[self color:val1 :val2 :val3]];
}

- (void)fill:(float)val1 :(float)val2 :(float)val3 :(float)alpha
{
    [self fill:[self color:val1 :val2 :val3 :alpha]];
}

- (void)noFill
{
    [graphics_ noFill];
}

- (void)noStroke
{
    [graphics_ noStroke];
}

- (void)stroke:(color)clr
{
    if (clr <= 255) {
        [self stroke:[self color:clr]];
    } else {
        float r, g, b, a;
        
        r = [self norm:colorValue(clr, R) :0.0f :255.0f];
        g = [self norm:colorValue(clr, G) :0.0f :255.0f];
        b = [self norm:colorValue(clr, B) :0.0f :255.0f];
        a = [self norm:colorValue(clr, A) :0.0f :255.0f];
        
        [graphics_ stroke:r :g :b :a];
        strokeColor_ = clr;        
    }
}

- (void)stroke:(float)gray :(float)alpha
{
    [self stroke:[self color:gray :alpha]];
}

- (void)stroke:(float)val1 :(float)val2 :(float)val3
{
    [self stroke:[self color:val1 :val2 :val3]];
}

- (void)stroke:(float)val1 :(float)val2 :(float)val3 :(float)alpha
{
    [self stroke:[self color:val1 :val2 :val3 :alpha]];
}

#pragma mark -
#pragma mark Color - Creating & Reading
#pragma mark -

- (color)alpha:(color)clr
{
    return clr & ALPHA_MASK;
}

- (color)blendColor:(color)c1 :(color)c2 :(int)mode
{
    return 0;    
}

- (color)blue:(color)clr
{
    return [self color:(clr & BLUE_MASK)];    
}

- (color)brightness:(color)clr
{
    float max = [self max:colorValue(clr, R) :colorValue(clr, G) :colorValue(clr, B)];

    int cm = colorMode_;    
    colorMode_ = HSB;
    
    color c = [self color:max];
    
    colorMode_ = cm;
    return c;    
}

- (color)color:(float)gray
{
    return [self color:gray :FULL_ALPHA];    
}

- (color)color:(float)gray :(float)alpha
{
    UInt32 c;
    
    if (gray <= 0) c = 0;
    if (gray >= 255) c = 255;   // For gray, color ranges of all components are not used.
    else c = (UInt32)gray;
    
    UInt32 a = [self normalizedColorComponent:alpha index:A];
    
    return c ^ (c << 8) ^ (c << 16) ^ (a << 24);    
}

- (color)color:(float)val1 :(float)val2 :(float)val3
{
    return [self color:val1 :val2 :val3 :FULL_ALPHA];
}

- (UInt8)normalizedColorComponent:(float)val index:(int)i
{
    UInt32 c;
    if (val <= 0)
        c = 0;
    else if (val >= colorRanges_[i])
        c = 255;
    else
        c = (UInt32)(val / colorRanges_[i] * 255);
    return c;
}

- (color)color:(float)val1 :(float)val2 :(float)val3 :(float)val4
{
    UInt8 v1 = [self normalizedColorComponent:val1 index:R];
    UInt8 v2 = [self normalizedColorComponent:val2 index:G];
    UInt8 v3 = [self normalizedColorComponent:val3 index:B];
    UInt8 alpha = [self normalizedColorComponent:val4 index:A];
    
    UInt8 r, g, b;
    if (colorMode_ == HSB) {
        float h, s, v, f, p, q, t;
        h = v1 * 360.0f / 255; s = v2; v = v3;
        
        if (s == 0) {
            r = g = b = v;
        } else {
            f = h / 60.0f - roundf(h / 60.0f);
            p = v * (255 - s) / 255.0f;
            q = v * (255 - f * s) / 255.0f;
            t = v * (255 - (1 - f) * s) / 255.0f;
            switch ((int)roundf(h / 60.0f) % 6) {
                case 0:
                    r = v; g = t; b = p;
                    break;
                case 1:
                    r = q; g = v; b = p;
                    break;
                case 2:
                    r = p; g = v; b = t;
                    break;
                case 3:
                    r = p; g = q; b = v;
                    break;
                case 4:
                    r = t; g = p; b = v;
                    break;
                case 5:
                    r = v; g = p; b = q;
                    break;
                default:
                    r = g = b = v;
                    break;
            }
        }
    } else {
        r = v1; g = v2; b = v3;
    }
    
    color c = alpha << 24;
    c ^= r << 16;
    c ^= g << 8;
    c ^= b;
    
    return c;
}

- (color)green:(color)clr
{
    return [self color:((clr & GREEN_MASK) >> 8)];    
}

- (color)hue:(color)clr
{
    color c, r, g, b, min, max;
    r = colorValue(clr, R);
    g = colorValue(clr, G);
    b = colorValue(clr, B);
    
    max = [self max:r :g :b];
    min = [self min:r :g :b];
    
    int cm = colorMode_;    
    colorMode_ = HSB;

    float h;
    if (max == min) {
        h = 0;
    } else if (max == r) {
        h = (int)(60.0f * (g - b) / (max - min) + 360) % 360;
    } else if (max == g) {
        h = 60.0f * (b - r) / (max - min) + 120;
    } else {
        h = 60.0f * (r - g) / (max - min) + 240;
    }
    h = h * 255.0f / 360.0f;
    c = [self color:h];
        
    colorMode_ = cm;
    return c;    
}

- (color)lerpColor:(color)c1 :(color)c2 :(float)amt
{
    return 0;    
}

- (color)red:(color)clr
{
    return [self color:((clr & RED_MASK) >> 16)];    
}

- (color)saturation:(color)clr
{
    float r, g, b;
    r = colorValue(clr, R);
    g = colorValue(clr, G);
    b = colorValue(clr, B);
    
    color max = [self max:r :g :b];
    color min = [self min:r :g :b];
    
    int cm = colorMode_;    
    colorMode_ = HSB;
    
    color c;
    if (max == 0) {
        c = [self color:0];
    } else if (max - min < EPSILON) {
        c = [self color:255];
    } else {
        c = [self color:(1 - min / max) * 255.0f];
    }
    
    colorMode_ = cm;    
    return c;    
}

@end
