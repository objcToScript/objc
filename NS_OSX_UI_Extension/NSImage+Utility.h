
#import <AppKit/AppKit.h>

@interface NSImage (Utility)

-(int)_getHeight;
-(int)_getWidth;

-(NSData*)_toPngData;
-(NSData*)_toJpegData;

//imageNamedEx キャッシュメモリ対策
+(NSImage*)imageNamedEx:(NSString*)path;

-(NSImage*)_mkMask:(NSImage*)maskImg;

-(void)_imageResized:(CGFloat)width height:(CGFloat)height
            complete: (void (^)(NSImage *image))complete;

-(NSImage*)_imageResized:(CGFloat)width height:(CGFloat)height;

// 画像保存(.jpg)
- (BOOL)_saveJPEGFile:(NSString*)fileName;

// 画像保存(.png)
- (NSString*)_savePNGFile:(NSString*)filePath;

- (NSString*)_savePNGFile_document:(NSString*)fileName addPath:(NSString*)addPath;

//画像読み込み(.png)
-(NSImage*)_loadImageFile:(NSString*)filePath;







@end
