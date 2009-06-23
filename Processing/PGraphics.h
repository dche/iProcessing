//
//  PGraphics.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-16.
//  Copyright 2009 campl software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Processing;

@protocol PGraphics <NSObject>

@required

/// Set the background. Four values have been clamped to the range [0, 1]
- (void)background:(float)red :(float)green :(float)blue :(float)alpha;
- (void)noFill;
- (void)fill:(float)red :(float)green :(float)blue :(float)alpha;
- (void)noStroke;
- (void)stroke:(float)red :(float)green :(float)blue :(float)alpha;
- (void)strokeCap:(int)mode;
- (void)strokeJoin:(int)mode;
- (void)strokeWeight:(NSUInteger)pixel;

- (void)point:(float)x
             :(float)y
             :(float)z;
- (void)line:(float)x1 
            :(float)y1 
            :(float)z1 
            :(float)x2 
            :(float)y2 
            :(float)z2;
- (void)arc:(float)ox 
           :(float)oy 
           :(float)width 
           :(float)height 
           :(float)start 
           :(float)stop;
- (void)ellipse:(float)ox 
               :(float)oy 
               :(float)width 
               :(float)height;
- (void)rect:(float)ox 
            :(float)oy 
            :(float)width 
            :(float)height;

- (void)draw;

- (id)initWithController:(Processing *)p width:(NSUInteger)w height:(NSUInteger)h;

@optional

@end

@interface PGraphics2D : UIView <PGraphics> {
    
@private
    CGContextRef ctx;
    Processing *p_;
    BOOL doFill_;
    BOOL doStroke_;
    
    float fillColor_[4];
}

@end
