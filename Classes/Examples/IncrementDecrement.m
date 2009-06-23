/**
 * Increment Decrement. 
 * 
 * Writing "a++" is equivalent to "a = a + 1".  
 * Writing "a--" is equivalent to "a = a - 1".   
 */

/*
int a;
int b;
boolean direction;

void setup()
{
    size(200, 200);
    colorMode(RGB, width);
    a = 0;
    b = width;
    direction = true;
    frameRate(30);
}

void draw()
{
    a++;
    if(a > width) {
        a = 0;
        direction = !direction;
    }
    if(direction == true){
        stroke(a);
    } else {
        stroke(width-a);
    }
    line(a, 0, a, height/2);
    
    b--;
    if(b < 0) {
        b = width;
    }
    if(direction == true) {
        stroke(width-b);
    } else {
        stroke(b);
    }
    line(b, height/2+1, b, height);
}
*/

//
//  IncrementDecrement.m
//  iProcessing
//
//  Translated by Diego Che on 09-06-23.
//  Copyright 2009 campl software. All rights reserved.
//

#import "IncrementDecrement.h"


@implementation IncrementDecrement

- (void)setup
{
    [self size:200 :200];
    [self colorMode:RGB :[self width]];
    a = 0;
    b = [self width];
    direction = YES;
    [self frameRate:30];
}

- (void)draw
{
    a++;
    if(a > [self width]) {
        a = 0;
        direction = !direction;
    }
    if(direction == YES){
        [self stroke:a];
    } else {
        [self stroke:[self width]-a];
    }
    [self line:a :0 :a :[self height]/2];
    
    b--;
    if(b < 0) {
        b = [self width];
    }
    if(direction == YES) {
        [self stroke:[self width]-b];
    } else {
        [self stroke:b];
    }
    [self line:b :[self height]/2+1 :b :[self height]];
}

@end
