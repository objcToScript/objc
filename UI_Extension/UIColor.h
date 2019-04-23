
#import <UIKit/UIKit.h>

@interface UIColor (ex)

+ (UIColor*)red:(float)red green:(float)green blue:(float)blue alpha:(float)alpha;

+ (UIColor*)_getUIColorFromHex:(NSString*)colorCode;

#pragma mark hexをUIColorにする
+ (UIColor*)_getUIColorFromHex:(NSString*)colorCode alpha:(CGFloat)alpha;

+ (UIColor*)_getUIColorFromHexWithAlpha:(NSString*)colorCode alpha:(CGFloat)alpha;

#pragma mark rgbをUIColorにする
+ (UIColor*)_getUIColorFromRGB:(NSString*)colorCode;

@end
