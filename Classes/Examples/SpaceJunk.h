//
//  SpaceJunk.h
//  iProcessing
//
//  Created by Kenan Che on 09-07-16.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Processing.h"

@interface Cube : PObject
{
    int w;
    int h;
    int d;
    int shiftX;
    int shiftY;
    int shiftZ;    
}

+ (Cube *)cube:(Processing *)p :(int)w :(int)h :(int)d :(int)shiftX :(int)shiftY :(int)shiftZ;
- (void)drawCube;

@end


@interface SpaceJunk : Processing {
    float ang;
    // Array for all cubes
    NSMutableArray *cubes;

}

@end
