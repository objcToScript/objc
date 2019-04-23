
#import "clsNSString.h"

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>

@interface NSString (iOS)

- (UIColor*)_getUIColorFromHex;
- (UIColor*)_getUIColorFromHexWithAlpha:(CGFloat)alpha;
- (UIColor*)_getUIColorFromHex:(CGFloat)alpha;
- (UIColor*)_getUIColorFromRGB;

@end

#endif
