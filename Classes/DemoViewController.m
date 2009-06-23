//
//  DemoViewController.m
//  iProcessing
//
//  Created by Kenan Che on 09-06-19.
//  Copyright 2009 campl software. All rights reserved.
//

#import "DemoViewController.h"
#import "Processing.h"

@implementation DemoViewController
@synthesize container;

- (id)initWithNibName:(NSString *)nib exampleClass:(Class)ec
{
    if (self = [super initWithNibName:nib bundle:nil]) {
        example = ec;
    }
    return self;
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
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    p = [[example alloc] initWithContainer:container];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [p viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [p viewWillDisappear:animated];
}

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
    [p release];
    [container release];
    [super dealloc];
}


@end
