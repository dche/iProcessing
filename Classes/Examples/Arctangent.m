/**
 * Arctangent. 
 * 
 * Move the mouse to change the direction of the eyes. 
 * The atan2() function computes the angle from each eye 
 * to the cursor. 
 */
/*
Eye e1, e2, e3, e4, e5;

void setup() 
{
    size(200, 200);
    smooth();
    noStroke();
    e1 = new Eye( 50,  16,  80);
    e2 = new Eye( 64,  85,  40);  
    e3 = new Eye( 90, 200, 120);
    e4 = new Eye(150,  44,  40); 
    e5 = new Eye(175, 120,  80);
}

void draw() 
{
    background(102);
    
    e1.update(mouseX, mouseY);
    e2.update(mouseX, mouseY);
    e3.update(mouseX, mouseY);
    e4.update(mouseX, mouseY);
    e5.update(mouseX, mouseY);
    
    e1.display();
    e2.display();
    e3.display();
    e4.display();
    e5.display();
}

class Eye 
{
    int ex, ey;
    int size;
    float angle = 0.0;
    
    Eye(int x, int y, int s) {
        ex = x;
        ey = y;
        size = s;
    }
    
    void update(int mx, int my) {
        angle = atan2(my-ey, mx-ex);
    }
    
    void display() {
        pushMatrix();
        translate(ex, ey);
        fill(255);
        ellipse(0, 0, size, size);
        rotate(angle);
        fill(153);
        ellipse(size/4, 0, size/2, size/2);
        popMatrix();
    }
}
*/
//
//  Arctangent.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import "Arctangent.h"


@implementation Arctangent

- (void)setup
{
    [self size:200 :200];
    [self smooth];
    [self noStroke];
    
    e1 = [[Eye alloc] init:50 :16 :80];
    e2 = [[Eye alloc] init:64 :85 :40];  
    e3 = [[Eye alloc] init:90 :200 :120];
    e4 = [[Eye alloc] init:150 :44 :40]; 
    e5 = [[Eye alloc] init:175 :120 :80];
    
    e1.p = self;
    e2.p = self;
    e3.p = self;
    e4.p = self;
    e5.p = self;
}

- (void)draw
{
    [self background:[self color:102]];
    
    [e1 update:[self mouseX] :[self mouseY]];
    [e2 update:[self mouseX] :[self mouseY]];
    [e3 update:[self mouseX] :[self mouseY]];
    [e4 update:[self mouseX] :[self mouseY]];
    [e5 update:[self mouseX] :[self mouseY]];
    
    [e1 display];
    [e2 display];
    [e3 display];
    [e4 display];
    [e5 display];
}

- (void)dealloc
{
    [e1 release];
    [e2 release];
    [e3 release];
    [e4 release];
    [e5 release];
    [super dealloc];
}

@end

@implementation Eye

- (id)init:(int)x :(int)y :(int)s
{
    if (self = [super init]) {
        ex = x;
        ey = y;
        size = s;        
    }
    return self;
}

- (void)update:(int)mx :(int)my
{
    angle = [self.p atan2:my-ey :mx-ex];    
}

- (void)display
{
    if (self.p == nil) return;
    
    [self.p pushMatrix];
    [self.p translate:ex :ey];
    [self.p fill:[self.p color:255]];
    [self.p ellipse:0 :0 :size :size];
    [self.p rotate:angle];
    [self.p fill:[self.p color:153]];
    [self.p ellipse:size/4.0f :0 :size/2.0f :size/2.0f];
    [self.p popMatrix];    
}

@end

