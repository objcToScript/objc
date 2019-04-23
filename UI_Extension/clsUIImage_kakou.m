
#import "clsUIImage_kakou.h"

@implementation UIImage (kakou)

-(UIImage*)_rotate:(UIImage*) src andOrientation:(UIImageOrientation)orientation
{
  UIGraphicsBeginImageContext(src.size);
  
  CGContextRef context=(UIGraphicsGetCurrentContext());
  
  if (orientation == UIImageOrientationRight) {
    CGContextRotateCTM (context, 90/180*M_PI) ;
  } else if (orientation == UIImageOrientationLeft) {
    CGContextRotateCTM (context, -90/180*M_PI);
  } else if (orientation == UIImageOrientationDown) {
    // NOTHING
  } else if (orientation == UIImageOrientationUp) {
    CGContextRotateCTM (context, 90/180*M_PI);
  }
  
  [src drawAtPoint:CGPointMake(0, 0)];
  UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return img;
  
}

+ (UIImage*)_createImageFromView:(UIView*)view
{
	UIImage *createImage;
  UIGraphicsBeginImageContext(view.frame.size);
  [view.layer renderInContext:UIGraphicsGetCurrentContext()];
  createImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return createImage;
}

// 角丸
+ (UIImage*)_createImageFromView:(UIView *)view corner:(CGFloat)corner
{
  view.clipsToBounds = YES;
  [view.layer setCornerRadius:corner];
  
  UIImage *createImage;
  UIGraphicsBeginImageContext(view.frame.size);
  [view.layer renderInContext:UIGraphicsGetCurrentContext()];
  createImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return createImage;
}

- (UIImage*)ReDecodingImage
{
	CGImageRef imageRef = [self CGImage];
	UIGraphicsBeginImageContext(CGSizeMake(CGImageGetWidth(imageRef), CGImageGetHeight(imageRef)));
	[self drawAtPoint:CGPointMake(0, 0)];
	UIImage* retImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return retImage;
}


- (UIImage *) rotateImage:(UIImage *)img angle:(ImageRotateAngele)angle
{
  CGImageRef imgRef = [img CGImage];
  CGContextRef context;
  
  switch (angle) {
    case IMAGE_ROTATE_ANGLE_LEFT:
      UIGraphicsBeginImageContext(CGSizeMake(img.size.height, img.size.width));
      context = UIGraphicsGetCurrentContext();
      CGContextTranslateCTM(context, img.size.height, img.size.width);
      CGContextScaleCTM(context, 1.0, -1.0);
      CGContextRotateCTM(context, M_PI/2.0);
      break;
    case IMAGE_ROTATE_ANGLE_UPSIDEDOWN:
      UIGraphicsBeginImageContext(CGSizeMake(img.size.width, img.size.height));
      context = UIGraphicsGetCurrentContext();
      CGContextTranslateCTM(context, img.size.width, 0);
      CGContextScaleCTM(context, 1.0, -1.0);
      CGContextRotateCTM(context, -M_PI);
      break;
    case IMAGE_ROTATE_ANGLE_RIGHT:
      UIGraphicsBeginImageContext(CGSizeMake(img.size.height, img.size.width));
      context = UIGraphicsGetCurrentContext();
      CGContextScaleCTM(context, 1.0, -1.0);
      CGContextRotateCTM(context, -M_PI/2.0);
      break;
    default:
      NSLog(@"you can select an angle of 90, 180, 270");
      return nil;
  }
  
  CGContextDrawImage(context, CGRectMake(0, 0, img.size.width, img.size.height), imgRef);
  UIImage *ret = UIGraphicsGetImageFromCurrentImageContext();
  
  UIGraphicsEndImageContext();
  return ret;
}



- (CGSize)getResizeToWidth:(int)width height:(int)height
{
	CGSize reSize;
	float ex_scale;
  CGSize size = self.size;
	
	if ((size.width/width) > (size.height/height)) {
		ex_scale = width / size.width;
	}
	else {
		ex_scale = height / size.height;
	}
	
	reSize = CGSizeMake(ex_scale*width, ex_scale*height);
	return reSize;
	
}

- (UIImage*)_imageByCroppingToRect:(CGRect)rect
{
  CGImageRef imageRef = CGImageCreateWithImageInRect(
                                                     [self CGImage], rect);
  UIImage *cropped =[UIImage imageWithCGImage:imageRef];
  CGImageRelease(imageRef);
  
  return cropped;
}

// セピア効果
- (UIImage*)sepiaScale
{
  CGImageRef  imageRef;
  imageRef = self.CGImage;
	
  size_t width  = CGImageGetWidth(imageRef);
  size_t height = CGImageGetHeight(imageRef);
	
  // ピクセルを構成するRGB各要素が何ビットで構成されている
  size_t                  bitsPerComponent;
  bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
	
  // ピクセル全体は何ビットで構成されているか
  size_t                  bitsPerPixel;
  bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
	
  // 画像の横1ライン分のデータが、何バイトで構成されているか
  size_t                  bytesPerRow;
  bytesPerRow = CGImageGetBytesPerRow(imageRef);
	
  // 画像の色空間
  CGColorSpaceRef         colorSpace;
  colorSpace = CGImageGetColorSpace(imageRef);
	
  // 画像のBitmap情報
  CGBitmapInfo            bitmapInfo;
  bitmapInfo = CGImageGetBitmapInfo(imageRef);
	
  // 画像がピクセル間の補完をしているか
  bool                    shouldInterpolate;
  shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
	
	// 表示装置によって補正をしているか
  CGColorRenderingIntent  intent;
  intent = CGImageGetRenderingIntent(imageRef);
	
  // 画像のデータプロバイダを取得する
  CGDataProviderRef   dataProvider;
  dataProvider = CGImageGetDataProvider(imageRef);
	
  // データプロバイダから画像のbitmap生データ取得
  CFDataRef   data;
  UInt8*      buffer;
  data = CGDataProviderCopyData(dataProvider);
  buffer = (UInt8*)CFDataGetBytePtr(data);
	
  // 1ピクセルずつ画像を処理
  NSUInteger  x, y;
  for (y = 0; y < height; y++) {
    for (x = 0; x < width; x++) {
      UInt8*  tmp;
      tmp = buffer + y * bytesPerRow + x * 4; // RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす
			
      // RGB値を取得
      UInt8 red,green,blue;
      red = *(tmp + 0);
      green = *(tmp + 1);
      blue = *(tmp + 2);
			
			// 輝度計算
      UInt8 brightness;
      brightness = (77 * red + 28 * green + 151 * blue) / 256;
			
      *(tmp + 0) = brightness;
      *(tmp + 1) = brightness * 0.7;
      *(tmp + 2) = brightness * 0.4;
    }
  }
	
  // 効果を与えたデータ生成
  CFDataRef   effectedData;
  effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
	
  // 効果を与えたデータプロバイダを生成
  CGDataProviderRef   effectedDataProvider;
  effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
	
  // 画像を生成
  CGImageRef  effectedCgImage;
  UIImage*    effectedImage;
  effectedCgImage = CGImageCreate(
                                  width, height,
                                  bitsPerComponent, bitsPerPixel, bytesPerRow,
                                  colorSpace, bitmapInfo, effectedDataProvider,
                                  NULL, shouldInterpolate, intent);
  effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
	
  // データの解放
  CGImageRelease(effectedCgImage);
  CFRelease(effectedDataProvider);
  CFRelease(effectedData);
  CFRelease(data);
	
  return effectedImage;
}

// 白黒効果
- (UIImage*)grayScale
{
  CGImageRef  imageRef;
  imageRef = self.CGImage;
	
  size_t width  = CGImageGetWidth(imageRef);
  size_t height = CGImageGetHeight(imageRef);
	
  // ピクセルを構成するRGB各要素が何ビットで構成されている
  size_t                  bitsPerComponent;
  bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
	
  // ピクセル全体は何ビットで構成されているか
  size_t                  bitsPerPixel;
  bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
	
  // 画像の横1ライン分のデータが、何バイトで構成されているか
  size_t                  bytesPerRow;
  bytesPerRow = CGImageGetBytesPerRow(imageRef);
	
  // 画像の色空間
  CGColorSpaceRef         colorSpace;
  colorSpace = CGImageGetColorSpace(imageRef);
	
  // 画像のBitmap情報
  CGBitmapInfo            bitmapInfo;
  bitmapInfo = CGImageGetBitmapInfo(imageRef);
	
  // 画像がピクセル間の補完をしているか
  bool                    shouldInterpolate;
  shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
	
	// 表示装置によって補正をしているか
  CGColorRenderingIntent  intent;
  intent = CGImageGetRenderingIntent(imageRef);
	
  // 画像のデータプロバイダを取得する
  CGDataProviderRef   dataProvider;
  dataProvider = CGImageGetDataProvider(imageRef);
	
  // データプロバイダから画像のbitmap生データ取得
  CFDataRef   data;
  UInt8*      buffer;
  data = CGDataProviderCopyData(dataProvider);
  buffer = (UInt8*)CFDataGetBytePtr(data);
	
  // 1ピクセルずつ画像を処理
  NSUInteger  x, y;
  for (y = 0; y < height; y++) {
    for (x = 0; x < width; x++) {
      UInt8*  tmp;
      tmp = buffer + y * bytesPerRow + x * 4; // RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす
			
      // RGB値を取得
      UInt8 red,green,blue;
      red = *(tmp + 0);
      green = *(tmp + 1);
      blue = *(tmp + 2);
			
			// 輝度計算
      UInt8 brightness;
      brightness = (77 * red + 28 * green + 151 * blue) / 256;
			
      *(tmp + 0) = brightness;
      *(tmp + 1) = brightness;
      *(tmp + 2) = brightness;
    }
  }
	
  // 効果を与えたデータ生成
  CFDataRef   effectedData;
  effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
	
  // 効果を与えたデータプロバイダを生成
  CGDataProviderRef   effectedDataProvider;
  effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
	
  // 画像を生成
  CGImageRef  effectedCgImage;
  UIImage*    effectedImage;
  effectedCgImage = CGImageCreate(
                                  width, height,
                                  bitsPerComponent, bitsPerPixel, bytesPerRow,
                                  colorSpace, bitmapInfo, effectedDataProvider,
                                  NULL, shouldInterpolate, intent);
  effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
	
  // データの解放
  CGImageRelease(effectedCgImage);
  CFRelease(effectedDataProvider);
  CFRelease(effectedData);
  CFRelease(data);
	
  return effectedImage;
}

// 反転効果
- (UIImage*)negativeScale
{
  CGImageRef  imageRef;
  imageRef = self.CGImage;
	
  size_t width  = CGImageGetWidth(imageRef);
  size_t height = CGImageGetHeight(imageRef);
	
  // ピクセルを構成するRGB各要素が何ビットで構成されている
  size_t                  bitsPerComponent;
  bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
	
  // ピクセル全体は何ビットで構成されているか
  size_t                  bitsPerPixel;
  bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
	
  // 画像の横1ライン分のデータが、何バイトで構成されているか
  size_t                  bytesPerRow;
  bytesPerRow = CGImageGetBytesPerRow(imageRef);
	
  // 画像の色空間
  CGColorSpaceRef         colorSpace;
  colorSpace = CGImageGetColorSpace(imageRef);
	
  // 画像のBitmap情報
  CGBitmapInfo            bitmapInfo;
  bitmapInfo = CGImageGetBitmapInfo(imageRef);
	
  // 画像がピクセル間の補完をしているか
  bool                    shouldInterpolate;
  shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
	
	// 表示装置によって補正をしているか
  CGColorRenderingIntent  intent;
  intent = CGImageGetRenderingIntent(imageRef);
	
  // 画像のデータプロバイダを取得する
  CGDataProviderRef   dataProvider;
  dataProvider = CGImageGetDataProvider(imageRef);
	
  // データプロバイダから画像のbitmap生データ取得
  CFDataRef   data;
  UInt8*      buffer;
  data = CGDataProviderCopyData(dataProvider);
  buffer = (UInt8*)CFDataGetBytePtr(data);
	
  // 1ピクセルずつ画像を処理
  NSUInteger  x, y;
  for (y = 0; y < height; y++) {
    for (x = 0; x < width; x++) {
      UInt8*  tmp;
      tmp = buffer + y * bytesPerRow + x * 4; // RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす
			
      // RGB値を取得
      UInt8 red,green,blue;
      red = *(tmp + 0);
      green = *(tmp + 1);
      blue = *(tmp + 2);
			
			// 反転
      if (red > 255) {
        red = 0;
      }
      else {
        red = 255 - red;
      }
      if (green > 255) {
        green = 0;
      }
      else {
        green = 255 - green;
      }
      if (blue > 255) {
        blue = 0;
      }
      else {
        blue = 255 - blue;
      }
			
      *(tmp + 0) = red;
      *(tmp + 1) = green;
      *(tmp + 2) = blue;
    }
  }
	
  // 効果を与えたデータ生成
  CFDataRef   effectedData;
  effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
	
  // 効果を与えたデータプロバイダを生成
  CGDataProviderRef   effectedDataProvider;
  effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
	
  // 画像を生成
  CGImageRef  effectedCgImage;
  UIImage*    effectedImage;
  effectedCgImage = CGImageCreate(
                                  width, height,
                                  bitsPerComponent, bitsPerPixel, bytesPerRow,
                                  colorSpace, bitmapInfo, effectedDataProvider,
                                  NULL, shouldInterpolate, intent);
  effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
	
  // データの解放
  CGImageRelease(effectedCgImage);
  CFRelease(effectedDataProvider);
  CFRelease(effectedData);
  CFRelease(data);
	
  return effectedImage;
}

// ガンマ補正
- (UIImage*)setGanma:(float)ganma
{
  CGImageRef  imageRef;
  imageRef = self.CGImage;
	
  size_t width  = CGImageGetWidth(imageRef);
  size_t height = CGImageGetHeight(imageRef);
	
  // ピクセルを構成するRGB各要素が何ビットで構成されている
  size_t                  bitsPerComponent;
  bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
	
  // ピクセル全体は何ビットで構成されているか
  size_t                  bitsPerPixel;
  bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
	
  // 画像の横1ライン分のデータが、何バイトで構成されているか
  size_t                  bytesPerRow;
  bytesPerRow = CGImageGetBytesPerRow(imageRef);
	
  // 画像の色空間
  CGColorSpaceRef         colorSpace;
  colorSpace = CGImageGetColorSpace(imageRef);
	
  // 画像のBitmap情報
  CGBitmapInfo            bitmapInfo;
  bitmapInfo = CGImageGetBitmapInfo(imageRef);
	
  // 画像がピクセル間の補完をしているか
  bool                    shouldInterpolate;
  shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
	
	// 表示装置によって補正をしているか
  CGColorRenderingIntent  intent;
  intent = CGImageGetRenderingIntent(imageRef);
	
  // 画像のデータプロバイダを取得する
  CGDataProviderRef   dataProvider;
  dataProvider = CGImageGetDataProvider(imageRef);
	
  // データプロバイダから画像のbitmap生データ取得
  CFDataRef   data;
  UInt8*      buffer;
  data = CGDataProviderCopyData(dataProvider);
  buffer = (UInt8*)CFDataGetBytePtr(data);
	
  // 1ピクセルずつ画像を処理
  NSUInteger  x, y;
  for (y = 0; y < height; y++) {
    for (x = 0; x < width; x++) {
      UInt8*  tmp;
      tmp = buffer + y * bytesPerRow + x * 4; // RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす
			
      // RGB値を取得
      UInt8 red,green,blue;
      red = *(tmp + 0);
      green = *(tmp + 1);
      blue = *(tmp + 2);
			
			// ガンマ
      red = 255.0f * powf(red/255.0f, 1.0f/ganma);
      green = 255.0f * powf(green/255.0f, 1.0f/ganma);
      blue = 255.0f * powf(blue/255.0f, 1.0f/ganma);
			
      *(tmp + 0) = red;
      *(tmp + 1) = green;
      *(tmp + 2) = blue;
    }
  }
	
  // 効果を与えたデータ生成
  CFDataRef   effectedData;
  effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
	
  // 効果を与えたデータプロバイダを生成
  CGDataProviderRef   effectedDataProvider;
  effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
	
  // 画像を生成
  CGImageRef  effectedCgImage;
  UIImage*    effectedImage;
  effectedCgImage = CGImageCreate(
                                  width, height,
                                  bitsPerComponent, bitsPerPixel, bytesPerRow,
                                  colorSpace, bitmapInfo, effectedDataProvider,
                                  NULL, shouldInterpolate, intent);
  effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
	
  // データの解放
  CGImageRelease(effectedCgImage);
  CFRelease(effectedDataProvider);
  CFRelease(effectedData);
  CFRelease(data);
	
  return effectedImage;
}

// 深度
- (UIImage*)setV:(float)_v
{
  CGImageRef  imageRef;
  imageRef = self.CGImage;
	
  size_t width  = CGImageGetWidth(imageRef);
  size_t height = CGImageGetHeight(imageRef);
	
  // ピクセルを構成するRGB各要素が何ビットで構成されている
  size_t                  bitsPerComponent;
  bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
	
  // ピクセル全体は何ビットで構成されているか
  size_t                  bitsPerPixel;
  bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
	
  // 画像の横1ライン分のデータが、何バイトで構成されているか
  size_t                  bytesPerRow;
  bytesPerRow = CGImageGetBytesPerRow(imageRef);
	
  // 画像の色空間
  CGColorSpaceRef         colorSpace;
  colorSpace = CGImageGetColorSpace(imageRef);
	
  // 画像のBitmap情報
  CGBitmapInfo            bitmapInfo;
  bitmapInfo = CGImageGetBitmapInfo(imageRef);
	
  // 画像がピクセル間の補完をしているか
  bool                    shouldInterpolate;
  shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
	
	// 表示装置によって補正をしているか
  CGColorRenderingIntent  intent;
  intent = CGImageGetRenderingIntent(imageRef);
	
  // 画像のデータプロバイダを取得する
  CGDataProviderRef   dataProvider;
  dataProvider = CGImageGetDataProvider(imageRef);
	
  // データプロバイダから画像のbitmap生データ取得
  CFDataRef   data;
  UInt8*      buffer;
  data = CGDataProviderCopyData(dataProvider);
  buffer = (UInt8*)CFDataGetBytePtr(data);
	
  // 1ピクセルずつ画像を処理
  NSUInteger  x, y;
  for (y = 0; y < height; y++) {
    for (x = 0; x < width; x++) {
      UInt8*  tmp;
      tmp = buffer + y * bytesPerRow + x * 4; // RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす
			
      // RGB値を取得
      UInt8 red,green,blue;
      red = *(tmp + 0);
      green = *(tmp + 1);
      blue = *(tmp + 2);
			
			float h,s,v,r,g,b;
      [UIImage _RGB2HSV:(float)red g:(float)green b:(float)blue h:&h s:&s v:&v];
      v = _v;
      [UIImage _HSV2RGB:h s:s v:v r:&r g:&g b:&b];
			
      *(tmp + 0) = r;
      *(tmp + 1) = g;
      *(tmp + 2) = b;
    }
  }
	
  // 効果を与えたデータ生成
  CFDataRef   effectedData;
  effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
	
  // 効果を与えたデータプロバイダを生成
  CGDataProviderRef   effectedDataProvider;
  effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
	
  // 画像を生成
  CGImageRef  effectedCgImage;
  UIImage*    effectedImage;
  effectedCgImage = CGImageCreate(
                                  width, height,
                                  bitsPerComponent, bitsPerPixel, bytesPerRow,
                                  colorSpace, bitmapInfo, effectedDataProvider,
                                  NULL, shouldInterpolate, intent);
  effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
	
  // データの解放
  CGImageRelease(effectedCgImage);
  CFRelease(effectedDataProvider);
  CFRelease(effectedData);
  CFRelease(data);
	
  return effectedImage;
}

// 明度
- (UIImage*)setS:(float)_s
{
  CGImageRef  imageRef;
  imageRef = self.CGImage;
	
  size_t width  = CGImageGetWidth(imageRef);
  size_t height = CGImageGetHeight(imageRef);
	
  // ピクセルを構成するRGB各要素が何ビットで構成されている
  size_t                  bitsPerComponent;
  bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
	
  // ピクセル全体は何ビットで構成されているか
  size_t                  bitsPerPixel;
  bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
	
  // 画像の横1ライン分のデータが、何バイトで構成されているか
  size_t                  bytesPerRow;
  bytesPerRow = CGImageGetBytesPerRow(imageRef);
	
  // 画像の色空間
  CGColorSpaceRef         colorSpace;
  colorSpace = CGImageGetColorSpace(imageRef);
	
  // 画像のBitmap情報
  CGBitmapInfo            bitmapInfo;
  bitmapInfo = CGImageGetBitmapInfo(imageRef);
	
  // 画像がピクセル間の補完をしているか
  bool                    shouldInterpolate;
  shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
	
	// 表示装置によって補正をしているか
  CGColorRenderingIntent  intent;
  intent = CGImageGetRenderingIntent(imageRef);
	
  // 画像のデータプロバイダを取得する
  CGDataProviderRef   dataProvider;
  dataProvider = CGImageGetDataProvider(imageRef);
	
  // データプロバイダから画像のbitmap生データ取得
  CFDataRef   data;
  UInt8*      buffer;
  data = CGDataProviderCopyData(dataProvider);
  buffer = (UInt8*)CFDataGetBytePtr(data);
	
  // 1ピクセルずつ画像を処理
  NSUInteger  x, y;
  for (y = 0; y < height; y++) {
    for (x = 0; x < width; x++) {
      UInt8*  tmp;
      tmp = buffer + y * bytesPerRow + x * 4; // RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす
			
      // RGB値を取得
      UInt8 red,green,blue;
      red = *(tmp + 0);
      green = *(tmp + 1);
      blue = *(tmp + 2);
			
			float h,s,v,r,g,b;
      [UIImage _RGB2HSV:(float)red g:(float)green b:(float)blue h:&h s:&s v:&v];
      s = _s;
      [UIImage _HSV2RGB:h s:s v:v r:&r g:&g b:&b];
			
      *(tmp + 0) = r;
      *(tmp + 1) = g;
      *(tmp + 2) = b;
    }
  }
	
  // 効果を与えたデータ生成
  CFDataRef   effectedData;
  effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
	
  // 効果を与えたデータプロバイダを生成
  CGDataProviderRef   effectedDataProvider;
  effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
	
  // 画像を生成
  CGImageRef  effectedCgImage;
  UIImage*    effectedImage;
  effectedCgImage = CGImageCreate(
                                  width, height,
                                  bitsPerComponent, bitsPerPixel, bytesPerRow,
                                  colorSpace, bitmapInfo, effectedDataProvider,
                                  NULL, shouldInterpolate, intent);
  effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
	
  // データの解放
  CGImageRelease(effectedCgImage);
  CFRelease(effectedDataProvider);
  CFRelease(effectedData);
  CFRelease(data);
	
  return effectedImage;
}

// 鏡面
- (UIImage*)mirrorHorizon:(BOOL)hori Vertical:(BOOL)vert
{
  CGImageRef  imageRef;
  imageRef = self.CGImage;
	
  size_t width  = CGImageGetWidth(imageRef);
  size_t height = CGImageGetHeight(imageRef);
	
  // ピクセルを構成するRGB各要素が何ビットで構成されている
  size_t                  bitsPerComponent;
  bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
	
  // ピクセル全体は何ビットで構成されているか
  size_t                  bitsPerPixel;
  bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
	
  // 画像の横1ライン分のデータが、何バイトで構成されているか
  size_t                  bytesPerRow;
  bytesPerRow = CGImageGetBytesPerRow(imageRef);
	
  // 画像の色空間
  CGColorSpaceRef         colorSpace;
  colorSpace = CGImageGetColorSpace(imageRef);
	
  // 画像のBitmap情報
  CGBitmapInfo            bitmapInfo;
  bitmapInfo = CGImageGetBitmapInfo(imageRef);
	
  // 画像がピクセル間の補完をしているか
  bool                    shouldInterpolate;
  shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
	
	// 表示装置によって補正をしているか
  CGColorRenderingIntent  intent;
  intent = CGImageGetRenderingIntent(imageRef);
	
  // 画像のデータプロバイダを取得する
  CGDataProviderRef   dataProvider;
  dataProvider = CGImageGetDataProvider(imageRef);
	
  // データプロバイダから画像のbitmap生データ取得
  CFDataRef   data;
  UInt8*      buffer;
  data = CGDataProviderCopyData(dataProvider);
  buffer = (UInt8*)CFDataGetBytePtr(data);
  
  CFDataRef   mirrorData;
  UInt8*      mirrorBuffer;
  mirrorData = CGDataProviderCopyData(dataProvider);
  mirrorBuffer = (UInt8*)CFDataGetBytePtr(mirrorData);
  
  size_t mWidth,mHeight;
	
  // 1ピクセルずつ画像を処理
  NSUInteger  x, y;
  for (y = 0; y < height; y++) {
    if (hori) {
      mHeight = height - y;
      if (mHeight == height) mHeight--;
    }
    else {
      mHeight = y;
    }
    for (x = 0; x < width; x++) {
      if (vert) {
        mWidth = width - x;
        if (mWidth == width) mWidth--;
      }
      else {
        mWidth = x;
      }
      
      UInt8* ret;
      ret = mirrorBuffer + mHeight * bytesPerRow + mWidth * 4;
      
      UInt8*  tmp;
      tmp = buffer + y * bytesPerRow + x * 4; // RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす
			
      // RGB値を取得
      UInt8 red,green,blue,alpha;
      red = *(tmp + 0);
      green = *(tmp + 1);
      blue = *(tmp + 2);
      alpha = *(tmp + 3);
			
			*(ret + 0) = red;
      *(ret + 1) = green;
      *(ret + 2) = blue;
      *(ret + 3) = alpha;
    }
  }
	
  // 効果を与えたデータ生成
  CFDataRef   effectedData;
  effectedData = CFDataCreate(NULL, mirrorBuffer, CFDataGetLength(mirrorData));
	
  // 効果を与えたデータプロバイダを生成
  CGDataProviderRef   effectedDataProvider;
  effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
	
  // 画像を生成
  CGImageRef  effectedCgImage;
  UIImage*    effectedImage;
  effectedCgImage = CGImageCreate(
                                  width, height,
                                  bitsPerComponent, bitsPerPixel, bytesPerRow,
                                  colorSpace, bitmapInfo, effectedDataProvider,
                                  NULL, shouldInterpolate, intent);
  effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
	
  // データの解放
  CGImageRelease(effectedCgImage);
  CFRelease(effectedDataProvider);
  CFRelease(effectedData);
  CFRelease(data);
  CFRelease(mirrorData);
	
  return effectedImage;
  
}

// フィルタ
- (UIImage*)filterType:(BmpFilterType)type mask:(BmpFilterMask)mask thresholdMin:(float)tMin ThresholdMax:(float)tMax include:(BOOL)inc
{
  CGImageRef  imageRef;
  imageRef = self.CGImage;
	
  size_t width  = CGImageGetWidth(imageRef);
  size_t height = CGImageGetHeight(imageRef);
	
  // ピクセルを構成するRGB各要素が何ビットで構成されている
  size_t                  bitsPerComponent;
  bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
	
  // ピクセル全体は何ビットで構成されているか
  size_t                  bitsPerPixel;
  bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
	
  // 画像の横1ライン分のデータが、何バイトで構成されているか
  size_t                  bytesPerRow;
  bytesPerRow = CGImageGetBytesPerRow(imageRef);
	
  // 画像の色空間
  CGColorSpaceRef         colorSpace;
  colorSpace = CGImageGetColorSpace(imageRef);
	
  // 画像のBitmap情報
  CGBitmapInfo            bitmapInfo;
  bitmapInfo = CGImageGetBitmapInfo(imageRef);
	
  // 画像がピクセル間の補完をしているか
  bool                    shouldInterpolate;
  shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
	
	// 表示装置によって補正をしているか
  CGColorRenderingIntent  intent;
  intent = CGImageGetRenderingIntent(imageRef);
	
  // 画像のデータプロバイダを取得する
  CGDataProviderRef   dataProvider;
  dataProvider = CGImageGetDataProvider(imageRef);
	
  // データプロバイダから画像のbitmap生データ取得
  CFDataRef   data;
  UInt8*      buffer;
  data = CGDataProviderCopyData(dataProvider);
  buffer = (UInt8*)CFDataGetBytePtr(data);
	
  // 1ピクセルずつ画像を処理
  NSUInteger  x, y;
  for (y = 0; y < height; y++) {
    for (x = 0; x < width; x++) {
      UInt8*  tmp;
      tmp = buffer + y * bytesPerRow + x * 4; // RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす
			
      // RGB値を取得
      float red,green,blue,alpha;
      red = *(tmp + 0);
      green = *(tmp + 1);
      blue = *(tmp + 2);
      alpha = *(tmp + 3);
      
      // フィルタ処理
      float *hsv;
      float hsvMax;
      float h,s,v,r,g,b;
      [UIImage _RGB2HSV:(float)red g:(float)green b:(float)blue h:&h s:&s v:&v];
      switch (type) {
        case BMP_FILTER_TYPE_HUE:
          hsv = &h;
          hsvMax = 360.0;
          break;
        case BMP_FILTER_TYPE_SATURATION:
          hsv = &s;
          hsvMax = 255.0;
          break;
        case BMP_FILTER_TYPE_VALUE:
          hsv = &v;
          hsvMax = 255.0;
          break;
        case BMP_FILTER_TYPE_RED:
          hsv = &red;
          hsvMax = 255.0;
          break;
        case BMP_FILTER_TYPE_GREEN:
          hsv = &green;
          hsvMax = 255.0;
          break;
        case BMP_FILTER_TYPE_BLUE:
          hsv = &blue;
          hsvMax = 255.0;
          break;
      }
      
      BOOL result = NO;
      // 判定方法
      if (inc) {
        if (tMin <= *hsv && *hsv <= tMax) result = YES;
        if (tMin == tMax) {
          if (*hsv == tMin) {
            result = YES;
          }
          else {
            result = NO;
          }
        }
      }
      else {
        if (*hsv < tMin || tMax < *hsv) result = YES;
        if (tMin == tMax) {
          if (*hsv == tMin) {
            result = NO;
          }
          else {
            result = YES;
          }
        }
      }
      
      // 処理方法
      if (result) {
        switch (mask) {
          case BMP_FILTER_MASK_ALPHAZERO:
            alpha = 0;
            break;
          case BMP_FILTER_MASK_VALUEZERO:
            *hsv = 0;
            break;
          case BMP_FILTER_MASK_VALUEMAX:
            *hsv = hsvMax;
            break;
          case BMP_FILTER_MASK_BLACK:
            red = 0;
            green = 0;
            blue = 0;
            break;
          case BMP_FILTER_MASK_WHITE:
            red = 255.0;
            green = 255.0;
            blue = 255.0;
            break;
          case BMP_FILTER_MASK_GRAYSCALE:
          {
            float brightness;
            brightness = (77 * red + 28 * green + 151 * blue) / 256;
            red = brightness;
            green = brightness;
            blue = brightness;
            break;
          }
        }
      }
			
      // 再セット
      switch (mask) {
        case BMP_FILTER_MASK_ALPHAZERO:
        case BMP_FILTER_MASK_BLACK:
        case BMP_FILTER_MASK_WHITE:
        case BMP_FILTER_MASK_GRAYSCALE:
        {
          r = red;
          g = green;
          b = blue;
          break;
        }
        case BMP_FILTER_MASK_VALUEZERO:
        case BMP_FILTER_MASK_VALUEMAX:
        {
          [UIImage _HSV2RGB:h s:s v:v r:&r g:&g b:&b];
          break;
        }
      }
      
      *(tmp + 0) = r;
      *(tmp + 1) = g;
      *(tmp + 2) = b;
      *(tmp + 3) = alpha;
    }
  }
	
  // 効果を与えたデータ生成
  CFDataRef   effectedData;
  effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
	
  // 効果を与えたデータプロバイダを生成
  CGDataProviderRef   effectedDataProvider;
  effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
	
  // 画像を生成
  CGImageRef  effectedCgImage;
  UIImage*    effectedImage;
  effectedCgImage = CGImageCreate(
                                  width, height,
                                  bitsPerComponent, bitsPerPixel, bytesPerRow,
                                  colorSpace, bitmapInfo, effectedDataProvider,
                                  NULL, shouldInterpolate, intent);
  effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
	
  // データの解放
  CGImageRelease(effectedCgImage);
  CFRelease(effectedDataProvider);
  CFRelease(effectedData);
  CFRelease(data);
	
  return effectedImage;
}

// HSV to RGB
+ (void)_HSV2RGB:(float)h s:(float)s v:(float)v r:(float*)r g:(float*)g b:(float*)b
{
  int i;
	float f, p, q, t;
	if( s == 0 ) {
		// achromatic (grey)
		*r = *g = *b = v;
		return;
	}
	h /= 60;			// sector 0 to 5
	i = floor( h );
	f = h - i;			// factorial part of h
	p = v * ( 1 - s );
	q = v * ( 1 - s * f );
	t = v * ( 1 - s * ( 1 - f ) );
	switch( i ) {
		case 0:
			*r = v;
			*g = t;
			*b = p;
			break;
		case 1:
			*r = q;
			*g = v;
			*b = p;
			break;
		case 2:
			*r = p;
			*g = v;
			*b = t;
			break;
		case 3:
			*r = p;
			*g = q;
			*b = v;
			break;
		case 4:
			*r = t;
			*g = p;
			*b = v;
			break;
		default:		// case 5:
			*r = v;
			*g = p;
			*b = q;
			break;
	}
}

// RGB to HSV
+ (void)_RGB2HSV:(float)r g:(float)g b:(float)b h:(float*)h s:(float*)s v:(float*)v
{
  float min, max, delta;
  min = MIN( r, MIN( g, b ));
  max = MAX( r, MAX( g, b ));
  *v = max;               // v
  delta = max - min;
  if( max != 0 )
    *s = delta / max;       // s
  else {
    // r = g = b = 0        // s = 0, v is undefined
    *s = 0;
    *h = -1;
    return;
  }
  if( r == max )
    *h = ( g - b ) / delta;     // between yellow & magenta
  else if( g == max )
    *h = 2 + (( b - r ) / delta); // between cyan & yellow
  else
    *h = 4 + (( r - g ) / delta); // between magenta & cyan
  *h *= 60;               // degrees
  if( *h < 0 )
    *h += 360;
}

+ (UIImage *)changeUIImageColor:(UIImage *)image h:(double)H s:(double)S v:(double)V {
  
	// pixel値の抽出
	CGImageRef cgImage = [image CGImage];
	size_t bytesPerRow = CGImageGetBytesPerRow(cgImage);
	CGDataProviderRef dataProvider = CGImageGetDataProvider(cgImage);
	CFDataRef data = CGDataProviderCopyData(dataProvider);
	UInt8* pixels = (UInt8*)CFDataGetBytePtr(data);
	
	// 画像処理）
	for (int y = 0 ; y < image.size.height; y++){
		for (int x = 0; x < image.size.width; x++){
			UInt8* buf = pixels + y * bytesPerRow + x * 4;
			UInt8 r, g, b, a;
			r = *(buf + 0);
			g = *(buf + 1);
			b = *(buf + 2);
			a = *(buf + 3);
			
			double dr = r / 255.0;
      double dg = g / 255.0;
      double db = b / 255.0;
			
			// rgbからhsvに
			double h,s,v;
			double z;
      
			// max_color
			if( dr > dg ){
				if( dr > db )
					v = dr;
				else
					v = db;
			}
			else{
				if( dg > db )
					v = dg;
				else
					v = db;
			}
			
			// min_color
			if( dr > dg ){
				if( dr > db )
					z = dr;
				else
					z = db;
			}
			else{
				if( dg < db )
					z = dg;
				else
					z = db;
			}
			
			
			// hsvの値を取得
			if( v != 0.0 )
				s = ( v - z ) / v;
			else
				s = 0.0;
			if( ( v - z ) != 0 ){
				dr = ( v - dr ) / ( v - z );
				dg = ( v - dg ) / ( v - z );
				db = ( v - db ) / ( v - z );
			}
			else{
				dr = 0;
				dg = 0;
				db = 0;
			}
			if( v == dr )
				h = 60 * ( db - dg );
			else if( v == dg )
				h = 60 * ( 2 + dr - db );
			else
				h = 60 * ( 4 + dg - dr );
			if( h < 0.0 )
				h = h + 360;
			
			//強制的にhsvを指定してみる
			h = H;
			s = S;
			v = ( pow(v, 3) +v + V*3 ) / 5 ;
      
			//rgbに再変換
      int inn = (int)floor( h  / 60 );
      
      if(inn < 0)
        inn *= -1;
      
      double fl = ( h  / 60 ) - inn;
			
      double p = v * ( 1 - s );
      double q = v * ( 1 - s  * fl );
      double t = v * (1 - (1 - fl) * s);
			
			////計算結果のR,G,Bは0.0～1.0なので255倍
      v = v * 255;
      p = p * 255;
      q = q * 255;
      t = t * 255;
			
			double newR,newG,newB;
			
			switch( inn )
      {
        case 0: newR = v; newG = t; newB = p; break;
        case 1: newR = q; newG = v; newB = p; break;
        case 2: newR = p; newG = v; newB = q; break;
        case 3: newR = p; newG = q; newB = v ; break;
        case 4: newR = t; newG = p; newB = v ; break;
        case 5: newR = v; newG = p; newB = q; break;
      }
			
			if (a > 50) {
				*(buf + 0) = (newR*2 + r*S) / (2+S);
				*(buf + 1) = (newG*2 + g*S) / (2+S);
				*(buf + 2) = (newB*2 + b*S) / (2+S);
			}
			
		}
	}
	
	// pixel値からUIImageの再合成
	CFDataRef resultData = CFDataCreate(NULL, pixels, CFDataGetLength(data));
	CGDataProviderRef resultDataProvider = CGDataProviderCreateWithCFData(resultData);
	CGImageRef resultCgImage = CGImageCreate(
                                           CGImageGetWidth(cgImage), CGImageGetHeight(cgImage),
                                           CGImageGetBitsPerComponent(cgImage), CGImageGetBitsPerPixel(cgImage), bytesPerRow,
                                           CGImageGetColorSpace(cgImage), CGImageGetBitmapInfo(cgImage), resultDataProvider,
                                           NULL, CGImageGetShouldInterpolate(cgImage), CGImageGetRenderingIntent(cgImage));
	UIImage* ret_image = [[UIImage alloc] initWithCGImage:resultCgImage];
	
	// 後処理
	CGImageRelease(resultCgImage);
	CFRelease(resultDataProvider);
	CFRelease(resultData);
	CFRelease(data);
	
	return ret_image;
}

+(UIImage*)_changeUIImageColor2:(UIImage *)image h:(double)H s:(double)S v:(double)V
{
	CGImageRef  imageRef;
  imageRef = image.CGImage;
	
  size_t width  = CGImageGetWidth(imageRef);
  size_t height = CGImageGetHeight(imageRef);
	
  // ピクセルを構成するRGB各要素が何ビットで構成されている
  size_t                  bitsPerComponent;
  bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
	
  // ピクセル全体は何ビットで構成されているか
  size_t                  bitsPerPixel;
  bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
	
  // 画像の横1ライン分のデータが、何バイトで構成されているか
  size_t                  bytesPerRow;
  bytesPerRow = CGImageGetBytesPerRow(imageRef);
	
  // 画像の色空間
  CGColorSpaceRef         colorSpace;
  colorSpace = CGImageGetColorSpace(imageRef);
	
  // 画像のBitmap情報
  CGBitmapInfo            bitmapInfo;
  bitmapInfo = CGImageGetBitmapInfo(imageRef);
	
  // 画像がピクセル間の補完をしているか
  bool                    shouldInterpolate;
  shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
	
	// 表示装置によって補正をしているか
  CGColorRenderingIntent  intent;
  intent = CGImageGetRenderingIntent(imageRef);
	
  // 画像のデータプロバイダを取得する
  CGDataProviderRef   dataProvider;
  dataProvider = CGImageGetDataProvider(imageRef);
	
  // データプロバイダから画像のbitmap生データ取得
  CFDataRef   data;
  UInt8*      buffer;
  data = CGDataProviderCopyData(dataProvider);
  buffer = (UInt8*)CFDataGetBytePtr(data);
	
  // 1ピクセルずつ画像を処理
  NSUInteger  x, y;
  for (y = 0; y < height; y++) {
    for (x = 0; x < width; x++) {
      UInt8*  tmp;
      tmp = buffer + y * bytesPerRow + x * 4; // RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす
			
      // RGB値を取得
      UInt8 red,green,blue;
			float r,g,b;
			float h,s,v;
      red = *(tmp + 0);
      green = *(tmp + 1);
      blue = *(tmp + 2);
			
			r = red/255.0f;
			g = green/255.0f;
			b = blue/255.0f;
			
			// HSVに変換
      [self _RGB2HSV:r g:g b:b h:&h s:&s v:&v];
			
			h = H;
			s = S;
			v = ( pow(v, 3) +v + V*3 ) / 5 ;
			
			float newR,newG,newB;
      [self _HSV2RGB:h s:s v:v r:&newR g:&newG b:&newB];
      
			*(tmp + 0) = newR;
			*(tmp + 1) = newG;
			*(tmp + 2) = newB;
			
		}
  }
	
  // 効果を与えたデータ生成
  CFDataRef   effectedData;
  effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
	
  // 効果を与えたデータプロバイダを生成
  CGDataProviderRef   effectedDataProvider;
  effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
	
  // 画像を生成
  CGImageRef  effectedCgImage;
  UIImage*    effectedImage;
  effectedCgImage = CGImageCreate(
                                  width, height,
                                  bitsPerComponent, bitsPerPixel, bytesPerRow,
                                  colorSpace, bitmapInfo, effectedDataProvider,
                                  NULL, shouldInterpolate, intent);
  effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
	
  // データの解放
  CGImageRelease(effectedCgImage);
  CFRelease(effectedDataProvider);
  CFRelease(effectedData);
  CFRelease(data);
	
  return effectedImage;
}


@end
