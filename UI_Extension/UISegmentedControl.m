
#import "UISegmentedControl.h"

@implementation UISegmentedControl (extension)

@dynamic fontSize;
@dynamic shadowColor;
@dynamic textColor;

- (void)_setItems:(NSMutableArray*)itmes
{
    [self removeAllSegments];
    for (NSString* segment in itmes) {
        [self insertSegmentWithTitle:segment atIndex:self.numberOfSegments animated:NO];
    }
}

- (void)_setSelectImage:(UIImage*)image
{

    [self setBackgroundImage:image forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
}

- (void)_removeColorBorder
{

    //仕切り棒
    [self setDividerImage:[self _imageColor:[UIColor clearColor]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    //背景画像
    [self setBackgroundImage:[self _imageColor:[UIColor clearColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

- (UIImage*)_imageColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)setFontSize:(int)size
{

    UIFont* font = [UIFont systemFontOfSize:size];
    NSDictionary* attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    [self setTitleTextAttributes:attributes forState:UIControlStateNormal];

}

- (void)setTextColor:(NSString*)colorCode
{
    NSArray* ary = [self subviews];
    for (id seg in ary)
        for (id label in [seg subviews])
            if ([label isKindOfClass:[UILabel class]]) {
                [label setTextColor:[colorCode _getUIColorFromHex]];
            }
}

- (void)setShadowColor:(NSString*)colorCode
{
    NSArray* ary = [self subviews];
    for (id seg in ary)
        for (id label in [seg subviews])
            if ([label isKindOfClass:[UILabel class]]) {
                [label setShadowColor:[colorCode _getUIColorFromHex]];
            }
}
- (id)_safeObjectAtIndex:(NSArray*)array index:(NSUInteger)index
{
    if (index >= array.count) {
        return nil;
    }
    return [array objectAtIndex:index];
}

@end
