//
//  ExampleListController.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-19.
//  Copyright 2009 campl software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ExampleListController : UITableViewController {

    @private
    
    NSDictionary *examples;
    
}

@property (nonatomic, retain) NSDictionary *examples;

@end
