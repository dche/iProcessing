//
//  Arctangent.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Processing.h"

@interface Eye : PObject
{
    int ex, ey;
    int size;
    float angle;    
}

- (id)initWithProcessing:(Processing *)p :(int)x :(int)y :(int)s;
- (void)update:(int)mx :(int)my;
- (void)display;

@end

@interface Arctangent : Processing {
    Eye *e1, *e2, *e3, *e4, *e5;
}

@end


