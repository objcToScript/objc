
#import "UIScroolView.h"

@implementation UIScrollView (ex)

- (void)_setContentSize:(int)width height:(int)height
{
    self.contentSize = CGSizeMake(width, height);
}

- (void)_setScrollX:(int)x isAnime:(BOOL)isAnime
{

    CGPoint offset = CGPointMake(x, 0);

    [self setContentOffset:offset animated:isAnime];
}

- (void)_setScrollY:(int)y isAnime:(BOOL)isAnime
{

    CGPoint offset = CGPointMake(y, 0);

    [self setContentOffset:offset animated:isAnime];
}

- (void)_setPageScrollSetting
{

    self.pagingEnabled = YES;

    self.bounces = NO;
}

#pragma mark スクロールをアニメーションで動作させる
- (void)_scrollToPage:(UIScrollView*)scrollView offset:(CGPoint)offset duration:(double)duration delay:(double)delay
{

    scrollView.userInteractionEnabled = NO;

    __block CGFloat delta = offset.x - scrollView.contentOffset.x;

    __block int animationCount = 0;
    for (UIView* view in scrollView.subviews) {
        [UIView animateWithDuration:duration
            delay:delay
            options:UIViewAnimationOptionCurveEaseOut
            animations:^{
                animationCount++;
                CGRect frame = view.frame;
                frame.origin.x -= delta;
                view.frame = frame;
            }
            completion:^(BOOL finished) {
                animationCount--;
                if (animationCount == 0) {
                    scrollView.contentOffset = offset;
                    for (UIView* view in scrollView.subviews) {
                        CGRect frame = view.frame;
                        frame.origin.x += delta;
                        view.frame = frame;
                    }
                    scrollView.userInteractionEnabled = YES;
                }
            }];
    }
}

@end
