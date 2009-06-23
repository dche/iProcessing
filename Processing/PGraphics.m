//
//  PGraphics.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-16.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PGraphics.h"
#import "Processing.h"

static CGPathDrawingMode drawingMode(BOOL doFill, BOOL doStroke)
{
    if (doFill && doStroke) {
        return kCGPathFillStroke;
    } else if (doFill) {
        return kCGPathFill;
    } else {
        return kCGPathStroke;
    }       
}

@interface PGraphics2D ()

- (CGContextRef)createBitmapCGContextWithWidth:(NSUInteger)w height:(NSUInteger)h;

@end


@implementation PGraphics2D


- (id)initWithController:(Processing *)p width:(NSUInteger)w height:(NSUInteger)h
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];    // No background color.
        p_ = p;
        ctx = [self createBitmapCGContextWithWidth:w height:h];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    if (!p_) return;
    [p_ draw];
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    // Draw the image
    CGImageRef img = CGBitmapContextCreateImage(ctx);
    CGContextDrawImage(c, rect, img);
    CGImageRelease(img);
}


- (void)dealloc {
    CGContextRelease(ctx);
    [super dealloc];
}

- (void)draw
{
    [self setNeedsDisplay];
}

// Code copied directly from Quartz2D programming guide.
- (CGContextRef)createBitmapCGContextWithWidth:(NSUInteger)w height:(NSUInteger)h;
{
    CGContextRef    context = NULL;    
    CGColorSpaceRef colorSpace;    
    void *          bitmapData;    
    int             bitmapByteCount;    
    int             bitmapBytesPerRow;    
    
    bitmapBytesPerRow   = (w * 4);    
    bitmapByteCount     = (bitmapBytesPerRow * h);
    
    colorSpace = CGColorSpaceCreateDeviceRGB();    
    bitmapData = malloc(bitmapByteCount);
    
    if (bitmapData == NULL)        
    {
        return NULL;
    }
    
    context = CGBitmapContextCreate (bitmapData,
                                     w,
                                     h,
                                     8,
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedFirst);
    
    if (context== NULL)
    {
        free (bitmapData);
        return NULL;
    }
    
    CGColorSpaceRelease( colorSpace );
    return context;
}

#pragma mark -
#pragma mark Drawing
#pragma mark -

- (void)background:(float)red :(float)green :(float)blue :(float)alpha;
{
    CGContextClearRect(ctx, self.bounds);
    CGContextSetRGBFillColor(ctx, red, green, blue, alpha);
    CGContextFillRect(ctx, self.bounds);
    CGContextSetRGBFillColor(ctx, fillColor_[R], fillColor_[G], fillColor_[B], fillColor_[A]);
}

- (void)fill:(float)red :(float)green :(float)blue :(float)alpha
{
    fillColor_[R] = red;
    fillColor_[G] = green;
    fillColor_[B] = blue;
    fillColor_[A] = alpha;

    CGContextSetRGBFillColor(ctx, red, green, blue, alpha);
    doFill_ = YES;
}

- (void)noFill
{
    doFill_ = NO;
}

- (void)stroke:(float)red :(float)green :(float)blue :(float)alpha
{
    CGContextSetRGBStrokeColor(ctx, red, green, blue, alpha);
    doStroke_ = YES;
}

- (void)noStroke
{
    doStroke_ = NO;
}

- (void)strokeCap:(int)mode
{
    CGLineCap lc = kCGLineCapRound;
    switch (mode) {
        case SQUARE:
            lc = kCGLineCapSquare;
            break;
        case PROJECT:
            lc = kCGLineCapButt;
            break;
        case ROUND:
            break;
        default:
            return;
    }
    CGContextSetLineCap(ctx, lc);
}

- (void)strokeJoin:(int)mode
{
    CGLineJoin lj = kCGLineJoinMiter;
    switch (mode) {
        case ROUND:
            lj = kCGLineJoinRound;
            break;
        case BEVEL:
            lj = kCGLineJoinBevel;
        case MITER:
            break;
        default:
            return;
    }
    CGContextSetLineJoin(ctx, lj);
}

- (void)strokeWeight:(NSUInteger)pixel
{
    CGContextSetLineWidth(ctx, pixel);
}

- (void)point:(float)x
             :(float)y
             :(float)z
{
    [self line:x :y :0 :x+1 :y+1 :0];
}

- (void)line:(float)x1 
            :(float)y1 
            :(float)z1 
            :(float)x2 
            :(float)y2 
            :(float)z2
{
    if (!doStroke_) return;
    
    CGContextMoveToPoint(ctx, x1, y1);
    CGContextAddLineToPoint(ctx, x2, y2);
    CGContextStrokePath(ctx);
}

- (void)arc:(float)ox 
           :(float)oy 
           :(float)width 
           :(float)height
           :(float)start 
           :(float)stop
{
    float x = ox + width / 2.0f;
    float y = oy + height / 2.0f;
    
    
    CGContextMoveToPoint(ctx, x, y);
    CGContextAddArc(ctx, x, y, width / 2.0f, start, stop, 0);
    if (height != width) {
        
    }
    CGContextDrawPath(ctx, drawingMode(doFill_, doStroke_));
}

- (void)ellipse:(float)ox 
               :(float)oy 
               :(float)width 
               :(float)height
{
    CGContextAddEllipseInRect(ctx, CGRectMake(ox, oy, width, height));
    CGContextDrawPath(ctx, drawingMode(doFill_, doStroke_));
}

- (void)rect:(float)ox 
            :(float)oy 
            :(float)width 
            :(float)height
{
    CGContextAddRect(ctx, CGRectMake(ox, oy, width, height));
    CGContextDrawPath(ctx, drawingMode(doFill_, doStroke_));
}

@end
