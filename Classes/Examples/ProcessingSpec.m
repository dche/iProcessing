//
//  ProcessingSpec.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-23.
//  Copyright 2009 campl software. All rights reserved.
//

#import "ProcessingSpec.h"

#define NSPEC   34

@interface ProcessingSpec ()

// Structure
- (void)pushPopStyle;

// Shape
- (void)arc;
- (void)ellipse;
- (void)line;
- (void)strokeCap;
- (void)shape_lines;
- (void)shape_points;
- (void)shape_triangles;
- (void)shape_triangle_strip;
- (void)shape_triangle_fan;
- (void)shape_quads;
- (void)shape_quad_strip;
- (void)bezierVertex;
- (void)bezierPoint;
- (void)bezierTangent;
- (void)curveVertex;
- (void)curvePoint;
- (void)curveTangent;
- (void)polygon_close;
- (void)polygon_open;

// Transformation
- (void)rotate;
- (void)scale;
- (void)translate;
- (void)rotateX;
- (void)rotateY;

// Typography
- (void)textWidth;
- (void)textAlign;
- (void)text_ascent;

// Image
- (void)resize;
- (void)copy;
- (void)gray;
- (void)invert;
- (void)threshold;
- (void)posterize;

@end

@implementation ProcessingSpec

- (void)setup
{
    [self size:200 :200];    
    SEL selectors[] = {
        @selector(pushPopStyle),
        @selector(arc),
        @selector(ellipse),
        @selector(line),
        @selector(strokeCap),
        @selector(shape_lines),
        @selector(shape_points),
        @selector(shape_triangles),
        @selector(shape_triangle_strip),
        @selector(shape_triangle_fan),
        @selector(shape_quads),
        @selector(shape_quad_strip),
        @selector(bezierVertex),
        @selector(bezierPoint),
        @selector(bezierTangent),
        @selector(curveVertex),
        @selector(curvePoint),
        @selector(curveTangent),
        @selector(polygon_open),
        @selector(polygon_close),
        @selector(rotate),
        @selector(translate),
        @selector(scale),
        @selector(rotateX),
        @selector(rotateY),
        @selector(textWidth),
        @selector(textAlign),
        @selector(text_ascent),
        @selector(resize),
        @selector(copy),
        @selector(gray),
        @selector(invert),
        @selector(threshold),
        @selector(posterize),
    };
    specs = (SEL *)malloc(NSPEC * sizeof(SEL));
    memcpy(specs, selectors, sizeof(selectors));
    [self noLoop];
}

- (void)draw
{
    int index = [self frameCount] % NSPEC;    
    [self background:[self color:151]];
    [self pushStyle];
    [self performSelector:specs[index]];
    [self popStyle];
}

- (void)dealloc
{
    free(specs);
    [super dealloc];
}

- (void)mouseClicked
{
    [self redraw];
}

#pragma mark -
#pragma mark Structure
#pragma mark -

- (void)pushPopStyle
{
    [self smooth];
    [self ellipse:0 :50 :33 :33];    // Left
    [self pushStyle];               // Start a new style
    [self strokeWeight:10];
    [self fill:204 :153 :0];
    [self ellipse:33 :50 :33 :33];   // Left-Middle
    [self pushStyle];               // Start another new style
    [self stroke:0 :102 :153];
    [self ellipse:66 :50 :33 :33];   // Right-Middle
    [self popStyle];                // Restore the previous style
    [self popStyle];                // Restore original style
    [self ellipse:100 :50 :33 :33];  // Right    
}

#pragma mark -
#pragma mark Shape
#pragma mark -

- (void)arc
{
    [self arc:50 :55 :50 :50 :0 :PI/2];
    [self noFill];
    [self arc:50 :55 :60 :60 :PI/2 :PI];
    [self arc:50 :55 :70 :70 :PI :TWO_PI-PI/2];
    [self arc:50 :55 :80 :80 :TWO_PI-PI/2 :TWO_PI];
}

- (void)ellipse
{
    [self ellipse:56 :46 :55 :55];
}

- (void)line
{
    [self line:30 :20 :85 :75];
    
    [self line:30 :20 :85 :20];
    [self stroke:[self color:126]];
    [self line:85 :20 :85 :75];
    [self stroke:[self color:255]];
    [self line:85 :75 :30 :75];
}

- (void)strokeCap
{
    [self smooth];
    [self strokeWeight:12.0];
    [self strokeCap:ROUND];
    [self line:20 :30 :80 :30];
    [self strokeCap:SQUARE];
    [self line:20 :50 :80 :50];
    [self strokeCap:PROJECT];
    [self line:20 :70 :80 :70];
    [self noSmooth];
}

- (void)shape_lines
{
    [self beginShape:LINES];
    [self vertex:30 :20];
    [self vertex:85 :20];
    [self vertex:85 :75];
    [self vertex:30 :75];
    [self endShape:CLOSE];
}

- (void)shape_points
{
    [self beginShape:POINTS];
    [self vertex:30 :20];
    [self vertex:85 :20];
    [self vertex:85 :75];
    [self vertex:30 :75];
    [self endShape];
}

- (void)shape_triangles
{
    [self beginShape:TRIANGLES];
    [self vertex:30 :75];
    [self vertex:40 :20];
    [self vertex:50 :75];
    [self vertex:60 :20];
    [self vertex:70 :75];
    [self vertex:80 :20];
    [self endShape];    
}

- (void)shape_triangle_strip
{
    [self beginShape:TRIANGLE_STRIP];
    [self vertex:30 :75];
    [self vertex:40 :20];
    [self vertex:50 :75];
    [self vertex:60 :20];
    [self vertex:70 :75];
    [self vertex:80 :20];
    [self vertex:90 :75];
    [self endShape];    
}

- (void)shape_triangle_fan
{
    [self beginShape:TRIANGLE_FAN];
    [self vertex:57.5 :50];
    [self vertex:57.5 :15]; 
    [self vertex:92 :50]; 
    [self vertex:57.5 :85]; 
    [self vertex:22 :50]; 
    [self vertex:57.5 :15]; 
    [self endShape];    
}

- (void)shape_quads
{
    [self beginShape:QUADS];
    [self vertex:30 :20];
    [self vertex:30 :75];
    [self vertex:50 :75];
    [self vertex:50 :20];
    [self vertex:65 :20];
    [self vertex:65 :75];
    [self vertex:85 :75];
    [self vertex:85 :20];
    [self endShape];
}

- (void)shape_quad_strip
{
    [self beginShape:QUAD_STRIP]; 
    [self vertex:30 :20]; 
    [self vertex:30 :75]; 
    [self vertex:50 :20];
    [self vertex:50 :75];
    [self vertex:65 :20]; 
    [self vertex:65 :75]; 
    [self vertex:85 :20];
    [self vertex:85 :75]; 
    [self endShape];    
}

- (void)bezierVertex
{
    [self beginShape];
    [self vertex:30 :20];
    [self bezierVertex:80 :0 :80 :75 :30 :75];
    [self bezierVertex:50 :80 :60 :25 :30 :20];
    [self endShape:CLOSE];
}

- (void)bezierPoint
{
    [self noFill];
    [self bezier:85 :20 :10 :10 :90 :90 :15 :80];
    [self fill:PWhiteColor];
    int steps = 10;
    for (int i = 0; i <= steps; i++) {
        float t = i / (float)steps;
        float x = [self bezierPoint:85 :10 :90 :15 :t];
        float y = [self bezierPoint:20 :10 :90 :80 :t];
        [self ellipse:x :y :5 :5];
    }
}

- (void)bezierTangent
{
    [self noFill];
    [self bezier:85 :20 :10 :10 :90 :90 :15 :80];
    [self stroke:255 :102 :0];
    int steps = 16;
    for (int i = 0; i <= steps; i++) {
        float t = i / (float)steps;
        float x = [self bezierPoint:85 :10 :90 :15 :t];
        float y = [self bezierPoint:20 :10 :90 :80 :t];
        float tx = [self bezierTangent:85 :10 :90 :15 :t];
        float ty = [self bezierTangent:20 :10 :90 :80 :t];
        float a = [self atan2:ty :tx];
        a -= HALF_PI;
        [self line:x :y :[self cos:a]*8 + x :[self sin:a]*8 + y];
    }
}

- (void)curveVertex
{
    [self noFill];
    [self beginShape];
    [self curveVertex:84 :91];
    [self curveVertex:84 :91];
    [self curveVertex:68 :19];
    [self curveVertex:21 :17];
    [self curveVertex:32 :100];
    [self curveVertex:32 :100];
    [self endShape];
}

- (void)curvePoint
{
    [self curve:5 :26 :5 :26 :73 :24 :73 :61];
    [self curve:5 :26 :73 :24 :73 :61 :15 :65]; 
    [self ellipseMode:CENTER];
    int steps = 6;
    for (int i = 0; i <= steps; i++) {
        float t = i / (float)steps;
        float x = [self curvePoint:5 :5 :73 :73 :t];
        float y = [self curvePoint:26 :26 :24 :61 :t];
        [self ellipse:x :y :5 :5];
        x = [self curvePoint:5 :73 :73 :15 :t];
        y = [self curvePoint:26 :24 :61 :65 :t];
        [self ellipse:x :y :5 :5];
    }
}

- (void)curveTangent
{
    [self noFill];
    [self curve:5 :26 :73 :24 :73 :61 :15 :65]; 
    int steps = 6;
    for (int i = 0; i <= steps; i++) {
        float t = i / (float)steps;
        float x = [self curvePoint:5 :73 :73 :15 :t];
        float y = [self curvePoint:26 :24 :61 :65 :t];
        //ellipse(x, y, 5, 5);
        float tx = [self curveTangent:5 :73 :73 :15 :t];
        float ty = [self curveTangent:26 :24 :61 :65 :t];
        float a = [self atan2:ty :tx];
        a -= PI/2.0;
        [self line:x :y :[self cos:a]*8 + x :[self sin:a]*8 + y];
    }
}

- (void)polygon_close
{
    [self beginShape];
    [self vertex:20 :20];
    [self vertex:40 :20];
    [self vertex:40 :40];
    [self vertex:60 :40];
    [self vertex:60 :60];
    [self vertex:20 :60];
    [self endShape:CLOSE];    
}

- (void)polygon_open
{
    [self beginShape];
    [self vertex:20 :20];
    [self vertex:40 :20];
    [self vertex:40 :40];
    [self vertex:60 :40];
    [self vertex:60 :60];
    [self vertex:20 :60];
    [self endShape];    
}

#pragma mark -
#pragma mark Transformation
#pragma mark -

- (void)rotate
{
    [self translate:[self width]/2 :[self height]/2];
    [self rotate:PI/3.0];
    [self rect:-26 :-26 :52 :52];
}

- (void)scale
{
    [self rect:30 :20 :50 :50];
    [self scale:0.5 :1.3];
    [self rect:30 :20 :50 :50];
}

- (void)translate
{
    [self translate:30 :20];
    [self rect:0 :0 :55 :55];
    [self translate:14 :14];
    [self rect:0 :0 :55 :55];
}

- (void)rotateX
{
    [self translate:self.width/2 :self.height/2];
    [self rotateX:PI/3.0];
    [self rect:-26 :-26 :52 :52];
}

- (void)rotateY
{
    [self translate:self.width/2 :self.height/2];
    [self rotateY:[self radians:60]];
    [self rect:-26 :-26 :52 :52];
}

#pragma mark -
#pragma mark Typography
#pragma mark -

- (void)textWidth
{
    UIFont *font = [UIFont systemFontOfSize:32];
    [self textFont:font];
    
    char c = 'T';
    NSString *str = [NSString stringWithFormat:@"%c", c];
    float cw = [self textWidth:str];
    [self text:str :0 :40];
    [self line:cw :0 :cw :50]; 
    
    NSString *s = @"Tokyo";
    float sw = [self textWidth:s];
    [self text:s :0 :85];
    [self line:sw :50 :sw :100];
}

- (void)textAlign
{
    // PFont font;
    // The font must be located in the current sketch's 
    // "data" directory to load successfully 
    //font = loadFont("EurekaMonoCond-Bold-20.vlw"); 
    [self textFont:[UIFont systemFontOfSize:20]];
    [self textAlign:RIGHT];
    [self text:@"word" :50 :30]; 
    [self textAlign:CENTER];
    [self text:@"word" :50 :50]; 
    [self textAlign:LEFT];
    [self text:@"word" :50 :70];
}

- (void)text_ascent
{
    UIFont *font;
    //font = loadFont("FFScala-32.vlw"); 
    font = [UIFont systemFontOfSize:32];
    [self textFont:font];
    
    //textSize(32); 
    float ascent = [self textAscent];
    [self text:@"dp" :0 :70];
    [self line:0 :70-ascent :100 :70-ascent]; 
    
    [self textSize:64];
    ascent = [self textAscent];
    [self text:@"dp" :35 :70];
    [self line:35 :70-ascent :100 :70-ascent];
}

#pragma mark -
#pragma mark Image
#pragma mark -

- (void)resize
{
    PImage *img = [self loadImage:@"jelly.jpg"];
    [self image:img :0 :0];
    [img resize:100 :50];
    [self image:img :0 :0];
}

- (void)copy
{
    PImage *img = [self loadImage:@"jelly.jpg"];
    [img copy:100 :100 :100 :100 :0 :0 :50 :50]; 
    [self image:img :0 :0];
}

- (void)gray
{
    PImage *b = [self loadImage:@"red.png"];
    [self image:b :0 :0];
    [self filter:GRAY];
}

- (void)invert
{
    PImage *b = [self loadImage:@"jelly.jpg"];
    [self image:b :0 :0];
    [self filter:INVERT];    
}

- (void)threshold
{
    PImage *b = [self loadImage:@"jelly.jpg"];
    [self image:b :0 :0];
    [self filter:THRESHOLD];    // 0.5f
}

- (void)posterize
{
    PImage *b = [self loadImage:@"jelly.jpg"];
    [self image:b :0 :0];
    [self filter:POSTERIZE :6];
}

@end
