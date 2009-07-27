//
//  PTexture.h
//  iProcessing
//
//  Created by Kenan Che on 09-07-21.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@protocol PTexture

@required

- (GLuint)textureObject;
- (int)width;
- (int)height;
- (BOOL)hasAlpha;
- (BOOL)mipmap;

- (BOOL)createTextureObject;

@optional

- (void)mipmap:(BOOL)yesno;

@end


/// Adapted from PVRTexture of PVRTextureLoader sample .
@interface PVRTexture : NSObject<PTexture> {

@private
    NSMutableArray *imageData_;
    GLuint textureObject_;
    int width_;
    int height_;
    GLenum internalFormat_;
    
    BOOL hasAlpha_;
    BOOL mipmap_;
}

@property (readonly) GLuint textureObject;
@property (readonly) int width;
@property (readonly) int height;
@property (readonly) BOOL hasAlpha;
@property (readonly) BOOL mipmap;

- (id)initWithContentsOfFile:(NSString *)path;
+ (id)textureWithContentsOfFile:(NSString *)path;

@end
