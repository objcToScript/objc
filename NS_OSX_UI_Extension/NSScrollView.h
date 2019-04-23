
#import <AppKit/AppKit.h>

@interface NSScrollView (ex)

//ページごとにスクロールする設定
-(void)_setPageGotoScroll;

//スクロールに入っているすべてのviewに対してスクロールさせる
-(void)_scrollToPage:(NSScrollView*)scrollView offset:(CGPoint)offset duration:(double)duration delay:(double)delay;

//値を指定してスクロールさせる
-(void)_setScrollX:(int)x isAnime:(BOOL)isAnime;

//値を指定してスクロールさせる
-(void)_setScrollY:(int)y isAnime:(BOOL)isAnime;


@end









