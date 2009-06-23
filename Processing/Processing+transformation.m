//
//  Processing+transformation.m
//  BubbleTalk
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
    
}

- (void)popMatrix
{
    
}

- (void)pushMatrix
{
    
}

- (void)resetMatrix
{
    
}

- (void)rotate:(float)angle
{
    [graphics_ rotate:angle];
}

- (void)rotateX:(float)angle
{
    [self pushMatrix];
//    [self applyMatrix:<#(float)n00#> :<#(float)n01#> :<#(float)n02#> :<#(float)n03#> 
//                     :<#(float)n04#> :<#(float)n05#> :<#(float)n06#> :<#(float)n07#> 
//                     :<#(float)n08#> :<#(float)n09#> :<#(float)n10#> :<#(float)n11#> 
//                     :<#(float)n12#> :<#(float)n13#> :<#(float)n14#> :<#(float)n15#>];
    [self rotate:angle];
    [self popMatrix];
}

- (void)rotateY:(float)angle
{
    
}

- (void)rotateZ:(float)angle
{
    
}

- (void)scale:(float)size
{
    
}

- (void)scale:(float)x :(float)y
{
    
}

- (void)scale:(float)x :(float)y :(float)z
{
    
}

- (void)translate:(float)x :(float)y
{
    
}

- (void)translate:(float)x :(float)y :(float)z
{
    
}

@end
