
#import "UISearchBar.h"
#import "clsNSString.h"

@implementation UISearchBar (ex)

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)_backColor:(NSString*)imageName
{

    [self setTintColor:[imageName _getUIColorFromHex]];
}

- (UITextField*)_getTextFiled
{

    for (UIView* subView in self.subviews) {
        for (UITextField* textFiled in subView.subviews) {

            if ([textFiled isKindOfClass:[UITextField class]]) {
                return textFiled;
                break;
            }
        }
    }
    return nil;
}

- (UITextField*)_findTextFieldOfSearchBar:(UIView*)searchBar
{
    for (UIView* view in searchBar.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            return (UITextField*)view;
        } else {
            UITextField* textField = [self _findTextFieldOfSearchBar:view];
            if (textField) {
                return textField;
            }
        }
    }
    return nil;
}

- (void)_setTextFiledColor:(UIColor*)backGroundColor textColor:(UIColor*)textColor
{
    for (UIView* subView in self.subviews) {
        for (UIView* secondSubview in subView.subviews) {
            if ([secondSubview isKindOfClass:[UITextField class]]) {
                UITextField* searchBarTextField = (UITextField*)secondSubview;
                if (backGroundColor != nil) {
                    searchBarTextField.backgroundColor = backGroundColor;
                }
                if (textColor != nil) {
                    searchBarTextField.textColor = textColor;
                }

                return;
            }
        }
    }
}

@end
