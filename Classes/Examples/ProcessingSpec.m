//
//  ProcessingSpec.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-23.
//  Copyright 2009 campl software. All rights reserved.
//

#import "ProcessingSpec.h"

#define NSPEC   20

@interface ProcessingSpec ()

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
- (void)polygon_close;
- (void)polygon_open;

// Transformation
- (void)rotate;
- (void)scale;
- (void)translate;

// Typography
- (void)textWidth;
- (void)textAlign;
- (void)text_ascent;

@end

@implementation ProcessingSpec

- (void)setup
{
    [self size:120 :100];    
    SEL selectors[] = {
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
        @selector(polygon_open),
        @selector(polygon_close),
        @selector(rotate),
        @selector(translate),
        @selector(scale),
        @selector(textWidth),
        @selector(textAlign),
        @selector(text_ascent),
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
    
    // TODO: 3D spec.
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

@end
