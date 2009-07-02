//
//  PGraphics3D.h
//  iProcessing
//
//  Created by Kenan Che on 09-06-16.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PGraphicsProtocol.h"
#import "Processing+core.h"

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface PGraphics3D : UIView <PGraphics> {

@private
    Processing *p_;
    
    /* The pixel dimensions of the backbuffer */
    GLint backingWidth;
    GLint backingHeight;
    
    EAGLContext *context;
    
    /* OpenGL names for the renderbuffer and framebuffers used to render to this view */
    GLuint viewRenderbuffer, viewFramebuffer;
    
    /* OpenGL name for the depth buffer that is attached to viewFramebuffer, if it exists (0 if it does not exist) */
    GLuint depthRenderbuffer;
    
    BOOL doFill_;
    PColor fillColor_;
    BOOL doStroke_;
    PColor strokeColor_;
    
    UIFont *curFont_;    
}

@end
