//
//  ProcessingTestViewController.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-18.
//  Copyright 2009 campl software. All rights reserved.
//

#import "ProcessingTestViewController.h"
#import "iProcessingAppDelegate.h"
#import "DemoViewController.h"
#import "ExampleListController.h"
#import "Examples.h"

@implementation ProcessingTestViewController

- (void)awakeFromNib
{
    // CODE ... IS ... DATA
    categoryList = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *basicCategories = [[NSMutableDictionary alloc] init];
    ExampleListController *listController;
    NSMutableDictionary *examples;
    DemoViewController *demoController;
    
    // Basic - Spec
    examples = [[NSMutableDictionary alloc] init];
    /// Specs
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[ProcessingSpec class]];
    [examples setObject:demoController forKey:@"2D Specs"];
    [demoController release];    
    /// 3D Specs
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[P3DSpec class]];
    [examples setObject:demoController forKey:@"P3D Specs"];
    [demoController release];    
    
    listController = [[ExampleListController alloc] initWithNibName:@"ExampleList" bundle:nil];
    listController.examples = examples;
    [examples release];
    listController.title = @"Spec";
    [basicCategories setObject:listController forKey:listController.title];
    [listController release];
    
    // Basic - Structure
    examples = [[NSMutableDictionary alloc] init];
    /// Functions
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Functions class]];
    [examples setObject:demoController forKey:@"Functions"];
    [demoController release];        
    /// Redraw
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Redraw class]];
    [examples setObject:demoController forKey:@"Redraw"];
    [demoController release];    

    listController = [[ExampleListController alloc] initWithNibName:@"ExampleList" bundle:nil];
    listController.examples = examples;
    [examples release];
    listController.title = @"Structure";
    [basicCategories setObject:listController forKey:listController.title];
    [listController release];
    
    // Basic - Image
    examples = [[NSMutableDictionary alloc] init];
    /// Pointillism
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Pointillism class]];
    [examples setObject:demoController forKey:@"Pointillism"];
    [demoController release];        
    /// CreateImage
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[CreateImage class]];
    [examples setObject:demoController forKey:@"CreateImage"];
    [demoController release];        
    /// LoadDisplayImage
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[LoadDisplayImage class]];
    [examples setObject:demoController forKey:@"LoadDisplayImage"];
    [demoController release];        
    /// Transparency
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Transparency class]];
    [examples setObject:demoController forKey:@"Transparency"];
    [demoController release];        
    /// Sprite
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Sprite class]];
    [examples setObject:demoController forKey:@"Sprite"];
    [demoController release];        
    /// AlphaMask
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[AlphaMask class]];
    [examples setObject:demoController forKey:@"AlphaMask"];
    [demoController release];        
    
    listController = [[ExampleListController alloc] initWithNibName:@"ExampleList" bundle:nil];
    listController.examples = examples;
    [examples release];
    listController.title = @"Image";
    [basicCategories setObject:listController forKey:listController.title];
    [listController release];
    
    // Basic - Color
    examples = [[NSMutableDictionary alloc] init];
    /// Brightness
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Brightness class]];
    [examples setObject:demoController forKey:@"Brightness"];
    [demoController release];
    /// ColorWeel
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[ColorWheel class]];
    [examples setObject:demoController forKey:@"ColorWheel"];
    [demoController release];
    /// Creating
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Creating class]];
    [examples setObject:demoController forKey:@"Creating"];
    [demoController release];
    /// Hue
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Hue class]];
    [examples setObject:demoController forKey:@"Hue"];
    [demoController release];
    /// Saturation
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Saturation class]];
    [examples setObject:demoController forKey:@"Saturation"];
    [demoController release];
    /// LinearGradient
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[LinearGradient class]];
    [examples setObject:demoController forKey:@"LinearGradient"];
    [demoController release];
    
    listController = [[ExampleListController alloc] initWithNibName:@"ExampleList" bundle:nil];
    listController.examples = examples;
    [examples release];
    listController.title = @"Color";
    [basicCategories setObject:listController forKey:listController.title];
    [listController release];
    
    // Basic - Math
    examples = [[NSMutableDictionary alloc] init];
    /// IncerementDecrement
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[IncrementDecrement class]];
    [examples setObject:demoController forKey:@"Increment/Decrement"];
    [demoController release];
    /// Modulo
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Modulo class]];
    [examples setObject:demoController forKey:@"Modulo"];
    [demoController release];
    /// Random
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Random class]];
    [examples setObject:demoController forKey:@"Random"];
    [demoController release];
    /// Distance1D
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Distance1D class]];
    [examples setObject:demoController forKey:@"Distance1D"];
    [demoController release];
    /// Distance2D
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Distance2D class]];
    [examples setObject:demoController forKey:@"Distance2D"];
    [demoController release];
    /// Sine
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Sine class]];
    [examples setObject:demoController forKey:@"Sine"];
    [demoController release];
    /// SineCosine
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[SineCosine class]];
    [examples setObject:demoController forKey:@"SineCosine"];
    [demoController release];
    /// SineWave
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[SineWave class]];
    [examples setObject:demoController forKey:@"SineWave"];
    [demoController release];
    /// Arctangent
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Arctangent class]];
    [examples setObject:demoController forKey:@"Arctangent"];
    [demoController release];
    /// PolarToCartesian
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[PolarToCartesian class]];
    [examples setObject:demoController forKey:@"PolarToCartesian"];
    [demoController release];
    /// Noise1D
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Noise1D class]];
    [examples setObject:demoController forKey:@"Noise1D"];
    [demoController release];
    /// Noise2D
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Noise2D class]];
    [examples setObject:demoController forKey:@"Noise2D"];
    [demoController release];
    /// Noise3D
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Noise3D class]];
    [examples setObject:demoController forKey:@"Noise3D"];
    [demoController release];
    /// NoiseWave
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[NoiseWave class]];
    [examples setObject:demoController forKey:@"NoiseWave"];
    [demoController release];
    
    listController = [[ExampleListController alloc] initWithNibName:@"ExampleList" bundle:nil];
    listController.examples = examples;
    [examples release];
    listController.title = @"Math";
    [basicCategories setObject:listController forKey:listController.title];
    [listController release];
    
    // Basic - Transform
    examples = [[NSMutableDictionary alloc] init];    
    /// Arm
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Arm class]];
    [examples setObject:demoController forKey:@"Arm"];
    [demoController release];    
    /// Rotate
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Rotate class]];
    [examples setObject:demoController forKey:@"Rotate"];
    [demoController release];
    /// Scale
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Scale class]];
    [examples setObject:demoController forKey:@"Scale"];
    [demoController release];
    /// Translate
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Translate class]];
    [examples setObject:demoController forKey:@"Translate"];
    [demoController release];
    
    listController = [[ExampleListController alloc] initWithNibName:@"ExampleList" bundle:nil];
    listController.examples = examples;
    [examples release];
    listController.title = @"Transform";
    [basicCategories setObject:listController forKey:listController.title];
    [listController release];
    
    // Basic - Form
    examples = [[NSMutableDictionary alloc] init];    
    /// PieChart
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[PieChart class]];
    [examples setObject:demoController forKey:@"PieChart"];
    [demoController release];    
    /// Bezier
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Bezier class]];
    [examples setObject:demoController forKey:@"Bezier"];
    [demoController release];    
    /// ShapePrimitives
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[ShapePrimitives class]];
    [examples setObject:demoController forKey:@"ShapePrimitives"];
    [demoController release];    
    /// TriangleStrip
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[TriangleStrip class]];
    [examples setObject:demoController forKey:@"TriangleStrip"];
    [demoController release];    
    /// BezierEllipse
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[BezierEllipse class]];
    [examples setObject:demoController forKey:@"BezierEllipse"];
    [demoController release];    
    /// SimpleCurve
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[SimpleCurve class]];
    [examples setObject:demoController forKey:@"SimpleCurve"];
    [demoController release];    
    
    listController = [[ExampleListController alloc] initWithNibName:@"ExampleList" bundle:nil];
    listController.examples = examples;
    [examples release];
    listController.title = @"Form";
    [basicCategories setObject:listController forKey:listController.title];
    [listController release];
    
    // Basic - Typography
    examples = [[NSMutableDictionary alloc] init];    
    /// Words
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Words class]];
    [examples setObject:demoController forKey:@"Words"];
    [demoController release];    
    /// Letters
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Letters class]];
    [examples setObject:demoController forKey:@"Letters"];
    [demoController release];    
    
    listController = [[ExampleListController alloc] initWithNibName:@"ExampleList" bundle:nil];
    listController.examples = examples;
    [examples release];
    listController.title = @"Typography";
    [basicCategories setObject:listController forKey:listController.title];
    [listController release];
    
    // Basic - Input
    examples = [[NSMutableDictionary alloc] init];    
    /// Clock
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Clock class]];
    [examples setObject:demoController forKey:@"Clock"];
    [demoController release];    
    /// Constrain
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Constrain class]];
    [examples setObject:demoController forKey:@"Constrain"];
    [demoController release];
    /// Easing
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Easing class]];
    [examples setObject:demoController forKey:@"Easing"];
    [demoController release];
    /// StoringInput
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[StoringInput class]];
    [examples setObject:demoController forKey:@"StoringInput"];
    [demoController release];
    /// Mouse1D
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Mouse1D class]];
    [examples setObject:demoController forKey:@"Mouse1D"];
    [demoController release];
    /// Mouse2D
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Mouse2D class]];
    [examples setObject:demoController forKey:@"Mosue2D"];
    [demoController release];
    /// MouseFunctions
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[MouseFunctions class]];
    [examples setObject:demoController forKey:@"MouseFunctions"];
    [demoController release];
    /// Milliseconds
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Milliseconds class]];
    [examples setObject:demoController forKey:@"Milliseconds"];
    [demoController release];
    
    listController = [[ExampleListController alloc] initWithNibName:@"ExampleList" bundle:nil];
    listController.examples = examples;
    [examples release];
    listController.title = @"Input";
    [basicCategories setObject:listController forKey:listController.title];
    [listController release];
    
    [categoryList setObject:basicCategories forKey:@"Basic"];
    [basicCategories release];
    
    NSMutableDictionary *topicsCategories = [[NSMutableDictionary alloc] init];
    // Topics - Motion
    examples = [[NSMutableDictionary alloc] init];    
    /// Reflection1
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Reflection1 class]];
    [examples setObject:demoController forKey:@"Reflection1"];
    [demoController release];    
    /// SequentialAnim
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[SequentialAnim class]];
    [examples setObject:demoController forKey:@"SequentialAnim"];
    [demoController release];    
    
    listController = [[ExampleListController alloc] initWithNibName:@"ExampleList" bundle:nil];
    listController.examples = examples;
    [examples release];
    listController.title = @"Motion";
    [topicsCategories setObject:listController forKey:listController.title];
    [listController release];
    
    // Topics - Drawing
    examples = [[NSMutableDictionary alloc] init];    
    /// ContinuousLines
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[ContinuousLines class]];
    [examples setObject:demoController forKey:@"ContinuousLines"];
    [demoController release];    
    /// Pattern
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Pattern class]];
    [examples setObject:demoController forKey:@"Pattern"];
    [demoController release];    
    
    listController = [[ExampleListController alloc] initWithNibName:@"ExampleList" bundle:nil];
    listController.examples = examples;
    [examples release];
    listController.title = @"Drawing";
    [topicsCategories setObject:listController forKey:listController.title];
    [listController release];
    
    // Topics - Image Processing
    examples = [[NSMutableDictionary alloc] init];    
    /// Histogram
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Histogram class]];
    [examples setObject:demoController forKey:@"Histogram"];
    [demoController release];    
    /// Blur
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Blur class]];
    [examples setObject:demoController forKey:@"Blur"];
    [demoController release];    
    /// ImageBrightness
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[ImageBrightness class]];
    [examples setObject:demoController forKey:@"ImageBrightness"];
    [demoController release];    
    /// EdgeDetection
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[EdgeDetection class]];
    [examples setObject:demoController forKey:@"EdgeDetection"];
    [demoController release];        
    
    listController = [[ExampleListController alloc] initWithNibName:@"ExampleList" bundle:nil];
    listController.examples = examples;
    [examples release];
    listController.title = @"Image Processing";
    [topicsCategories setObject:listController forKey:listController.title];
    [listController release];
    
    // Topics - Fractals and L-systems
    examples = [[NSMutableDictionary alloc] init];    
    /// Tree
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Tree class]];
    [examples setObject:demoController forKey:@"Tree"];
    [demoController release];    
    /// Mandelbrot
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Mandelbrot class]];
    [examples setObject:demoController forKey:@"Mandelbrot"];
    [demoController release];    
    
    listController = [[ExampleListController alloc] initWithNibName:@"ExampleList" bundle:nil];
    listController.examples = examples;
    [examples release];
    listController.title = @"Fractals and L-systems";
    [topicsCategories setObject:listController forKey:listController.title];
    [listController release];
    
    // Topics - OpenProcessing
    examples = [[NSMutableDictionary alloc] init];    
    /// Green Tornado
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[GreenTornado class]];
    [examples setObject:demoController forKey:@"GreenTornado"];
    [demoController release];    
    /// Green RecursiveSpheres
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[RecursiveSpheres class]];
    [examples setObject:demoController forKey:@"RecursiveSpheres"];
    [demoController release];    
    /// CherryBlossom
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[CherryBlossom class]];
    [examples setObject:demoController forKey:@"CherryBlossom"];
    [demoController release];    
    
    listController = [[ExampleListController alloc] initWithNibName:@"ExampleList" bundle:nil];
    listController.examples = examples;
    [examples release];
    listController.title = @"OpenProcessing";
    [topicsCategories setObject:listController forKey:listController.title];
    [listController release];
    
    // Topics - Effects
    examples = [[NSMutableDictionary alloc] init];    
    /// Plasma
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Plasma class]];
    [examples setObject:demoController forKey:@"Plasma"];
    [demoController release];    
    
    listController = [[ExampleListController alloc] initWithNibName:@"ExampleList" bundle:nil];
    listController.examples = examples;
    [examples release];
    listController.title = @"Effects";
    [topicsCategories setObject:listController forKey:listController.title];
    [listController release];
    
    [categoryList setObject:topicsCategories forKey:@"Topics"];
    [topicsCategories release];    

    NSMutableDictionary *threeDCategories = [[NSMutableDictionary alloc] init];
    // 3D - Form
    examples = [[NSMutableDictionary alloc] init];    
    /// RGBCube
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[RGBCube class]];
    [examples setObject:demoController forKey:@"RGBCube"];
    [demoController release];    
    /// CubicGrid
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[CubicGrid class]];
    [examples setObject:demoController forKey:@"CubicGrid"];
    [demoController release];    
    /// Primitives3D
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Premitives3D class]];
    [examples setObject:demoController forKey:@"Primitives3D"];
    [demoController release];    
    /// Vertices3D
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Vertices3D class]];
    [examples setObject:demoController forKey:@"Vertices3D"];
    [demoController release];    
    /// SpaceJunk
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[SpaceJunk class]];
    [examples setObject:demoController forKey:@"SpaceJunk"];
    [demoController release];    
    
    listController = [[ExampleListController alloc] initWithNibName:@"ExampleList" bundle:nil];
    listController.examples = examples;
    [examples release];
    listController.title = @"Form";
    [threeDCategories setObject:listController forKey:listController.title];
    [listController release];
                
    // 3D - Transform
    examples = [[NSMutableDictionary alloc] init];    
    /// Rotate1
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Rotate1 class]];
    [examples setObject:demoController forKey:@"Rotate1"];
    [demoController release];    
    /// Rotate2
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Rotate2 class]];
    [examples setObject:demoController forKey:@"Rotate2"];
    [demoController release];    
    /// Bird
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Bird class]];
    [examples setObject:demoController forKey:@"Bird"];
    [demoController release];    
    
    listController = [[ExampleListController alloc] initWithNibName:@"ExampleList" bundle:nil];
    listController.examples = examples;
    [examples release];
    listController.title = @"Transform";
    [threeDCategories setObject:listController forKey:listController.title];
    [listController release];
    
    // 3D - Lights
    examples = [[NSMutableDictionary alloc] init];    
    /// LightsGL
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[LightsGL class]];
    [examples setObject:demoController forKey:@"LightsGL"];
    [demoController release];    
    /// Lights1
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Lights1 class]];
    [examples setObject:demoController forKey:@"Lights1"];
    [demoController release];    
    /// Lights2
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Lights2 class]];
    [examples setObject:demoController forKey:@"Lights2"];
    [demoController release];    
    /// Spot
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Spot class]];
    [examples setObject:demoController forKey:@"Spot"];
    [demoController release];    
    /// Directional
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Directional class]];
    [examples setObject:demoController forKey:@"Directional"];
    [demoController release];    
    /// Reflection
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Reflection class]];
    [examples setObject:demoController forKey:@"Reflection"];
    [demoController release];    
    
    listController = [[ExampleListController alloc] initWithNibName:@"ExampleList" bundle:nil];
    listController.examples = examples;
    [examples release];
    listController.title = @"Lights";
    [threeDCategories setObject:listController forKey:listController.title];
    [listController release];    

    // 3D - Texture
    examples = [[NSMutableDictionary alloc] init];    
    /// Texture1
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Texture1 class]];
    [examples setObject:demoController forKey:@"Texture1"];
    [demoController release];    
    /// Texture2
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Texture2 class]];
    [examples setObject:demoController forKey:@"Texture2"];
    [demoController release];    
    /// Texture3
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[Texture3 class]];
    [examples setObject:demoController forKey:@"Texture3"];
    [demoController release];    
    /// TextureCube
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[TextureCube class]];
    [examples setObject:demoController forKey:@"TextureCube"];
    [demoController release];    
    /// TextureSphere
    demoController = [[DemoViewController alloc] initWithNibName:@"DemoView" exampleClass:[TextureSphere class]];
    [examples setObject:demoController forKey:@"TextureSphere"];
    [demoController release];    
    
    listController = [[ExampleListController alloc] initWithNibName:@"ExampleList" bundle:nil];
    listController.examples = examples;
    [examples release];
    listController.title = @"Texture";
    [threeDCategories setObject:listController forKey:listController.title];
    [listController release];    
    
    [categoryList setObject:threeDCategories forKey:@"3D"];
    [threeDCategories release];    
    
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [categoryList release];
    
    [super dealloc];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"Basic";
    else if (section == 1) {
        return @"Topics";
    } else {
        return @"3D";
    }
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *categories;
    
    if (section == 0)
        categories = [categoryList objectForKey:@"Basic"];
    else if (section == 1) {
        categories = [categoryList objectForKey:@"Topics"];
    } else {
        categories = [categoryList objectForKey:@"3D"];
    }
    
    return [[categories allKeys] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
    NSArray *categories;
    
    if (indexPath.section == 0)
        categories = [[categoryList objectForKey:@"Basic"] allKeys];
    else if (indexPath.section == 1) {
        categories = [[categoryList objectForKey:@"Topics"] allKeys];
    } else {
        categories = [[categoryList objectForKey:@"3D"] allKeys];
    }
    
    cell.textLabel.text = [categories objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}



 // Override to support row selection in the table view.
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
 // Navigation logic may go here -- for example, create and push another view controller.
 // AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
 // [self.navigationController pushViewController:anotherViewController animated:YES];
 // [anotherViewController release];
     NSDictionary *categories;
     
     if (indexPath.section == 0)
         categories = [categoryList objectForKey:@"Basic"];
     else if (indexPath.section == 1) {
         categories = [categoryList objectForKey:@"Topics"];
     } else {
         categories = [categoryList objectForKey:@"3D"];
     }
     
     NSString *category = [[categories allKeys] objectAtIndex:indexPath.row];
     ExampleListController *controller = [categories objectForKey:category];
     iProcessingAppDelegate * app = [[UIApplication sharedApplication] delegate];
     [app.navigationController pushViewController:controller animated:YES];    
 }


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

@end
