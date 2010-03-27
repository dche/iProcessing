//
//  HelloWorldAppDelegate.m
//  iProcessing
//
//  Created by Kenan Che on 09-08-25.
//  Copyright 2009 campl software. All rights reserved.
//

#import "HelloWorldAppDelegate.h"


@implementation HelloWorldAppDelegate
@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    [window makeKeyAndVisible];
}

- (void)dealloc
{
    [window release];
    [super dealloc];
}

@end
