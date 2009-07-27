//
//  PGraphics2D.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-16.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PGraphicsProtocol.h"
#import "Processing+core.h"

@interface PGraphics2D : UIView <PGraphics> {
    
@private
    /// Quartz
    CGContextRef ctx;
    /// The drawing buffer
    color *pixels_;
    
    Processing *p_;
    BOOL doFill_;
    BOOL doStroke_;
    BOOL doTint_;
    UIFont *curFont_;
    
    PColor fillColor_;
    PColor tintColor_;
    
    NSMutableData *matrixStack_;
}

@end
