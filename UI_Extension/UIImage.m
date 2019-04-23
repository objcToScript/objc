
#import "UIImage.h"

@implementation UIImage (ex)

- (void)_imageResized:(CGFloat)width height:(CGFloat)height
             complete:(void (^)(UIImage* image))complete
{

    if (!complete) {
        return;
    }
    if (![NSThread isMainThread]) {
        complete([self _imageResized:width height:height]);
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage* filteredImage = [self _imageResized:width height:height];
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(filteredImage);
        });
    });
}

- (UIImage*)_imageResized:(CGFloat)width height:(CGFloat)height
{

    CGSize size = CGSizeMake(width, height);

    if (CGSizeEqualToSize(self.size, size) && self.imageOrientation == UIImageOrientationUp) {
        // No need to resize nor convert orientation
        return self;
    }
    UIGraphicsBeginImageContext(size);
    @try {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
        [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
        return UIGraphicsGetImageFromCurrentImageContext();
    }
    @finally {
        UIGraphicsEndImageContext();
    }
}

// マスク生成する
- (UIImage*)_mkMask:(UIImage*)maskImg
{

    CGImageRef orgRef = maskImg.CGImage;
    CGImageRef maskRef = CGImageMaskCreate(CGImageGetWidth(orgRef),
                                           CGImageGetHeight(orgRef),
                                           CGImageGetBitsPerComponent(orgRef),
                                           CGImageGetBitsPerPixel(orgRef),
                                           CGImageGetBytesPerRow(orgRef),
                                           CGImageGetDataProvider(orgRef),
                                           NULL, NO);
    // マスクを適応
    CGImageRef compRef = CGImageCreateWithMask(self.CGImage, maskRef);
    UIImage* compImg = [UIImage imageWithCGImage:compRef];

    // CGImage解放
    CGImageRelease(maskRef);
    CGImageRelease(compRef);

    return compImg;
}

- (int)_getHeight
{

    int height = (int)CGImageGetHeight(self.CGImage);

    return height;
}

- (int)_getWidth
{

    int width = (int)CGImageGetWidth(self.CGImage);

    return width;
}

- (NSData*)_toPngData
{
    NSData* imageData = UIImagePNGRepresentation(self);
    return imageData;
}

- (NSData*)_toJpegData
{
    NSData* imageData = UIImageJPEGRepresentation(self, 0.9);
    return imageData;
}

+ (UIImage*)imageNamedEx:(NSString*)path
{

    NSString* myFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:path];
    return [[UIImage alloc] initWithContentsOfFile:myFilePath];
}

- (BOOL)_saveJPEGFile:(NSString*)fileName
{

    NSString* name = [fileName stringByAppendingPathExtension:@"jpg"];
    NSString* rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* filePath = [rootPath stringByAppendingPathComponent:name];

    NSData* data = UIImageJPEGRepresentation(self, 1.0);

    if (![data writeToFile:filePath atomically:YES]) {
        NSLog(@"error %s save failed", __func__);
        return NO;
    }

    return YES;
}

- (NSString*)_savePNGFile:(NSString*)filePath
{
    NSData* data = UIImagePNGRepresentation(self);

    if (![data writeToFile:filePath atomically:YES]) {
        NSLog(@"error %s save failed", __func__);
        return @"";
    }

    return filePath;
}

- (NSString*)_savePNGFile_document:(NSString*)fileName addPath:(NSString*)addPath
{

    NSString* rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

    NSString* filePath = @"";

    if (![addPath isEqual:@""]) {
        filePath = [rootPath stringByAppendingPathComponent:addPath];
        if (![clsDirectory _isDirectory:filePath]) {
            [clsDirectory _mkDirectory:filePath];
        }

    } else {
        filePath = rootPath;
    }

    filePath = [filePath stringByAppendingPathComponent:fileName];

    if ([clsFile _isFile:filePath]) {
        [clsFile _deleteFile:filePath];
    }

    NSData* data = UIImagePNGRepresentation(self);

    if (![data writeToFile:filePath atomically:YES]) {
        NSLog(@"error %s save failed", __func__);
        return @"";
    }

    return filePath;
}

- (UIImage*)_loadImageFile:(NSString*)filePath
{

    NSLog(@"load filepath : %@", filePath);

    UIImage* image = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        image = [UIImage imageWithContentsOfFile:filePath];
    } else {
        printf("イメージなし");
    }

    return image;
}

@end
