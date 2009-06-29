/**
 * Milliseconds. 
 * 
 * A millisecond is 1/1000 of a second. 
 * Processing keeps track of the number of milliseconds a program has run.
 * By modifying this number with the modulo(%) operator, 
 * different patterns in time are created.  
 */
/*
float scale;

void setup()
{
    size(200, 200);
    noStroke();
    scale = width/10;
}

void draw()
{ 
    for(int i=0; i<scale; i++) {
        colorMode(RGB, (i+1) * scale * 10);
        fill(millis()%((i+1) * scale * 10) );
        rect(i*scale, 0, scale, height);
    }
}
*/
//
//  Milliseconds.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Milliseconds.h"


@implementation Milliseconds

- (void) setup
{
    [self size:200 :200];
    [self noStroke];
    scale = [self width]/10.0f;    
}

- (void)draw
{
    for(int i=0; i<scale; i++) {
        [self colorMode:RGB :(i+1) * scale * 10];
        [self fill:[self color:fmodf([self millis], (i+1) * scale * 10)]];
        [self rect:i*scale :0 :scale :[self height]];
    }    
}

@end
