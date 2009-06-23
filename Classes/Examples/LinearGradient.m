/**
 * Simple Linear Gradient 
 * by Ira Greenberg. 
 * 
 * Using the convenient red(), green() 
 * and blue() component functions,
 * generate some linear gradients.
 */

//
//  LinearGradient.m
//  iProcessing
//
//  Translated by Diego Che on 09-06-22.
//  Copyright 2009 campl software. All rights reserved.
//

#import "LinearGradient.h"

// constants
static const int Y_AXIS = 1;
static const int X_AXIS = 2;

@interface LinearGradient ()

- (void)setGradient:(int)x :(int)y :(float)w :(float)h :(color)c1 :(color)c2 :(int)axis;

@end


@implementation LinearGradient

- (void)setup
{
    [self size:200 :200];
    [self noLoop];
}

- (void)draw
{
    // create some gradients
    // background
    color b1 = [self color:190 :190 :190];
    color b2 = [self color:20 :20 :20];
    [self setGradient:0 :0 :[self width] :[self height] :b1 :b2 :Y_AXIS];
    //center squares
    color c1 = [self color:255 :120 :0];
    color c2 = [self color:10 :45 :255];
    color c3 = [self color:10 :255 :15];
    color c4 = [self color:125 :2 :140];
    color c5 = [self color:255 :255 :0];
    color c6 = [self color:25 :255 :200];
    [self setGradient:25 :25 :75 :75 :c1 :c2 :Y_AXIS];
    [self setGradient:100 :25 :75 :75 :c3 :c4 :X_AXIS];
    [self setGradient:25 :100 :75 :75 :c2 :c5 :X_AXIS];
    [self setGradient:100 :100 :75 :75 :c4 :c6 :Y_AXIS];    
}

- (void)setGradient:(int)x :(int)y :(float)w :(float)h :(color)c1 :(color)c2 :(int)axis
{
    // calculate differences between color components 
//    float deltaR = [self red:c2]-[self red:c1];
//    float deltaG = [self green:c2]-[self green:c1];
//    float deltaB = [self blue:c2]-[self blue:c1];
    
    // choose axis
    if(axis == Y_AXIS){
        /*nested for loops set pixels
         in a basic table structure */
        // column
        for (int i=x; i<=(x+w); i++){
            // row
            for (int j = y; j<=(y+h); j++){
//                color c = [self color:([self red:c1]+(j-y)*(deltaR/h))
//                                     :([self green:c1]+(j-y)*(deltaG/h))
//                                     :([self blue:c1]+(j-y)*(deltaB/h))];
//                [self set:i :j :c];
            }
        }  
    }  
    else if(axis == X_AXIS){
        // column 
        for (int i=y; i<=(y+h); i++){
            // row
            for (int j = x; j<=(x+w); j++){
//                color c = [self color:([self red:c1]+(j-x)*(deltaR/h))
//                                     :([self green:c1]+(j-x)*(deltaG/h))
//                                     :([self blue:c1]+(j-x)*(deltaB/h))];
//                [self set:j :i :c];
            }
        }  
    }
}

@end
