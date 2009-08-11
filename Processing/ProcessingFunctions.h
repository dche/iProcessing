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
    
    return formColor(r, g, b, a);
}

static inline color dePremultiplyColor(UInt32 clr)
{
    UInt32 a = colorValue(clr, A);
    if (a == 0xFF) return clr;
    
    float ia = 255.0f / a;
    UInt8 r = ia * colorValue(clr, R);
    UInt8 g = ia * colorValue(clr, G);
    UInt8 b = ia * colorValue(clr, B);
    
    return formColor(r, g, b, a);
}

#pragma mark -
#pragma mark Image Processing - Blend
#pragma mark -

static inline int alphaBlend(int c1, int c2, int alpha)
{
    return p_constrain(c1 + (c2 - c1) * alpha >> 8, 0, 255);
}

static inline color blendColor(color sc, color dc, int mode)
{
    if (mode == REPLACE) return sc;
    
    int sr = colorValue(sc, R);
    int sg = colorValue(sc, G);
    int sb = colorValue(sc, B);
    int sa = colorValue(sc, A);
    
    int dr = colorValue(dc, R);
    int dg = colorValue(dc, G);
    int db = colorValue(dc, B);
    int da = colorValue(dc, A);

    int factor = sa;
    
    int cr, cg, cb;
    UInt32 r, g, b, a;
    
    a = MIN(da + factor, 255);
    switch (mode) {
        case ADD:
            // additive blending with white clip: C = min(A*factor + B, 255)
            r = MIN((sr * factor >> 8) + dr, 255);
            g = MIN((sg * factor >> 8) + dg, 255);
            b = MIN((sb * factor >> 8) + db, 255);
            break;
        case SUBTRACT:
            // subtractive blending with black clip: C = max(B - A*factor, 0)
            r = MAX(dr - (sr * factor >> 8), 0);
            g = MAX(dg - (sg * factor >> 8), 0);
            b = MAX(db - (sb * factor >> 8), 0);
            break;
        case DARKEST:
            // only the darkest colour succeeds: C = min(A*factor, B)
            r = MIN(sr * factor >> 8, dr);
            g = MIN(sg * factor >> 8, dg);
            b = MIN(sb * factor >> 8, db);
            break;
        case LIGHTEST:
            // only the lightest colour succeeds: C = max(A*factor, B)
            r = MAX(sr * factor >> 8, dr);
            g = MAX(sg * factor >> 8, dg);
            b = MAX(sb * factor >> 8, db);
            break;
        case DIFFERENCE:
            // C = |A - B|
            r = alphaBlend(dr, p_abs(dr - sr), factor);
            g = alphaBlend(dg, p_abs(dg - sg), factor);
            b = alphaBlend(db, p_abs(db - sb), factor);
            break;
        case EXCLUSION:
            // Use the same algorithm of Processing source.
            // Quote of the original comments:
                /**
                 * Cousin of difference, algorithm used here is based on a Lingo version
                 * found here: http://www.mediamacros.com/item/item-1006687616/
                 * (Not yet verified to be correct).
                 */ 
            r = alphaBlend(dr, sr + dr - (sr * dr >> 7), factor);
            g = alphaBlend(dg, sg + dg - (sg * dg >> 7), factor);
            b = alphaBlend(db, sb + db - (sb * db >> 7), factor);
        case MULTIPLY:
            // C = A * B
            r = alphaBlend(dr, sr * dr >> 8, factor);
            g = alphaBlend(dg, sg * dg >> 8, factor);
            b = alphaBlend(db, sb * db >> 8, factor);
        case SCREEN:
            // The inverse of multiply.  C = 1 - (1-A) * (1-B)
            r = alphaBlend(dr, 255 - ((255 - sr) * (255 - dr) >> 8), factor);
            g = alphaBlend(dg, 255 - ((255 - sg) * (255 - dg) >> 8), factor);
            b = alphaBlend(db, 255 - ((255 - sb) * (255 - db) >> 8), factor);
        case OVERLAY:
            cr = dr < da ? 2 * sr * dr : 255 - 2 * ((255 - sr) * (255 - dr) >> 8);
            r = alphaBlend(dr, cr, factor);
            cg = dg < da ? 2 * sg * dg : 255 - 2 * ((255 - sg) * (255 - dg) >> 8);
            r = alphaBlend(dg, cg, factor);
            cb = db < da ? 2 * sb * db : 255 - 2 * ((255 - sb) * (255 - db) >> 8);
            r = alphaBlend(db, cb, factor);            
        case HARD_LIGHT:
            cr = sr < 128 ? 2 * sr * dr : 255 - 2 * ((255 - sr) * (255 - dr) >> 8);
            r = alphaBlend(dr, cr, factor);
            cg = sg < 128 ? 2 * sg * dg : 255 - 2 * ((255 - sg) * (255 - dg) >> 8);
            r = alphaBlend(dg, cg, factor);
            cb = sb < 128 ? 2 * sb * db : 255 - 2 * ((255 - sb) * (255 - db) >> 8);
            r = alphaBlend(db, cb, factor);                        
        case SOFT_LIGHT:
        case DODGE:
        case BURN:
            break;
        case BLEND:
        default:
            // linear interpolation of colours: C = A*factor + B
            r = alphaBlend(sr, dr, factor);
            g = alphaBlend(sg, dg, factor);
            b = alphaBlend(sb, db, factor);
            break;
    }
    return formColor(r, g, b, a);
}

static inline void blendImage(const color *src, int imgWidth, int imgHeight, 
                              int sx, int sy, int swidth, int sheight, 
                              color *tgt, int tgtImgWidht, int tgtImgHeight, 
                              int dx, int dy, int dwidth, int dheight, 
                              int mode)
{    
    BOOL needResize = (dwidth != swidth || dheight != sheight);
    
    if (needResize) {
        float deltax, deltay, u, v;
        
        deltax = 1.0f / dwidth;
        deltay = 1.0f / dheight;
        
        u = 0;
        for (int x = 0; x < dwidth; x++) {
            v = 0;
            for (int y = 0; y < dheight; y++) {                                
                float basex = swidth * u;
                float basey = sheight * v;
                
                float ix = floorf(basex);
                float iy = floorf(basey);
                float factx = basex - ix;
                float facty = basey - iy;
                
                color c00, c01, c10, c11;
                NSUInteger sidx = cordsToIndex(sx + ix, sy + iy, imgWidth, imgHeight, NO);
                
                c00 = src[sidx];
                c01 = src[sidx + (ix == swidth - 1 ? 0 : 1)];
                c10 = src[sidx + (iy == sheight - 1 ? 0 : imgWidth)];
                c11 = src[sidx + (iy == sheight - 1 ? 0 : imgWidth) + (ix == swidth - 1 ? 0 : 1)];                
                color sc = lerpColor(lerpColor(c00, c01, factx), lerpColor(c10, c11, factx), facty);
                
                NSUInteger didx = cordsToIndex(dx + x, dy + y, tgtImgWidht, tgtImgHeight, NO);
                color dc = tgt[didx];
                
                tgt[didx] = blendColor(sc, dc, mode);
                v += deltay;
            }
            u += deltax; 
        }
    } else {
        color *pixels = NULL;
        NSUInteger ox, oy, w, h;
        
        if (src == tgt && CGRectIntersectsRect(CGRectMake(sx, sy, swidth, sheight), CGRectMake(dx, dy, dwidth, dheight))) {
            pixels = malloc(dwidth * dheight * sizeof(color));
            ox = 0; oy = 0;
            w = dwidth; h = dheight;
            
            for (int i = 0; i < h; i++) {
                memcpy(pixels + i * w, src + (sy + i) * w + dx, h * sizeof(color));
            }        
        } else {
            pixels = (color *)src;
            ox = sx; oy = sy;
            w = imgWidth; h = imgHeight;            
        }
        
        if (mode != REPLACE) {
            for (int x = 0; x < dwidth; x++) {
                for (int y = 0; y < dheight; y++) {
                    color sc = pixels[cordsToIndex(ox + x, oy + y, w, h, NO)];                
                    NSUInteger didx = cordsToIndex(dx + x, dy + y, tgtImgWidht, tgtImgHeight, NO);
                    color dc = tgt[didx];
                    
                    tgt[didx] = blendColor(sc, dc, mode);
                }
            }        
        } else {
            // TODO: better way to move bytes?
            for (int i = 0; i < dheight; i++) {
                memcpy(tgt + (dy + i) * tgtImgWidht + dx, pixels + (oy + i) * w + ox, dwidth * sizeof(color));
            }        
        }
        
        if (pixels != src) {
            free(pixels);
        }        
    }
}

#pragma mark -
#pragma mark Image Processing - Filters
#pragma mark -

static inline float defaultImageFilterParam(int mode)
{
    switch (mode) {
        case THRESHOLD:
            return 0.5f;
        case POSTERIZE:
            return 10;
        default:
            break;
    }
    return 1.0f;
}

static inline void imageFilter(int mode, float param, color *pixels, NSUInteger size, BOOL hasAlpha)
{
    switch (mode) {
        case GRAY:
            for (int i = 0; i < size; i++) {
                color c = pixels[i];
                UInt8 r = colorValue(c, R);
                UInt8 g = colorValue(c, G);
                UInt8 b = colorValue(c, B);
                
                UInt8 lum = 0.30f * r + 0.59f * g + 0.11f * b;
                pixels[i] = c & ALPHA_MASK ^ (lum << RED_SHIFT) ^ (lum << GREEN_SHIFT) ^ (lum << BLUE_SHIFT);
            }
            break;
        case BLUR:
            
            break;
        case POSTERIZE:
            if (param >= 2 && param <= 255) {
                int levels = 255 / (param - 1);
                
                for (int i = 0; i < size; i++) {
                    color c = pixels[i];
                    UInt16 r = ((colorValue(c, R) * (uint)param) >> 8) * levels;
                    UInt16 g = ((colorValue(c, G) * (uint)param) >> 8) * levels;
                    UInt16 b = ((colorValue(c, B) * (uint)param) >> 8) * levels;
                    
                    pixels[i] = c & ALPHA_MASK ^ (r << RED_SHIFT) ^ (g << GREEN_SHIFT) ^ (b << BLUE_SHIFT);
                }
            }
            break;
        case INVERT:
            for (int i = 0; i < size; i++) {
                pixels[i] ^= PFullColor;
            }
            break;
        case THRESHOLD:
            if (param >= 0 && param <= 1) {
                float thresh = param * 255.0f;
                for (int i = 0; i < size; i++) {
                    color c = pixels[i];
                    float max = MAX(colorValue(c, R), MAX(colorValue(c, G), colorValue(c, B)));
                    pixels[i] = c & ALPHA_MASK | ((max > thresh) ? PFullColor : 0x0);
                }                
            }
            break;
        case OPAQUE:
            for (int i = 0; i < size; i++) {
                pixels[i] |= ALPHA_MASK; 
            }
            break;
        case ERODE:
        case DILATE:
        default:
            break;
    }    
}
