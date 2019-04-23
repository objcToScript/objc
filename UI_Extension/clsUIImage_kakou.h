
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
  BMP_FILTER_TYPE_HUE = 1,
  BMP_FILTER_TYPE_SATURATION,
  BMP_FILTER_TYPE_VALUE,
  BMP_FILTER_TYPE_RED,
  BMP_FILTER_TYPE_GREEN,
  BMP_FILTER_TYPE_BLUE,
}BmpFilterType;

typedef enum {
  BMP_FILTER_MASK_ALPHAZERO = 1,
  BMP_FILTER_MASK_VALUEZERO,
  BMP_FILTER_MASK_VALUEMAX,
  BMP_FILTER_MASK_BLACK,
  BMP_FILTER_MASK_WHITE,
  BMP_FILTER_MASK_GRAYSCALE,
}BmpFilterMask;

typedef enum {
  IMAGE_ROTATE_ANGLE_LEFT = 90,
  IMAGE_ROTATE_ANGLE_UPSIDEDOWN = 180,
  IMAGE_ROTATE_ANGLE_RIGHT = 270,
}ImageRotateAngele; 

@interface UIImage (kakou)

// UIimage CGImageの角度を再設定する
-(UIImage*)_rotate:(UIImage*) src andOrientation:(UIImageOrientation)orientation;

// UIViewをUIImageに変換して返す
+ (UIImage*)_createImageFromView:(UIView*)view;
// 角丸
+ (UIImage*)_createImageFromView:(UIView *)view corner:(CGFloat)corner;

// imageを再生成する
- (UIImage*)ReDecodingImage;

// 画像のリサイズ
//- (UIImage*)_resizeImageToWidth:(int)width height:(int)height;

// 回転
- (UIImage *) rotateImage:(UIImage *)img angle:(ImageRotateAngele)angle;



// アスペクト比を維持したリサイズのサイズを返す
- (CGSize)getResizeToWidth:(int)width height:(int)height;

// 画像のクロップ(切り抜き)
- (UIImage*)_imageByCroppingToRect:(CGRect)rect;

// セピア効果
- (UIImage*)sepiaScale;

// 白黒効果（グレースケール）
- (UIImage*)grayScale;

// 反転効果
- (UIImage*)negativeScale;

// ガンマ補正
- (UIImage*)setGanma:(float)ganma;

// 深度
- (UIImage*)setV:(float)_v;

// 明度
- (UIImage*)setS:(float)_s;

// フィルタ
- (UIImage*)filterType:(BmpFilterType)type mask:(BmpFilterMask)mask thresholdMin:(float)tMin ThresholdMax:(float)tMax include:(BOOL)inc;

// 鏡面
- (UIImage*)mirrorHorizon:(BOOL)hori Vertical:(BOOL)vert;

// HSV to RGB
+ (void)_HSV2RGB:(float)h s:(float)s v:(float)v r:(float*)r g:(float*)g b:(float*)b;

// RGB to HSV
+ (void)_RGB2HSV:(float)r g:(float)g b:(float)b h:(float*)h s:(float*)s v:(float*)v;

// UIImageの色変換
+ (UIImage*)_changeUIImageColor2:(UIImage *)image h:(double)H s:(double)S v:(double)V;



@end
