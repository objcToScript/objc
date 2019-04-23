
#import "UITabBar.h"

@implementation UITabBar (ex)

@dynamic barColor;
@dynamic selectIconColor;
@dynamic selectTextColor;
@dynamic unSelectTextColor;

- (void)setBarColor:(UIColor*)color
{

    self.barTintColor = color;
}

- (void)setSelectIconColor:(UIColor*)color
{

    self.tintColor = color;
}

// 選択時のカラー（テキスト）
- (void)setSelectTextColor:(UIColor*)color
{
    NSDictionary* attributesSelected = @{NSForegroundColorAttributeName : color};
    [[UITabBarItem appearance] setTitleTextAttributes:attributesSelected forState:UIControlStateSelected];
}

//選択
- (void)setUnSelectTextColor:(UIColor*)color
{
    NSDictionary* attributes = @{NSForegroundColorAttributeName : color};
    [[UITabBarItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

@end
