
#import "UIImage.h"
#import "UIImageView.h"

@implementation UIImageView (ex)

- (void)_setClick:(id)target selecter:(SEL)selecter
{

    if (target != nil && [target respondsToSelector:selecter]) {
        UITapGestureRecognizer* tapGesture =
            [[UITapGestureRecognizer alloc] initWithTarget:target
                                                    action:selecter];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tapGesture];
    }
}

- (void)_setMaskImage:(UIImage*)maskImg
{

    self.image = [self.image _mkMask:maskImg];
}

- (void)_bokasu:(double)scale
{

    self.layer.shouldRasterize = YES;                   //レイヤーをラスタライズする
    self.layer.rasterizationScale = scale;              //ラスタライズ時の縮小率
    self.layer.minificationFilter = kCAFilterTrilinear; //縮小時のフィルタ種類
}

@end
