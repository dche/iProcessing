/*
 
 GREEN TORNADO by Pablo Andres Carrasco Toledo
 
 http://www.openprocessing.org/visuals/?visualID=2767

float sep, nn; 

void setup(){ 
    sep = 5; 
    nn = 30; 
    size(400, 400); 
    smooth(); 
} 

void draw(){ 
    
    background(0); 
    for(float y =sep; y <= width-2*sep; y += nn/2){ 
        for(float x = sep+10; x <= height-sep/2; x += 1.5*nn){ 
            
            float f; 
            f = dist(mouseX, mouseY, x, y); 
            float diam; 
            diam = map(f, f, width, height, 14);  
            
            
            
            
            translate(mouseX*2,mouseY*2); 
            rotate(5); 
            fill(150,220,10,50); 
            rectMode(CENTER); 
            rect(x,f,30,20); 
            fill(40,120,30,60); 
            rectMode(CENTER); 
            rect(f,y,60,40); 
            noStroke(); 
            fill(60,140,50,130); 
            rectMode(CENTER); 
            rect(f,f,15,15); 
            fill(#93FF86,170); 
            rectMode(CENTER); 
            rect(f,mouseY,5,5); 
            ellipse(width/2,height/2,mouseX,5); 
        }   
    } 
} 

*/
//
//  GreenTornado.m
//  iProcessing
//
//  Translated by Kenan Che on 09-07-28.
//  Copyright 2009 campl software. All rights reserved.
//

#import "GreenTornado.h"


@implementation GreenTornado

- (void)setup
{ 
    sep = 5; 
    nn = 30; 
    [self size:320 :320]; 
    [self smooth]; 
} 

- (void)draw
{ 
    
    [self background:[self color:0]]; 
    for(float y =sep; y <= self.width-2*sep; y += nn/2){ 
        for(float x = sep+10; x <= self.height-sep/2; x += 1.5*nn){ 
            
            float f; 
            f = [self dist:self.mouseX :self.mouseY :x :y]; 
            float diam; 
            diam = [self map:f :f :self.width :self.height :14];  
            
            [self translate:self.mouseX*2 :self.mouseY*2]; 
            [self rotate:5]; 
            [self fill:150 :220 :10 :50]; 
            [self rectMode:CENTER]; 
            [self rect:x :f :30 :20]; 
            [self fill:40 :120 :30 :60]; 
            [self rectMode:CENTER]; 
            [self rect:f :y :60 :40]; 
            [self noStroke]; 
            [self fill:60 :140 :50 :130]; 
            //rectMode(CENTER); 
            [self rect:f :f :15 :15]; 
            [self fill:147 :255 :102 :170];
            //rectMode(CENTER); 
            [self rect:f :self.mouseY :5 :5]; 
            [self ellipse:self.width/2 :self.height/2 :self.mouseX :5]; 
        }   
    } 
} 

@end
