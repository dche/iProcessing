//
//  iProcessingAppDelegate.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-15.
//  Copyright campl software 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iProcessingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

