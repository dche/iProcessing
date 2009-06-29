/**
 * Words. 
 * 
 * The text() function is used for writing words to the screen. 
 */

/*
int x = 30;
PFont fontA;

void setup() 
{
    size(200, 200);
    background(102);
    
    // Load the font. Fonts must be placed within the data 
    // directory of your sketch. Use Tools > Create Font 
    // to create a distributable bitmap font. 
    // For vector fonts, use the createFont() function. 
    fontA = loadFont("Ziggurat-HTF-Black-32.vlw");
    
    // Set the font and its size (in units of pixels)
    textFont(fontA, 32);
    
    // Only draw once
    noLoop();
}

void draw() {
    // Use fill() to change the value or color of the text
    fill(0);
    text("ichi", x, 60);
    fill(51);
    text("ni", x, 95);
    fill(204);
    text("san", x, 130);
    fill(255);
    text("shi", x, 165);
}
*/
//
//  Words.m
//  iProcessing
//
//  Translated by Diego Che on 09-06-25.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Words.h"

static const int x = 30;

@implementation Words

- (void)setup
{
    [self size:200 :200];
    [self background:[self color:102]];
    
    // Load the font. Fonts must be placed within the data 
    // directory of your sketch. Use Tools > Create Font 
    // to create a distributable bitmap font. 
    // For vector fonts, use the createFont() function. 
    // fontA = loadFont("Ziggurat-HTF-Black-32.vlw");
    UIFont *fontA = [UIFont systemFontOfSize:10];
    
    // Set the font and its size (in units of pixels)
    [self textFont:fontA :32];
    
    // Only draw once
    [self noLoop];    
}

- (void)draw
{
    // Use fill() to change the value or color of the text
    [self fill:[self color:0]];
    [self text:@"ichi" :x :60];
    [self fill:[self color:51]];
    [self text:@"ni" :x :95];
    [self fill:[self color:204]];
    [self text:@"san" :x :130];
    [self fill:[self color:255]];
    [self text:@"shi" :x :165];    
}

@end
