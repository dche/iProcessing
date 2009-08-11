//
//  PGraphics.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-30.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Processing+core.h"

@interface PGraphics : Processing {

}

+ (id)grphics:(float)width :(float)height;
- (void)beginDraw;
- (void)endDraw;

@end
