//
//  iProcessingAppDelegate.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-15.
//  Copyright campl software 2009. All rights reserved.
//

#import "iProcessingAppDelegate.h"

@implementation iProcessingAppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [navigationController release];
    [window release];
    [super dealloc];
}

@end
