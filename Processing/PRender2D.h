//
//  PRender2D.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-16.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PRenderProtocol.h"
#import "PGraphics.h"

@interface PRender2D : UIView <PRender> {
    
@private
    /// Quartz
    CGContextRef ctx;
    /// The drawing buffer
    color *data_;
    /// The pixels array.
    color *pixels_;
    
    PGraphics *p_;
    BOOL doFill_;
    BOOL doStroke_;
    BOOL doTint_;
    UIFont *curFont_;
    
    PColor fillColor_;
    PColor tintColor_;
    
    NSMutableData *matrixStack_;
}

@end
