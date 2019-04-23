
#import <UIKit/UIKit.h>

@interface UISearchBar (ex)

- (UITextField*)_getTextFiled;

- (void)_backColor:(NSString*)imageName;

- (UITextField*)_findTextFieldOfSearchBar:(UIView*)searchBar;

- (void)_setTextFiledColor:(UIColor*)backGroundColor textColor:(UIColor*)textColor;

@end
