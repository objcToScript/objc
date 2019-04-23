
#import <UIKit/UIKit.h>

@interface UIScrollView (ex)

//コンテンツサイズを設定する
- (void)_setContentSize:(int)width height:(int)height;

//ページごとにスクロールする設定
- (void)_setPageScrollSetting;

//スクロールに入っているすべてのviewに対してスクロールさせる
- (void)_scrollToPage:(UIScrollView*)scrollView offset:(CGPoint)offset duration:(double)duration delay:(double)delay;

//値を指定してスクロールさせる
- (void)_setScrollX:(int)x isAnime:(BOOL)isAnime;

//値を指定してスクロールさせる
- (void)_setScrollY:(int)y isAnime:(BOOL)isAnime;

@end
