
#import <UIKit/UIKit.h>

@interface UINavigationController (ex)

- (void)_back;

- (void)_back:(int)gamenNum;

- (void)_back:(int)gamenNum func:(void (^)(UIViewController*))func;

- (UIViewController*)_getRootViewController;

- (UIViewController*)_getViewConNum:(int)gamenNum;

- (NSInteger)_getNowViewConNum;

- (UIViewController*)_getNowViewCon;

- (void)_hideBar;

- (void)_showBar;

- (CGFloat)_getHeight;

- (CGFloat)_getWidth;

@end
