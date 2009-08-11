//
//  PGraphics2D.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-16.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PGraphics2D.h"
#import "Processing.h"

typedef struct {
    float a, b, c, d, tx, ty;
} Matrix2D;

static inline Matrix2D Matrix2DMake(CGAffineTransform ctm)
{
    Matrix2D m;
    m.a = ctm.a; m.b = ctm.b; m.c = ctm.c; m.d = ctm.d; 
    m.tx = ctm.tx; m.ty = ctm.ty;
    
    return m;
}

static const NSUInteger kDefaultMatrixStackDepth = 4;

static inline CGPathDrawingMode drawingMode(BOOL doFill, BOOL doStroke)
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

- (void)drawPointsWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n;
- (void)drawLinesWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n;
- (void)drawTrianglesWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n;
- (void)drawTriangleSripWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n;
- (void)drawTriangleFanWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n;
- (void)drawQuadsWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n;
- (void)drawQuadStripWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n;
- (void)drawPathWithVertices:(const PVertex *)v indices:(const Byte *)i vertexNumber:(NSUInteger)n;

- (void)drawTriangleWithP1:(const PVertex *)v1 p2:(const PVertex *)v2 p3:(const PVertex *)v3;
- (void)drawQuadWithP1:(const PVertex *)v1 p2:(const PVertex *)v2 
                    p3:(const PVertex *)v3 p4:(const PVertex *)v4;
@end


@implementation PGraphics2D

- (id)initWithFrame:(CGRect)frame controller:(PGraphics *)p
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];    // No background color.
        p_ = p;
        ctx = [self createBitmapCGContextWithWidth:frame.size.width height:frame.size.height];
        
        matrixStack_ = [[NSMutableData alloc] initWithCapacity:kDefaultMatrixStackDepth];
    }
    return self;
    
}

- (void)drawRect:(CGRect)rect {
    if (!p_ || ![p_ respondsToSelector:@selector(guardedDraw)]) return;
    [(Processing *)p_ guardedDraw];
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    // Draw the image
    CGImageRef img = CGBitmapContextCreateImage(ctx);
    CGContextDrawImage(c, rect, img);
    CGImageRelease(img);
}


- (void)dealloc {
    CGContextRelease(ctx);
    [curFont_ release];
    [matrixStack_ release];
    
    if (data_ != NULL) free(data_);
    if (pixels_ != NULL) free(pixels_);
    
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

    data_ = malloc(h * w * sizeof(color));
    if (NULL == data_) return NULL;
    
    colorSpace = CGColorSpaceCreateDeviceRGB();    
    context = CGBitmapContextCreate (data_,
                                     w,
                                     h,
                                     8,
                                     w * sizeof(color),
                                     colorSpace,
                                     kCGImageAlphaPremultipliedLast);
    
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        free(data_);
        data_ = NULL;
    }
    return context;
}

- (void)smooth
{
    CGContextSetAllowsAntialiasing(ctx, YES);
}

- (void)noSmooth
{
    CGContextSetAllowsAntialiasing(ctx, NO);    
}

#pragma mark -
#pragma mark Drawing
#pragma mark -

- (void)background:(float)red :(float)green :(float)blue :(float)alpha;
{
    CGContextClearRect(ctx, self.bounds);
    CGContextSetRGBFillColor(ctx, red, green, blue, alpha);
    CGContextFillRect(ctx, self.bounds);
    CGContextSetRGBFillColor(ctx, fillColor_.red, fillColor_.green, fillColor_.blue, fillColor_.alpha);
}

- (void)fill:(float)red :(float)green :(float)blue :(float)alpha
{
    PColorSet(&fillColor_, red, green, blue, alpha);

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
            lc = kCGLineCapButt;
            break;
        case PROJECT:
            lc = kCGLineCapSquare;
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

- (void)strokeWeight:(float)w
{
    CGContextSetLineWidth(ctx, w);
}

- (void)draw2DShapeWithVertices:(const PVertex *)v
                   vertexNumber:(NSUInteger)n 
                        indices:(const Byte *)i 
                           mode:(int)m 
                          close:(BOOL)toClose
{
    if (n == 0) return;
    
    PVertex firstPoint = v[0];
    switch (m) {
        case POINTS:
            [self drawPointsWithVertices:v vertexNumber:n];
            break;
        case LINES:
            [self drawLinesWithVertices:v vertexNumber:n];
            break;
        case TRIANGLES:
            [self drawTrianglesWithVertices:v vertexNumber:n];
            break;
        case TRIANGLE_STRIP:
            [self drawTriangleSripWithVertices:v vertexNumber:n];
            break;
        case TRIANGLE_FAN:
            [self drawTriangleFanWithVertices:v vertexNumber:n];
            break;
        case QUADS:
            [self drawQuadsWithVertices:v vertexNumber:n];
            break;
        case QUAD_STRIP:
            [self drawQuadStripWithVertices:v vertexNumber:n];
            break;
        case PATH:
            [self drawPathWithVertices:v indices:i vertexNumber:n];
            if (toClose) {
                CGContextAddLineToPoint(ctx, firstPoint.x, firstPoint.y);
            }
            break;
        default:
            return;
    }
    
    CGContextDrawPath(ctx, drawingMode(doFill_, doStroke_));
}

- (void)drawPointsWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n
{
    const PVertex *p;
    for (int i = 0; i < n; i++) {
        p = v + i;
        CGContextMoveToPoint(ctx, p->x, p->y);
        // No point drawing in Quartz 2D. Draw a small rectangle instead.
        CGContextAddRect(ctx, CGRectMake(p->x, p->y, 1, 1));        
    }
}

- (void)drawLinesWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n
{
    const PVertex *ps, *pe;
    for (int i = 0; i < n / 2; i ++) {
        ps = v + i * 2; pe = ps + 1;
        
        CGContextMoveToPoint(ctx, ps->x, ps->y);
        CGContextAddLineToPoint(ctx, pe->x, pe->y);
    }
}

- (void)drawTriangleWithP1:(const PVertex *)v1 p2:(const PVertex *)v2 p3:(const PVertex *)v3
{
    CGContextMoveToPoint(ctx, v1->x, v1->y);
    CGContextAddLineToPoint(ctx, v2->x, v2->y);
    CGContextAddLineToPoint(ctx, v3->x, v3->y);
    CGContextAddLineToPoint(ctx, v1->x, v1->y);            
}

- (void)drawTrianglesWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n
{
    const PVertex *p1, *p2, *p3;
    for (int i = 0; i < n / 3; i++) {
        p1 = v + i * 3; p2 = p1 + 1; p3 = p2 + 1;
        
        [self drawTriangleWithP1:p1 p2:p2 p3:p3];
    }
}

- (void)drawTriangleSripWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n
{
    const PVertex *p1, *p2, *p3;    
    for (int i = 0; i < n - 2; i++) {
        p1 = v + i; p2 = p1 + 1; p3 = p2 + 1;

        [self drawTriangleWithP1:p1 p2:p2 p3:p3];
    }
}

- (void)drawTriangleFanWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n
{
    const PVertex *p1, *p2, *p3;
    p1 = v;
    for (int i = 1; i < n - 1; i++) {
        p2 = v + i; p3 = p2 + 1;
        
        [self drawTriangleWithP1:p1 p2:p2 p3:p3];
    }
}

- (void)drawQuadWithP1:(const PVertex *)v1 p2:(const PVertex *)v2 
                    p3:(const PVertex *)v3 p4:(const PVertex *)v4
{
    CGContextMoveToPoint(ctx, v1->x, v1->y);
    CGContextAddLineToPoint(ctx, v2->x, v2->y);
    CGContextAddLineToPoint(ctx, v3->x, v3->y);
    CGContextAddLineToPoint(ctx, v4->x, v4->y);        
    CGContextAddLineToPoint(ctx, v1->x, v1->y);            
}

- (void)drawQuadsWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n
{
    const PVertex *p1, *p2, *p3, *p4;
    for (int i = 0; i < n / 4; i++) {
        p1 = v + i * 4; p2 = p1 + 1; p3 = p2 + 1; p4 = p3 + 1;
        
        [self drawQuadWithP1:p1 p2:p2 p3:p3 p4:p4];     
    }    
}

- (void)drawQuadStripWithVertices:(const PVertex *)v vertexNumber:(NSUInteger)n
{
    if (n < 4) return;
    
    // 0---2---4
    // |   |   |
    // 1---3---5    
    const PVertex *p1, *p2, *p3, *p4;
    for (int i = 0; i < n - 3; i += 2) {
        p1 = v + i; p2 = p1 + 1; p3 = p1 + 3; p4 = p1 + 2;
        
        [self drawQuadWithP1:p1 p2:p2 p3:p3 p4:p4];     
    }
}

- (void)drawPathWithVertices:(const PVertex *)v indices:(const Byte *)i vertexNumber:(NSUInteger)n
{
    if (n == 0) return;
    
    const PVertex *p = v;
    CGContextMoveToPoint(ctx, v->x, v->y);
    
    int j = 0;
    while (j++ < n) {
        p = p + 1;
        CGContextAddLineToPoint(ctx, p->x, p->y);
    }
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
        // TODO: draw arc of an ellipse.
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

#pragma mark -
#pragma mark Transformation
#pragma mark -

- (void)multMatrix:(float)n00 :(float)n01 :(float)n02 :(float)n03
                  :(float)n04 :(float)n05 :(float)n06 :(float)n07
                  :(float)n08 :(float)n09 :(float)n10 :(float)n11
                  :(float)n12 :(float)n13 :(float)n14 :(float)n15
{
    CGAffineTransform ctm = CGAffineTransformMake(n00, n01, n04, n05, n12, n13);
    CGContextConcatCTM(ctx, ctm);
}

- (void)pushMatrix
{
    CGAffineTransform ctm = CGContextGetCTM(ctx);
    Matrix2D m = Matrix2DMake(ctm);
    [matrixStack_ appendBytes:&m length:sizeof(Matrix2D)];
}

- (void)popMatrix
{
    Matrix2D m;
    NSUInteger lengthAfterPop = [matrixStack_ length] - sizeof(Matrix2D);
    [matrixStack_ getBytes:&m 
                     range:NSMakeRange(lengthAfterPop, sizeof(Matrix2D))];
    [matrixStack_ setLength:lengthAfterPop];
    
    [self loadIdentity];
    CGContextConcatCTM(ctx, CGAffineTransformMake(m.a, m.b, m.c, m.d, m.tx, m.ty));
}

- (void)loadIdentity
{
    CGAffineTransform ctm = CGContextGetCTM(ctx);
    CGContextConcatCTM(ctx, CGAffineTransformInvert(ctm));
}

- (Matrix3D)matrix
{
    Matrix3D m;
    CGAffineTransform ctm = CGContextGetCTM(ctx);
    m.m00 = ctm.a; m.m10 = ctm.b; m.m01 = ctm.c; m.m11 = ctm.d;
    m.m30 = ctm.tx; m.m31 = ctm.ty;
    
    m.m02 = m.m03 = m.m12 = m.m13 = m.m20 = m.m21 = m.m22 = m.m23 = m.m32 = m.m33 = 0.0f;
    return m;
}

- (void)loadMatrix:(Matrix3D)m
{
    [self loadIdentity];
    CGAffineTransform ctm = CGAffineTransformMake(m.m00, m.m01, m.m10, m.m11, m.m30, m.m31);
    CGContextConcatCTM(ctx, ctm);
}

- (void)rotate:(float)theta :(float)x :(float)y :(float)z
{
    if (z == 0) return;
    CGContextRotateCTM(ctx, theta);
}

- (void)scale:(float)x :(float)y :(float)z
{
    CGContextScaleCTM(ctx, x, y);
}

- (void)translate:(float)x :(float)y :(float)z
{
    CGContextTranslateCTM(ctx, x, y);
}

#pragma mark -
#pragma mark Typography
#pragma mark -

- (void)textFont:(UIFont *)font
{
    if (curFont_ != font) {
        [curFont_ release];
        curFont_ = [font retain];
    }
}

- (void)showText:(NSString *)str :(float)x :(float)y :(float)z
{
    UIGraphicsPushContext(ctx);
    [str drawAtPoint:CGPointMake(x, y) withFont:curFont_];
    UIGraphicsPopContext();
}

#pragma mark -
#pragma mark Pixel
#pragma mark -

- (color)getPixelAtPoint:(CGPoint)p
{
    NSUInteger i = cordsToIndex(p.x, p.y, CGBitmapContextGetWidth(ctx), CGBitmapContextGetHeight(ctx), YES);
    return dePremultiplyColor(data_[i]);
}

- (void)setPixel:(color)clr atPoint:(CGPoint)p
{
    NSUInteger i = cordsToIndex(p.x, p.y, CGBitmapContextGetWidth(ctx), CGBitmapContextGetHeight(ctx), YES);
    data_[i] = premultiplyColor(clr);
}

- (color *)loadPixels
{
    NSUInteger w = self.bounds.size.width;
    NSUInteger h = self.bounds.size.height;
    
    if (pixels_ == NULL) {
        pixels_ = malloc(w * h * sizeof(color));
    }
    for (int i = 0; i < w; i++) {
        for (int j = 0; j < h; j++) {
            pixels_[cordsToIndex(i, j, w, h, YES)] = dePremultiplyColor(data_[j * w + i]);
        }
    }
    return pixels_;
}

- (void)updatePixels
{
    if (pixels_ != NULL) {
        NSUInteger w = self.bounds.size.width;
        NSUInteger h = self.bounds.size.height;

        for (int i = 0; i < w; i++) {
            for (int j = 0; j < h; j++) {
                data_[cordsToIndex(i, j, w, h, YES)] = premultiplyColor(pixels_[j * w + i]);
            }
        }
        
        [self releasePixels];
    }
}

- (void)releasePixels
{
    if (pixels_ != NULL) {
        free(pixels_);
        pixels_ = NULL;
    }
}

#pragma mark -
#pragma mark Image
#pragma mark -
- (void)drawImage:(PImage *)image atPoint:(CGPoint)point
{
    [self drawImage:image inRect:CGRectMake(point.x, point.y, image.width, image.height)];
}

- (void)drawImage:(PImage *)image inRect:(CGRect)rect
{
    CGImageRef img = [image CGImage];
    float fy = rect.origin.y * 2 + rect.size.height;
    
    // Flip the image.
    CGContextConcatCTM(ctx, CGAffineTransformMake(1, 0, 0, -1, 0, fy));
    if (doTint_) {
        CGContextDrawImage(ctx, rect, img);
        // TODO: if tintColor is white, use kCGBlendModeOverlay to make the image transparent.
        CGContextSaveGState(ctx);
        CGContextSetBlendMode(ctx, kCGBlendModeColor);
        CGContextSetRGBFillColor(ctx, tintColor_.red, tintColor_.green, tintColor_.blue, tintColor_.alpha);
        CGContextFillRect(ctx, rect);
        CGContextRestoreGState(ctx);
    } else {
        CGContextDrawImage(ctx, rect, img);        
    }
    CGContextConcatCTM(ctx, CGAffineTransformMake(1, 0, 0, -1, 0, fy));
    CGImageRelease(img);
}

- (void)tint:(float)red :(float)green :(float)blue :(float)alpha
{
    PColorSet(&tintColor_, red, green, blue, alpha);
    doTint_ = YES;
}

- (void)noTint
{
    doTint_ = NO;
}

@end
