
#import "UIImage.h"
#import "UINavigationBar.h"
#import "clsNSString.h"

@implementation UINavigationBar (ex)

@dynamic backImage;
@dynamic barColor;
@dynamic titleColor;
@dynamic barTitleColor;
@dynamic backBtnImage;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)_setToumei
{
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.shadowImage = [UIImage new];
}

- (void)_setBarTitleColor:(NSString*)colorCode
{
    self.barTitleColor = [colorCode _getUIColorFromHex];
}

- (void)_setBarColor:(NSString*)colorCode
{
    self.barColor = [colorCode _getUIColorFromHex];
}

- (void)_setBarColor_uiColor:(UIColor*)uiColor
{
    [[UINavigationBar appearance] setBarTintColor:uiColor];
}

- (void)_setBackImage:(NSString*)imageName
{

    if (imageName == nil || [imageName isEqual:@""]) {
        UIImage* defaultImage = [self backgroundImageForBarMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:defaultImage forBarMetrics:UIBarMetricsDefault];
    } else {

        UIImage* backImage = [[UIImage imageNamed:imageName]
            resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)
                           resizingMode:UIImageResizingModeStretch];

        //2つあったほうがよい
        [[UINavigationBar appearance] setBackgroundImage:backImage forBarMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:backImage forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)_setBackBtnImage:(NSString*)imageName
{
    self.backBtnImage = [UIImage imageNamed:imageName];
}

- (void)_setTitleColor:(NSString*)colorCode
{
    self.titleColor = [colorCode _getUIColorFromHex];
}

- (void)setBarTitleColor:(UIColor*)colorCode
{
    [[UINavigationBar appearance] setTintColor:colorCode];
}

- (void)setBarColor:(UIColor*)colorCode
{
    [[UINavigationBar appearance] setBarTintColor:colorCode];
}

- (void)setBackImage:(UIImage*)imageObj
{
    [[UINavigationBar appearance] setBackgroundImage:imageObj forBarMetrics:UIBarMetricsDefault];
}

- (void)setBackBtnImage:(UIImage*)image
{
    [[UINavigationBar appearance] setBackIndicatorImage:image];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:image];
}

- (void)setTitleColor:(UIColor*)colorCode
{

    [[UINavigationBar appearance] setTitleTextAttributes:

                                      [NSDictionary dictionaryWithObjectsAndKeys:

                                                        colorCode, // タイトルの文字色

                                                        UITextAttributeTextColor, nil, // シャドウの色

                                                        UITextAttributeTextShadowColor, nil, // シャドウの強さ&amp;向き(x, y)

                                                        UITextAttributeTextShadowOffset, nil,

                                                        UITextAttributeFont, nil]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
