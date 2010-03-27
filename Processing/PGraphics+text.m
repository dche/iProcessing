//
//  PGraphics+text.m
//  Processing Touch
//
//  Created by Kenan Che on 09-06-06.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PGraphics+text.h"

@implementation PGraphics (Text)

- (void)text:(NSString *)str :(float)x :(float)y
{
    [self text:str :x :y :0];
}

- (void)text:(NSString *)str :(float)x :(float)y :(float)z
{
    float rx = x, ry = y;
    switch (curStyle_.textHorAlign) {
        case CENTER:
            rx = x - [self textWidth:str] / 2.0f;
            break;
        case RIGHT:
            rx = x - [self textWidth:str];
            break;
        case LEFT:
        default:
            break;
    }
    
    switch (curStyle_.textVerAlign) {
        case BOTTOM:
            ry = y - [self textAscent] - [self textDescent];
        case BASELINE:
            ry = y - [self textAscent];
            break;
        case TOP:
        default:
            break;
    }
    
    [renderer_ showText:str :rx :ry :z];
}

- (void)text:(NSString *)str :(float)x :(float)y :(float)width :(float)height
{
    // TODO: we need a small layout manager. Finish this after core text is available on iPhone?
}

- (void)text:(NSString *)str :(float)x :(float)y :(float)width :(float)height :(float)z
{
    // INCOMPLETE: text layout manager.
}


- (void)textFont:(UIFont *)font
{
    if (font == nil) return;
    curStyle_.curFont = font;
    [renderer_ textFont:font];
}

- (void)textFont:(UIFont *)font :(float)size
{
    if (font == nil) return;
    if (size < EPSILON) return;
    curStyle_.curFont = [font fontWithSize:size];
    [renderer_ textFont:curStyle_.curFont];
}


- (void)textAlign:(int)align
{
    switch (align) {
        case LEFT:
        case RIGHT:
        case CENTER:
            curStyle_.textHorAlign = align;
            break;
        default:
            break;
    }
}

- (void)textAlign:(int)align :(int)yalign
{
    [self textAlign:align];
    switch (yalign) {
        case TOP:
        case BOTTOM:
        case BASELINE:
            curStyle_.textVerAlign = yalign;
            break;
        default:
            break;
    }
}


- (void)textLeading:(float)dist
{
    if (dist < EPSILON) return;
    curStyle_.textLeading = dist;
}


- (void)textMode:(int)mode
{
    switch (mode) {
        case MODEL:
        // case SCREEN:
        // case SHAPE:
            curStyle_.textMode = mode;
            break;
        default:
            break;
    }
}

/// Change the point size of current font.
- (void)textSize:(float)size
{
    [self textFont:curStyle_.curFont :size];
}


- (float)textWidth:(NSString *)str
{
    CGSize sz = [str sizeWithFont:curStyle_.curFont];
    // CHECK: necessary to convert point size to pixel?
    return sz.width;
}


- (float)textAscent
{
    return curStyle_.curFont.ascender;
}

- (float)textDescent
{
    return curStyle_.curFont.descender;
}

@end
