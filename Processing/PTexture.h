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

@class PImage;
/// An OpenGL texture object container.
/// This is internal class for font rendering performance.
/// It is not part of Processing. And you should not use it.
@interface PTexture : NSObject
{
@private
    GLuint textureObject;
    int width;
    int height;
}

@property (nonatomic, readonly) GLuint textureObject;
@property (nonatomic, readonly) int width;
@property (nonatomic, readonly) int height;

+ (PTexture *)textureFromPImage:(PImage *)image;
- (id)initWithTextureObject:(GLuint)to width:(int)w height:(int)h;

@end


/// PVRTC texture loader.
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

@property (nonatomic, readonly) GLuint textureObject;
@property (nonatomic, readonly) int width;
@property (nonatomic, readonly) int height;
@property (nonatomic, readonly) BOOL hasAlpha;
@property (nonatomic, readonly) BOOL mipmap;

- (id)initWithContentsOfFile:(NSString *)path;
+ (id)textureWithContentsOfFile:(NSString *)path;

@end
