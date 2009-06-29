//
//  PStyle.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-25.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PStyle.h"

@implementation PStyle

@synthesize doFill, fillColor, doStroke, strokeColor, doTint, tintColor;
@synthesize strokeCap, strokeJoin, strokeWeight;
@synthesize ellipseMode, rectMode, imageMode;
@synthesize colorMode, redRange, blueRange, greenRange, alphaRange;
@synthesize textHorAlign, textVerAlign, curFont, textLeading, textMode;

- (id)init
{
    if (self = [super init]) {
        doFill = YES;
        fillColor = 0xFFFFFFFF;
        doStroke = YES;
        strokeColor = 0x000000FF;
        doTint = NO;
        tintColor = 0;
        
        strokeCap = ROUND;
        strokeJoin = MITER;
        strokeWeight = 1;
        
        ellipseMode = CENTER;
        rectMode = CORNER;
        imageMode = CORNER;
        
        colorMode = RGB;
        redRange = blueRange = greenRange = alphaRange = 0xFF;
        
        textHorAlign = LEFT;
        textVerAlign = BASELINE;
        curFont = [[UIFont systemFontOfSize:17] retain];
        textLeading = 1.5;
        textMode = CORNER;
    }
    return self;
}

- (void)dealloc
{
    [curFont release];
    [super dealloc];
}

- (id)copyWithZone:(NSZone *)zone
{
    PStyle *copy = NSCopyObject(self, 0, zone);
    [copy.curFont retain];
    
    return copy;
}

@end
