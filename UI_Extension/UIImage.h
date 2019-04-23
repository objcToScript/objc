
#import <UIKit/UIKit.h>

@interface UIImage (ex)

//高さを取得する
- (int)_getHeight;
//横を取得する
- (int)_getWidth;
//pngにする
- (NSData*)_toPngData;
//jpegにする
- (NSData*)_toJpegData;
//imageNamedEx キャッシュメモリ対策
+ (UIImage*)imageNamedEx:(NSString*)path;

//マスクを適用させる
- (UIImage*)_mkMask:(UIImage*)maskImg;

//イメージをリサイズする　非同期
- (void)_imageResized:(CGFloat)width height:(CGFloat)height
             complete:(void (^)(UIImage* image))complete;

//イメージをリサイズする
- (UIImage*)_imageResized:(CGFloat)width height:(CGFloat)height;

// 画像保存(.jpg)
- (BOOL)_saveJPEGFile:(NSString*)fileName;

// 画像保存(.png)
- (NSString*)_savePNGFile:(NSString*)filePath;
- (NSString*)_savePNGFile_document:(NSString*)fileName addPath:(NSString*)addPath;

//画像読み込み(.png)
- (UIImage*)_loadImageFile:(NSString*)filePath;

@end
