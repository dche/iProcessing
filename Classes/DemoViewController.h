//
//  DemoViewController.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-19.
//  Copyright 2009 campl software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Processing;

@interface DemoViewController : UIViewController {

@private
    Processing *p;
    UIView *container;
    Class example;
}

@property (nonatomic, retain) IBOutlet UIView *container;

- (id)initWithNibName:(NSString *)nib exampleClass:(Class)ec;

@end
