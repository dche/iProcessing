//
//  PRender3D.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-16.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PRenderProtocol.h"
#import "PGraphics.h"

#import "OpenGL_support.h"

@interface PRender3D : UIView <PRender> {

@private
    PGraphics *p_;
    
    /// Flag of first initialized, to avoid duplicated setupGL()
    BOOL inInit_;
    
    /// The pixel dimensions of the backbuffer
    GLint backingWidth;
    GLint backingHeight;
    
    EAGLContext *context;
    
    color *pixels_;
    
    /// OpenGL names for the renderbuffer and framebuffers used to render to this view
    GLuint viewRenderbuffer, viewFramebuffer;
    
    /// OpenGL name for the depth buffer that is attached to viewFramebuffer, if it exists (0 if it does not exist)
    GLuint depthRenderbuffer;
    
    BOOL doFill_;
    PColor fillColor_;
    BOOL doStroke_;
    PColor strokeColor_;
    BOOL doTint_;
    PColor tintColor_;
    
    int textureMode_;
    
    UIFont *curFont_;
    NSMutableDictionary *textImageCache_;
    
    /// Private vertex data.
    NSMutableData *vertices_;
    NSMutableData *indices_;
    NSMutableData *colors_;
    NSMutableData *normals_;
    NSMutableData *texCoords_;
    
    /// Sphere detail. Both default are 30.
    GLfloat sphereURes_;
    GLfloat sphereVRes_;
    NSMutableData *unitCircleCache_;
    NSMutableData *sphereIndexCache_;
    
    /// Flag when baginCamera();
    BOOL cameraBegan;
    
    //................
    // Lighting
    //................
    
    /// curLights_ = 1 + the largest number of light currently enabled. 
    /// For examle, if LIGHT7 is enabled, curLights_ should equal to 8.
    NSUInteger curLights_;
    PColor lightSpecular_;
    GLfloat lightAttenuationConst_;
    GLfloat lightAttenuationLinear_;
    GLfloat lightAttenuationQuardratic_;
}

@end
