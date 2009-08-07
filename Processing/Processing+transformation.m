//
//  Processing+transformation.m
//  Processing Touch
//
//  Created by Kenan Che on 09-06-06.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Processing+transformation.h"


@implementation Processing (Transformation)
- (void)applyMatrix:(float)n00 :(float)n01 :(float)n02 :(float)n03
                   :(float)n04 :(float)n05 :(float)n06 :(float)n07
                   :(float)n08 :(float)n09 :(float)n10 :(float)n11
                   :(float)n12 :(float)n13 :(float)n14 :(float)n15
{
    if (shapeBegan_) return;
    [graphics_ multMatrix:n00 :n01 :n02 :n03 
                         :n04 :n05 :n06 :n07 
                         :n08 :n09 :n10 :n11 
                         :n12 :n13 :n14 :n15];
}

- (void)popMatrix
{
    if (shapeBegan_) return;
    [graphics_ popMatrix];
}

- (void)pushMatrix
{
    if (shapeBegan_) return;
    [graphics_ pushMatrix];
}

- (void)resetMatrix
{
    if (shapeBegan_) return;
    [graphics_ loadIdentity];
}

- (void)rotate:(float)angle
{
    if (shapeBegan_) return;
    
    if (self.mode == P2D) {
        [self rotateZ:angle];
    } else {
        // FIXME: which anix should rotate around?
        [graphics_ rotate:angle :1 :1 :1];        
    }
}

- (void)rotateX:(float)angle
{
    [graphics_ rotate:angle :1 :0 :0];
}

- (void)rotateY:(float)angle
{
    [graphics_ rotate:angle :0 :1 :0];
}

- (void)rotateZ:(float)angle
{
    [graphics_ rotate:angle :0 :0 :1];
}

- (void)scale:(float)size
{
    [self scale:size :size :size];
}

- (void)scale:(float)x :(float)y
{
    [self scale:x :y :0];
}

- (void)scale:(float)x :(float)y :(float)z
{
    if (shapeBegan_) return;
    [graphics_ scale:x :y :z];
}

- (void)translate:(float)x :(float)y
{
    [self translate:x :y :0];
}

- (void)translate:(float)x :(float)y :(float)z
{
    if (shapeBegan_) return;
    [graphics_ translate:x :y :z];
}

- (void)printMatrix
{
    Matrix3D m = [graphics_ matrix];
    printMatrix3D(&m);
}

@end
