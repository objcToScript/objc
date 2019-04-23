
#import "NSImageView.h"
#import "NSImage+Utility.h"

@implementation NSImageView (extension)


-(void)_setClick:(id)target selecter:(SEL)selecter{

    if(target != nil && [target respondsToSelector:selecter]){
        NSClickGestureRecognizer *tapGesture =
        [[NSClickGestureRecognizer alloc] initWithTarget:target
                                                action:selecter];
        tapGesture.numberOfClicksRequired = 1;
        [self addGestureRecognizer:tapGesture];
    }
   
    NSLog(@"NSImageView(extension) _setCliked");
}

-(void)_setMaskImage:(NSImage*)maskImg{

    self.image = [self.image _mkMask:maskImg];

}


-(void)_bokasu:(double)scale{
    
    self.layer.shouldRasterize = YES;  //レイヤーをラスタライズする
    self.layer.rasterizationScale = scale;  //ラスタライズ時の縮小率
    self.layer.minificationFilter = kCAFilterTrilinear;  //縮小時のフィルタ種類

}



@end
