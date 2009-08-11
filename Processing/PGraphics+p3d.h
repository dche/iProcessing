//
//  PGraphics+p3d.h
//  iProcessing
//
//  Created by Kenan Che on 09-07-09.
//  Copyright 2009 campl software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGraphics.h"

@interface PGraphics (ThreeD)

#pragma mark Texture
- (void)texture:(NSObject<PTexture> *)img;
- (void)textureMode:(int)mode;
// FIXME: should move this mothod to ext group?
- (PVRTexture *)loadTexture:(NSString *)name;

#pragma 3D Primitives
- (void)box:(float)size;
- (void)box:(float)width :(float)height :(float)depth;
- (void)sphere:(float)radius;
- (void)sphereDetail:(float)res;
- (void)sphereDetail:(float)ures :(float)vres;

#pragma mark Lights
- (void)ambientLight:(float)v1 :(float)v2 :(float)v3;
- (void)ambientLight:(float)v1 :(float)v2 :(float)v3 :(float)x :(float)y :(float)z;
- (void)directionalLight:(float)v1 :(float)v2 :(float)v3 :(float)x :(float)y :(float)z;
- (void)lightFalloff:(float)constant :(float)linear :(float)quadratic;
- (void)lightSpecular:(float)v1 :(float)v2 :(float)v3;
- (void)lights;
- (void)noLights;
- (void)normal:(float)x :(float)y :(float)z;
- (void)pointLight:(float)v1 :(float)v2 :(float)v3 :(float)x :(float)y :(float)z;
- (void)spotLight:(float)v1 :(float)v2 :(float)v3 
                 :(float)x :(float)y :(float)z 
                 :(float)nx :(float)ny :(float)nz :(float)angle :(float)concentration;

#pragma mark Camera
- (void)beginCamera;
- (void)camera;
- (void)camera:(float)eyeX :(float)eyeY :(float)eyeZ 
              :(float)centerX :(float)centerY :(float)centerZ 
              :(float)upX :(float)upY :(float)upZ;
- (void)endCamera;
- (void)frustum:(float)left :(float)right :(float)bottom :(float)top :(float)near :(float)far;
- (void)ortho:(float)left :(float)right :(float)bottom :(float)top :(float)near :(float)far;
- (void)perspective;
- (void)perspective:(float)fov :(float)aspect :(float)zNear :(float)zFar;
- (void)printCamera;
- (void)printPerspective;

#pragma mark Coordinates
- (float)modelX:(float)x :(float)y :(float)z;
- (float)modelY:(float)x :(float)y :(float)z;
- (float)modelZ:(float)x :(float)y :(float)z;
- (float)screenX:(float)x :(float)y :(float)z;
- (float)screenY:(float)x :(float)y :(float)z;
- (float)screenZ:(float)x :(float)y :(float)z;

#pragma mark Material properties
- (void)ambient:(color)clr;
- (void)ambient:(float)v1 :(float)v2 :(float)v3;
- (void)emissive:(color)clr;
- (void)shininess:(float)shine;
- (void)specular:(color)clr;
- (void)specular:(float)gray :(float)alpha;
- (void)specular:(float)v1 :(float)v2 :(float)v3;
- (void)specular:(float)v1 :(float)v2 :(float)v3 :(float)alpha;

@end
