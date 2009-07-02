//
//  PStyle.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-25.
//  Copyright 2009 campl software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProcessingTypes.h"

@interface PStyle : NSObject<NSCopying> {
    
@private
    BOOL doFill;
    color fillColor;
    BOOL doStroke;
    color strokeColor;
    BOOL doTint;
    color tintColor;
    
    float strokeWeight;
    int strokeCap;
    int strokeJoin;
    
    int imageMode;
    int rectMode;
    int ellipseMode;
    
    int colorMode;
    float redRange;
    float greenRange;
    float blueRange;
    float alphaRange;
    
    // shapeMode(), 

    int textHorAlign;
    int textVerAlign;
    UIFont *curFont;
    int textMode;
    int textLeading;
    
    // emissive(), specular(), shininess(), ambient()
}

@property (assign) BOOL doFill;
@property (assign) color fillColor;
@property (assign) BOOL doStroke;
@property (assign) color strokeColor;
@property (assign) BOOL doTint;
@property (assign) color tintColor;

@property (assign) float strokeWeight;
@property (assign) int strokeCap;
@property (assign) int strokeJoin;

@property (assign) int imageMode;
@property (assign) int rectMode;
@property (assign) int ellipseMode;

@property (assign) int colorMode;
@property (assign) float redRange;
@property (assign) float greenRange;
@property (assign) float blueRange;
@property (assign) float alphaRange;

@property (assign) int textHorAlign;
@property (assign) int textVerAlign;
@property (retain, nonatomic) UIFont *curFont;
@property (assign) int textMode;
@property (assign) int textLeading;

@end
