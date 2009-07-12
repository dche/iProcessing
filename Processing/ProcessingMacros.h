/*
 *  ProcessingMacros.h
 *  iProcessing
 *
 *  Defines names used as Processing constants.
 *
 *  Created by Kenan Che on 09-06-05.
 *  Copyright 2009 campl software. All rights reserved.
 *
 */

/// color type. It is not a macro, but it is user visible. So defined here.
typedef UInt32 color;

#define R  (3)
#define G  (2)
#define B  (1)
#define A  (0)

#define H  (1)
#define S  (2)

#define EPSILON  (0.0001f)

// useful goodness

#define PI  (3.14159265358979323846f)
#define HALF_PI     (PI * 0.5f)
#define THIRD_PI    (PI / 3.0f)
#define QUARTER_PI  (PI * 0.25f)
#define TWO_PI      (PI * 2.0f)

#define DEG_TO_RAD  (PI/180.0f)
#define RAD_TO_DEG  (180.0f/PI)


// for colors and/or images

#define RGB    (1)  // image & color
#define ARGB   (2)  // image
#define RGBA   (2)
#define HSB    (3)  // color
#define ALPHA  (4)  // image
#define CMYK   (5)  // image & color (someday)


// image file types

#define TIFF   (0)
#define TARGA  (1)
#define JPEG   (2)
#define GIF    (3)


// filter/convert types

#define BLUR       (11)
#define GRAY       (12)
#define INVERT     (13)
#define OPAQUE     (14)
#define POSTERIZE  (15)
#define THRESHOLD  (16)
#define ERODE      (17)
#define DILATE     (18)


// blend mode keyword definitions

#define REPLACE     (0)
#define BLEND       (1 << 0)
#define ADD         (1 << 1)
#define SUBTRACT    (1 << 2)
#define LIGHTEST    (1 << 3)
#define DARKEST     (1 << 4)
#define DIFFERENCE  (1 << 5)
#define EXCLUSION   (1 << 6)
#define MULTIPLY    (1 << 7)
#define SCREEN      (1 << 8)
#define OVERLAY     (1 << 9)
#define HARD_LIGHT  (1 << 10)
#define SOFT_LIGHT  (1 << 11)
#define DODGE       (1 << 12)
#define BURN        (1 << 13)

// colour component bitmasks

#define RED_SHIFT   ((3 - R) * 8)
#define GREEN_SHIFT ((3 - G) * 8)
#define BLUE_SHIFT  ((3 - B) * 8)
#define ALPHA_SHIFT ((3 - A) * 8)

#define RED_MASK    (0xff << RED_SHIFT)
#define GREEN_MASK  (0xff << GREEN_SHIFT)
#define BLUE_MASK   (0xff << BLUE_SHIFT)
#define ALPHA_MASK  (0xff << ALPHA_SHIFT)

// types of projection matrices

#define CUSTOM        (0) // user-specified fanciness
#define ORTHOGRAPHIC  (2) // 2D isometric projection
#define PERSPECTIVE   (3) // perspective matrix


// shapes

// the low four bits set the variety,
// higher bits set the specific shape type

// #define GROUP            ((1 << 2))

#define POINT            (2)  // shared with light (!)
#define POINTS           (2)

#define LINE             (4)
#define LINES            (4)

#define TRIANGLE         (8)
#define TRIANGLES        (9)
#define TRIANGLE_STRIP   (10)
#define TRIANGLE_FAN     (11)

#define QUAD             (16)
#define QUADS            (16)
#define QUAD_STRIP       (17)

#define POLYGON          (20)
#define PATH             (21)

#define RECT             (30)
#define ELLIPSE          (31)
#define ARC              (32)

#define SPHERE           (40)
#define BOX              (41)

// shape closing modes

#define OPEN  (1)
#define CLOSE  (2)

// shape drawing modes

/** Draw mode convention to use (x, y) to (width, height) */
#define CORNER    (0)
/** Draw mode convention to use (x1, y1) to (x2, y2) coordinates */
#define CORNERS   (1)
/** Draw mode from the center, and using the radius */
#define RADIUS    (2)
/**
 * Draw from the center, using second pair of values as the diameter.
 * Formerly called CENTER_DIAMETER in alpha releases.
 */
#define CENTER    (3)
/**
 * Synonym for the CENTER constant. Draw from the center,
 * using second pair of values as the diameter.
 */
#define DIAMETER  (3)

// Horizontal alignment modes for text, and mouse buttons

#define LEFT    (0)
#define RIGHT   (1)
// Share CENTER with shape modes.

// vertically alignment modes for text

/** Default vertical alignment for text placement */
#define BASELINE  (0)
/** Align text to the top */
#define TOP  (101)
/** Align text from the bottom, using the baseline. */
#define BOTTOM  (102)


// uv texture orientation modes

/** texture coordinates in 0..1 range */
#define NORMAL      (1)
/** @deprecated use NORMAL instead */
#define NORMALIZED  (1)
/** texture coordinates based on image width/height */
#define IMAGE       (2)


// text placement modes

/**
 * textMode(MODEL) is the default, meaning that characters
 * will be affected by transformations like any other shapes.
 * <p/>
 * Changed value in 0093 to not interfere with LEFT, CENTER, and RIGHT.
 */
#define MODEL  (4)

/**
 * textMode(SHAPE) draws text using the the glyph outlines of
 * individual characters rather than as textures. If the outlines are
 * not available, then textMode(SHAPE) will be ignored and textMode(MODEL)
 * will be used instead. For this reason, be sure to call textMode()
 * <EM>after</EM> calling textFont().
 * <p/>
 * Currently, textMode(SHAPE) is only supported by OPENGL mode.
 * It also requires Java 1.2 or higher (OPENGL requires 1.4 anyway)
 */
#define SHAPE  (5)


// text alignment modes
// are inherited from LEFT, CENTER, RIGHT


// stroke modes

#define SQUARE    (1 << 0)  // called 'butt' in the svg spec
#define ROUND     (1 << 1)
#define PROJECT   (1 << 2)  // called 'square' in the svg spec
#define MITER     (1 << 3)
#define BEVEL     (1 << 5)


// lighting

#define AMBIENT  (0)
#define DIRECTIONAL   (1)
//#define POINT   (2)  // shared with shape feature
#define SPOT  (3)

// Graphic mode
#define OPENGL      0
#define P3D         OPENGL
#define QUARTZ2D    1
#define P2D         2
