
#import "NSScrollView.h"

@implementation NSScrollView(ex)


-(void)_setScrollX:(int)x isAnime:(BOOL)isAnime{
    if (isAnime){
        [NSAnimationContext beginGrouping];
        [[NSAnimationContext currentContext] setDuration:3.0];
    }
    
    NSClipView* clipView = [self contentView];
    NSPoint newOrigin = [clipView bounds].origin;
    newOrigin.x = (CGFloat)x;
    
    if (isAnime)
        [[clipView animator] setBoundsOrigin:newOrigin];
    else
        [clipView setBoundsOrigin:newOrigin];
    
    //[self reflectScrolledClipView: [self contentView]];
    
    if (isAnime)
        [NSAnimationContext endGrouping];

}

-(void)_setScrollY:(int)y isAnime:(BOOL)isAnime{
    if (isAnime)
    {
        [NSAnimationContext beginGrouping];
        [[NSAnimationContext currentContext] setDuration:3.0];
    }
    
    NSClipView* clipView = [self contentView];
    NSPoint newOrigin = [clipView bounds].origin;
    newOrigin.y = (CGFloat)y;
    
    if (isAnime)
        [[clipView animator] setBoundsOrigin:newOrigin];
    else
        [clipView setBoundsOrigin:newOrigin];
    
    if (isAnime)
        [NSAnimationContext endGrouping];
}

-(void)_setPageGotoScroll{
    // nothing to do
    

    
}

#pragma mark スクロールをアニメーションで動作させる
-(void)_scrollToPage:(NSScrollView*)scrollView offset:(CGPoint)offset duration:(double)duration delay:(double)delay{
    CGFloat x, y;
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:duration];
    
    NSClipView* clipView = [scrollView contentView];
    NSPoint currOrigin = [clipView bounds].origin;
    x = currOrigin.x + offset.x;
    y = currOrigin.y + offset.y;
    NSPoint newOrigin;
    newOrigin.x = x;
    newOrigin.y = y;
    
    [[clipView animator] setBoundsOrigin:newOrigin];
    [NSAnimationContext endGrouping];
}


@end





