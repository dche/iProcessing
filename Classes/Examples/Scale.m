//
//  Scale.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-18.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Scale.h"


@implementation Scale

- (void)setup
{
    a = 0.0;
    s = 0.0;
     
    [self size:200 :200];
    [self noStroke];
    [self rectMode:CENTER];
    [self frameRate:30];
}

- (void)draw
{
    [self background:102 :255];
    
    a = a + 0.04;
    s = [self cos:a]*2;
    
    [self translate:[self width]/2 :[self height]/2];
    [self scale:s]; 
    [self fill:51];
    [self rect:0 :0 :50 :50]; 
    
    [self translate:75 :0];
    [self fill:255 :255];
    [self scale:s];
    [self rect:0 :0 :50 :50];    
}

@end
