
#import "UISlider.h"

@implementation UISlider (ex)

- (void)_sliderPuti_off
{

    [self setSelected:NO];
    [self setThumbImage:[UIImage new] forState:UIControlStateNormal];
}

@end
