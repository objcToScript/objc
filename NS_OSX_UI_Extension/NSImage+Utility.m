
#import "NSImage+Utility.h"

@implementation NSImage (Utility)

-(void)_imageResized :(CGFloat)width height:(CGFloat)height
                 complete : (void (^)(NSImage *image))complete{
    
    if(!complete){
        return;
    }
    if(![NSThread isMainThread]){
        complete([self _imageResized:width height:height]);
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSImage *filteredImage = [self _imageResized:width height:height];
        //dispatch_async(dispatch_get_main_queue(), ^
        //               {
                         complete(filteredImage);
        //               });
    });
}

-(NSImage*)_imageResized :(CGFloat)width height:(CGFloat)height{
    
    CGSize newSize = CGSizeMake(width, height);
    
    if(CGSizeEqualToSize(self.size, newSize)){
        // No need to resize nor convert orientation
        return self;
    }

    NSImage *sourceImage = self;
    //[sourceImage setScalesWhenResized:YES];
    
    NSImage *resizedImage = [[NSImage alloc] initWithSize: newSize];
    [resizedImage lockFocus];
    [sourceImage setSize: newSize];
    [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
    [sourceImage drawAtPoint:NSZeroPoint fromRect:CGRectMake(0, 0, newSize.width, newSize.height) operation:NSCompositingOperationCopy fraction:1.0];
    [resizedImage unlockFocus];
    return resizedImage;
}



// マスク生成する
-(NSImage*)_mkMask:(NSImage*)maskImage{
    NSImage *image = self;
    
    // Create a CGImage holding the mask image
    CGImageSourceRef maskSourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)[maskImage TIFFRepresentation], NULL);
    CGImageRef maskRef = CGImageSourceCreateImageAtIndex(maskSourceRef, 0, NULL);
    
    // Create a mask from the provided mask image
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    // Create a CGImage that represents the source image
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)[image TIFFRepresentation], NULL);
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(imageSourceRef, 0, NULL);
    
    // Perform the actual masking
    CGImageRef maskedImage = CGImageCreateWithMask(imageRef, mask);
    
    // Convert the output into NSImage
    NSImage *result = [[NSImage alloc] initWithCGImage:maskedImage size:image.size];
    
    // Release the memory used for creating the mask
    CFRelease(maskSourceRef);
    CGImageRelease(maskRef);
    CGImageRelease(mask);
    
    // Release the memory used for masking the image
    CFRelease(imageSourceRef);
    CGImageRelease(imageRef);	
    CGImageRelease(maskedImage);
    
    return result;
}

// return height in pixel
-(int)_getHeight{
    
    NSImageRep *rep = [[self representations] objectAtIndex:0];
    return (int)rep.pixelsHigh;
}

// return width in pixel
-(int)_getWidth{
    
    NSImageRep *rep = [[self representations] objectAtIndex:0];
    return (int)rep.pixelsWide;
    
}


-(NSData*)_toPngData{
    NSImage *image = self;
    
    BOOL interlaced = false;
    NSDictionary *prop = [NSDictionary
                          dictionaryWithObject:[NSNumber numberWithBool:interlaced]
                          forKey:NSImageInterlaced];
    
    CGImageRef cgRef = [image CGImageForProposedRect:NULL context:nil hints:nil];
    NSBitmapImageRep *newRep = [[NSBitmapImageRep alloc] initWithCGImage:cgRef];
    [newRep setSize:[image size]];   // if you want the same resolution
    NSData *pngData = [newRep representationUsingType:NSPNGFileType properties:prop];

    
    //NSLog(@"-- width=%d, height=%d", (int)bitmapRep.pixelsWide, (int)bitmapRep.pixelsHigh);
    
    return pngData;
}

-(NSData*)_toJpegData{
    NSImage *image = self;
    float quality = 0.7; // 0.0  ~ 1.0 (no compression)
    NSDictionary *prop = [NSDictionary dictionaryWithObjectsAndKeys :
                [NSNumber numberWithFloat : quality],
                NSImageCompressionFactor,
                nil];
    
    CGImageRef cgRef = [image CGImageForProposedRect:NULL context:nil hints:nil];
    NSBitmapImageRep *newRep = [[NSBitmapImageRep alloc] initWithCGImage:cgRef];
    [newRep setSize:[image size]];   // if you want the same resolution
    NSData *jpgData = [newRep representationUsingType:NSJPEGFileType properties:prop];
    
    return jpgData;
}



+(NSImage*)imageNamedEx:(NSString*)path{

  NSString *myFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:path];
  return [[NSImage alloc] initWithContentsOfFile:myFilePath];

}


- (BOOL)_saveJPEGFile:(NSString*)filePath{
    
    NSData* data = [self _toJpegData];
    
    if (![data writeToFile:filePath atomically:YES]) {
        NSLog(@"error %s save failed",__func__);
        return NO;
    }
    
    return YES;
}

- (NSString*)_savePNGFile:(NSString*)filePath{
    
    NSData* data = [self _toPngData];
    
    if (![data writeToFile:filePath atomically:YES]) {
        NSLog(@"error %s save failed",__func__);
        return @"";
    }
    
    return filePath;
}

- (NSString*)_savePNGFile_document:(NSString*)fileName addPath:(NSString*)addPath{
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = @"";
    
    if(![addPath isEqual:@""]){
        filePath = [rootPath stringByAppendingPathComponent:addPath];
        if(![clsDirectory _isDirectory:filePath]){
            [clsDirectory _mkDirectory:filePath];
        }
        
    }else{
        filePath = rootPath;
    }
    
    filePath = [filePath stringByAppendingPathComponent:fileName];
    
    if([clsFile _isFile:filePath]){
        [clsFile _deleteFile:filePath];
    }
    
    NSData* data = [self _toPngData];
    
    if (![data writeToFile:filePath atomically:YES]) {
        NSLog(@"error %s save failed",__func__);
        return @"";
    }
    
    return filePath;
}


-(NSImage*)_loadImageFile:(NSString*)filePath{
       
    NSImage* image = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        image = [[NSImage alloc] initWithContentsOfFile:filePath];
    }else{
        printf("イメージなし");
    }
    
    return image;
}







@end
