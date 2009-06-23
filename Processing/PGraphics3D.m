//
//  PGraphics3D.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-16.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PGraphics3D.h"
#import "Processing.h"

@implementation PGraphics3D


- (id)initWithController:(Processing *)p width:(NSUInteger)w height:(NSUInteger)h
{
    if (self = [super init]) {
        p_ = p;
    }
    return self;
}

- (void)dealloc {    
    [super dealloc];
}

- (void)draw
{
    [p_ draw];
}

#pragma mark -
#pragma mark Drawing
#pragma mark -

- (void)background:(float)red :(float)green :(float)blue :(float)alpha;
{
}

- (void)noFill
{
    
}

- (void)fill:(float)red :(float)green :(float)blue :(float)alpha
{
    
}

- (void)noStroke
{
    
}

- (void)stroke:(float)red :(float)green :(float)blue :(float)alpha
{
    
}

- (void)strokeCap:(int)mode
{
    
}

- (void)strokeJoin:(int)mode
{
    
}

- (void)strokeWeight:(NSUInteger)pixel
{
    
}

- (void)point:(float)x
             :(float)y
             :(float)z
{
    
}

- (void)line:(float)x1 
            :(float)y1 
            :(float)z1 
            :(float)x2 
            :(float)y2 
            :(float)z2
{

}

- (void)arc:(float)ox 
           :(float)oy 
           :(float)width 
           :(float)height
           :(float)start 
           :(float)stop
{
    
}

- (void)ellipse:(float)ox 
               :(float)oy 
               :(float)width 
               :(float)height
{
    
}

- (void)rect:(float)ox 
            :(float)oy 
            :(float)width 
            :(float)height
{
    
}

@end
