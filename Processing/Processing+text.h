//
//  Processing+text.h
//  Processing Touch
//
//  Created by Kenan Che on 09-06-06.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Processing+core.h"

@interface Processing (Text)

- (void)text:(NSString *)str :(float)x :(float)y;
- (void)text:(NSString *)str :(float)x :(float)y :(float)z;
- (void)text:(NSString *)str :(float)x :(float)y :(float)width :(float)height;
- (void)text:(NSString *)str :(float)x :(float)y :(float)width :(float)height :(float)z;

- (void)textFont:(UIFont *)font;
- (void)textFont:(UIFont *)font :(float)size;

- (void)textAlign:(int)align;
- (void)textAlign:(int)align :(int)yalign;

- (void)textLeading:(float)dist;

- (void)textMode:(int)mode;
- (void)textSize:(float)size;

- (float)textWidth:(NSString *)str;

- (float)textAscent;
- (float)textDescent;

@end
