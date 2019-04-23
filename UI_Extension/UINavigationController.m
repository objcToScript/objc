
#import "UINavigationController.h"

@implementation UINavigationController (ex)

- (NSInteger)_getNowViewConNum
{

    NSInteger count = self.viewControllers.count - 1;

    return count;
}

- (UIViewController*)_getNowViewCon
{

    NSInteger count = self.viewControllers.count - 1;

    if ([self.viewControllers _safeObjecAtIndex_Bool:count]) {
        UIViewController* vc = [self.viewControllers objectAtIndex:count];
        return vc;
    }

    return nil;
}

- (UIViewController*)_getViewConNum:(int)gamenNum
{

    NSInteger count = self.viewControllers.count - gamenNum;

    if ([self.viewControllers _safeObjecAtIndex_Bool:count]) {
        UIViewController* vc = [self.viewControllers objectAtIndex:count];
        return vc;
    }

    return nil;
}

- (UIViewController*)_getRootViewController
{
    if (self.viewControllers.count > 0) {
        return [self.viewControllers objectAtIndex:0];
    }
    return nil;
}

/*
 -(void)viewWillAppear:(BOOL)animated{
 ナビゲーションバー表示
 }
 
 -(void)viewWillDisappear:(BOOL)animated{
 ナビゲーションバー非表示
 }
 
 */
- (void)_hideBar
{
    [self setNavigationBarHidden:YES];
}

- (void)_showBar
{
    [self setNavigationBarHidden:NO];
}

- (void)_back
{

    [self popViewControllerAnimated:YES];
}

- (void)_back:(int)gamenNum func:(void (^)(UIViewController*))func
{

    NSInteger count = self.viewControllers.count - gamenNum;

    if ([self.viewControllers _safeObjecAtIndex_Bool:count]) {
        __block UIViewController* vc = [self.viewControllers objectAtIndex:count];

        if (vc != nil) {

            [self popToViewController:vc
                             animated:YES
                         onCompletion:^{
                             func(vc);
                             return;
                         }];
        } else {
            func(nil);
        }
    } else {

        NSLog(@"エラーnavi　array  範囲外 ");
        func(nil);
    }
}

- (void)_back:(int)gamenNum
{

    NSInteger count = self.viewControllers.count - gamenNum;

    if ([self.viewControllers _safeObjecAtIndex_Bool:count]) {
        UIViewController* vc = [self.viewControllers objectAtIndex:count];
        if (vc != nil) {
            [self popToViewController:vc animated:YES];
        }
    } else {
        NSLog(@"エラーnavi　array  範囲外 ");
    }
}

- (CGFloat)_getHeight
{
    return self.navigationBar.frame.size.height;
}

- (CGFloat)_getWidth
{
    return self.navigationBar.frame.size.width;
}

@end
