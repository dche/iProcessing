/**
 * Creating Colors (Homage to Albers). 
 * 
 * Creating variables for colors that may be referred to 
 * in the program by their name, rather than a number. 
 */

//
//  Creating.m
//  iProcessing
//
//  Translated by Diego Che on 09-06-22.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Creating.h"


@implementation Creating

- (void)setup
{
    [self size:200 :200];
    [self noStroke];
    [self noLoop];
}

- (void)draw
{
    color inside = [self color:204 :102 :0];
    color middle = [self color:204 :153 :0];
    color outside = [self color:153 :51 :0];
    
    // These statements are equivalent to the statements above.
    // Programmers may use the format they prefer.
    //color inside = #CC6600;
    //color middle = #CC9900;
    //color outside = #993300;
    
    [self fill:outside];
    [self rect:0 :0 :200 :200];
    [self fill:middle];
    [self rect:40 :60 :120 :120];
    [self fill:inside];
    [self rect:60 :90 :80 :80];    
}

@end
