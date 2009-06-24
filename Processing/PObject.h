//
//  PObject.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-24.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Processing;

@interface PObject : NSObject {

@private
    Processing *p_;
}

@property (nonatomic, retain) Processing *p;

@end
