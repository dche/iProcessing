//
//  PTexture.m
//  iProcessing
//
//  Created by Kenan Che on 09-07-21.
//  Copyright 2009 campl software. All rights reserved.
//

#import "PTexture.h"

/*
  
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
 WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
 WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
 COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR
 DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF
 CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF
 APPLE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2008-2009 Apple Inc. All Rights Reserved.
 
 */

#define PVR_TEXTURE_FLAG_TYPE_MASK	0xff

static char gPVRTexIdentifier[4] = "PVR!";

enum
{
	kPVRTextureFlagTypePVRTC_2 = 24,
	kPVRTextureFlagTypePVRTC_4
};

typedef struct _PVRTexHeader
{
    uint32_t headerLength;
    uint32_t height;
    uint32_t width;
    uint32_t numMipmaps;
    uint32_t flags;
    uint32_t dataLength;
    uint32_t bpp;
    uint32_t bitmaskRed;
    uint32_t bitmaskGreen;
    uint32_t bitmaskBlue;
    uint32_t bitmaskAlpha;
    uint32_t pvrTag;
    uint32_t numSurfs;
} PVRTexHeader;

@implementation PVRTexture

@synthesize width = width_;
@synthesize height = height_;
@synthesize textureObject = textureObject_, hasAlpha = hasAlpha_, mipmap = mipmap_;

- (BOOL)unpackPVRData:(NSData *)data
{
	BOOL success = FALSE;
	PVRTexHeader *header = NULL;
	uint32_t flags, pvrTag;
	uint32_t dataLength = 0, dataOffset = 0, dataSize = 0;
	uint32_t blockSize = 0, widthBlocks = 0, heightBlocks = 0;
	uint32_t width = 0, height = 0, bpp = 4;
	uint8_t *bytes = NULL;
	uint32_t formatFlags;
	
	header = (PVRTexHeader *)[data bytes];
	
	pvrTag = CFSwapInt32LittleToHost(header->pvrTag);
    
	if (gPVRTexIdentifier[0] != ((pvrTag >>  0) & 0xff) ||
		gPVRTexIdentifier[1] != ((pvrTag >>  8) & 0xff) ||
		gPVRTexIdentifier[2] != ((pvrTag >> 16) & 0xff) ||
		gPVRTexIdentifier[3] != ((pvrTag >> 24) & 0xff))
	{
		return FALSE;
	}
	
	flags = CFSwapInt32LittleToHost(header->flags);
	formatFlags = flags & PVR_TEXTURE_FLAG_TYPE_MASK;
	
	if (formatFlags == kPVRTextureFlagTypePVRTC_4 || formatFlags == kPVRTextureFlagTypePVRTC_2)
	{
		[imageData_ removeAllObjects];
		
		if (formatFlags == kPVRTextureFlagTypePVRTC_4)
			internalFormat_ = GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG;
		else if (formatFlags == kPVRTextureFlagTypePVRTC_2)
			internalFormat_ = GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG;
        
		width_ = width = CFSwapInt32LittleToHost(header->width);
		height_ = height = CFSwapInt32LittleToHost(header->height);
		
		if (CFSwapInt32LittleToHost(header->bitmaskAlpha))
			hasAlpha_ = TRUE;
		else
			hasAlpha_ = FALSE;
		
		dataLength = CFSwapInt32LittleToHost(header->dataLength);
		
		bytes = ((uint8_t *)[data bytes]) + sizeof(PVRTexHeader);
		
		// Calculate the data size for each texture level and respect the minimum number of blocks
		while (dataOffset < dataLength)
		{
			if (formatFlags == kPVRTextureFlagTypePVRTC_4)
			{
				blockSize = 4 * 4; // Pixel by pixel block size for 4bpp
				widthBlocks = width / 4;
				heightBlocks = height / 4;
				bpp = 4;
			}
			else
			{
				blockSize = 8 * 4; // Pixel by pixel block size for 2bpp
				widthBlocks = width / 8;
				heightBlocks = height / 4;
				bpp = 2;
			}
			
			// Clamp to minimum number of blocks
			if (widthBlocks < 2)
				widthBlocks = 2;
			if (heightBlocks < 2)
				heightBlocks = 2;
            
			dataSize = widthBlocks * heightBlocks * ((blockSize  * bpp) / 8);
			
			[imageData_ addObject:[NSData dataWithBytes:bytes+dataOffset length:dataSize]];
			
			dataOffset += dataSize;
			
			width = MAX(width >> 1, 1);
			height = MAX(height >> 1, 1);
		}
        mipmap_ = ([imageData_ count] > 1);
		success = TRUE;
	}	
	return success;
}

- (BOOL)createTextureObject
{
	int width = width_;
	int height = height_;
	NSData *data;
	GLenum err;
	
	if ([imageData_ count] > 0)
	{
		if (textureObject_ != 0)
			glDeleteTextures(1, &textureObject_);
		
		glGenTextures(1, &textureObject_);
		glBindTexture(GL_TEXTURE_2D, textureObject_);
	}
	
	for (int i=0; i < [imageData_ count]; i++)
	{
		data = [imageData_ objectAtIndex:i];
		glCompressedTexImage2D(GL_TEXTURE_2D, i, internalFormat_, width, height, 0, [data length], [data bytes]);
		
		err = glGetError();
		if (err != GL_NO_ERROR)
		{
			NSLog(@"Error uploading compressed texture level: %d. glError: 0x%04X", i, err);
			return FALSE;
		}
		
		width = MAX(width >> 1, 1);
		height = MAX(height >> 1, 1);
	}
	
	[imageData_ removeAllObjects];
	
	return TRUE;
}

- (id)initWithContentsOfFile:(NSString *)path
{
    if (self = [super init]) {
		NSData *data = [NSData dataWithContentsOfFile:path];
		
		imageData_ = [[NSMutableArray alloc] initWithCapacity:10];
		
		textureObject_ = 0;
		width_ = height_ = 0;
		internalFormat_ = GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG;
		hasAlpha_ = FALSE;
		
		if (!data || ![self unpackPVRData:data])
		{
			[self release];
			self = nil;
		}
    }
    return self;
}

+ (id)textureWithContentsOfFile:(NSString *)path
{
    return [[[self alloc] initWithContentsOfFile:path] autorelease];
}

- (void)dealloc
{
	[imageData_ release];	
	if (textureObject_ != 0)
		glDeleteTextures(1, &textureObject_);
    
    [super dealloc];
}

@end
