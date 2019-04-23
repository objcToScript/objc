
#import "UIButton.h"

@implementation UIButton (ex)

- (void)_imageWidthScale
{
    //Alignment も設定する guiからも可能
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    //　autoresizingMaskも設定すること guiから

    // self.imageBtm.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth;
}

@end
