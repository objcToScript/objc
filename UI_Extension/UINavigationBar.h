
#import <UIKit/UIKit.h>

//IB_DESIGNABLE
@interface UINavigationBar (ex)

@property (strong, nonatomic) IBInspectable UIImage* backImage;

@property (strong, nonatomic) IBInspectable UIColor* barColor;

@property (strong, nonatomic) IBInspectable UIColor* titleColor;

@property (strong, nonatomic) IBInspectable UIColor* barTitleColor;

@property (strong, nonatomic) IBInspectable UIImage* backBtnImage;

- (void)_setBarColor_uiColor:(UIColor*)uiColor;

- (void)_setBarTitleColor:(NSString*)colorCode;

- (void)_setBarColor:(NSString*)colorCode;

- (void)_setBackImage:(NSString*)imageName;

- (void)_setBackBtnImage:(NSString*)imageName;

- (void)_setTitleColor:(NSString*)colorCode;

- (void)_setToumei;

@end
