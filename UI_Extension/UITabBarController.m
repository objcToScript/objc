
#import "UITabBarController.h"

@implementation UITabBarController (ex)

- (UIViewController*)_getViewCon_restorationIdentifier:(NSString*)restorationIdentifier
{

    for (UIViewController* viewCon in self.viewControllers) {
        if ([viewCon.restorationIdentifier isEqual:restorationIdentifier]) {
            return viewCon;
        }
    }

    return nil;
}

- (void)_setSelectIndex:(int)index
{

    if (index < [self.viewControllers count]) {
        self.selectedIndex = index;
    } else {
        self.selectedIndex = 0;
    }
}

- (int)_getSelectIndex
{
    return (int)self.selectedIndex;
}

- (UIViewController*)_getSelectViewCon
{
    return self.selectedViewController;
}

- (UIViewController*)_getViewCon:(int)index
{

    if (index >= [self.viewControllers count]) {
        return nil;
    }
    return [self.viewControllers objectAtIndex:index];
}

// hide on bar push にチェックを入れること
- (void)_hideTabBar
{
    [self.tabBar setHidden:YES];
}

- (void)_showTabBar
{
    [self.tabBar setHidden:NO];
}

@end
