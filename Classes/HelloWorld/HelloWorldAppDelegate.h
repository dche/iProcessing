//
//  HelloWorldAppDelegate.h
//  iProcessing
//
//  Created by Kenan Che on 09-08-25.
//  Copyright 2009 campl software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HelloWorldAppDelegate : NSObject<UIApplicationDelegate> {
    
@private
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
