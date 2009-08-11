//
//  PGraphics+color.h
//  Processing Touch
//
//  Created by Kenan Che on 09-06-06.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGraphics.h"

@interface PGraphics (Color)

#pragma mark -
#pragma mark Color - Setting
#pragma mark -

- (void)background:(color)clr;
- (void)background:(float)gray :(float)alpha;
- (void)background:(float)val1 :(float)val2 :(float)val3;
- (void)background:(float)val1 :(float)val2 :(float)val3 :(float)alpha;
- (void)colorMode:(int)mode;
- (void)colorMode:(int)mode :(float)range;
- (void)colorMode:(int)mode 
                 :(float)range1 
                 :(float)range2 
                 :(float)range3;
- (void)colorMode:(int)mode 
                 :(float)range1 
                 :(float)range2 
                 :(float)range3
                 :(float)range4;
- (void)fill:(color)clr;
- (void)fill:(float)gray :(float)alpha;
- (void)fill:(float)val1 :(float)val2 :(float)val3;
- (void)fill:(float)val1 :(float)val2 :(float)val3 :(float)alpha;
- (void)noFill;
- (void)noStroke;
- (void)stroke:(color)clr;
- (void)stroke:(float)gray :(float)alpha;
- (void)stroke:(float)val1 :(float)val2 :(float)val3;
- (void)stroke:(float)val1 :(float)val2 :(float)val3 :(float)alpha;

#pragma mark -
#pragma mark Color - Creating & Reading
#pragma mark -

- (color)color:(float)gray;
- (color)color:(float)gray :(float)alpha;
- (color)color:(float)val1 :(float)val2 :(float)val3;
- (color)color:(float)val1 :(float)val2 :(float)val3 :(float)val4;

- (UInt8)normalizedColorComponent:(float)val range:(float)r;

- (float)alpha:(color)clr;
- (color)blendColor:(color)c1 :(color)c2 :(int)mode;
- (float)blue:(color)clr;
- (float)brightness:(color)clr;
- (float)green:(color)clr;
- (float)hue:(color)clr;
- (color)lerpColor:(color)c1 :(color)c2 :(float)amt;
- (float)red:(color)clr;
- (float)saturation:(color)clr;

@end
