
#import "UILabel.h"

@implementation UILabel (ex)

- (void)_setLableColor:(UIColor*)textColor
{

    self.textColor = textColor;
}

- (void)_setClick:(id)target selecter:(SEL)selecter
{

    if (target != nil && [target respondsToSelector:selecter]) {

        UITapGestureRecognizer* tapGesture =
            [[UITapGestureRecognizer alloc] initWithTarget:target
                                                    action:selecter];
        self.userInteractionEnabled = YES;

        tapGesture.numberOfTapsRequired = 1;

        [self addGestureRecognizer:tapGesture];
    }
}

- (CGFloat)_getHeightFix:(CGFloat)textFontSize
{

    @try {
        // 表示最大幅・高さ
        CGSize maxSize = CGSizeMake(self.width, CGFLOAT_MAX);

        // 表示するフォントサイズ
        NSDictionary* attr = @{NSFontAttributeName : [UIFont systemFontOfSize:textFontSize]};
        CGSize modifiedSize;

        // 以上踏まえた上で、表示に必要なサイズ
        if ([self.text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {

            modifiedSize = [self.text boundingRectWithSize:maxSize
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:attr
                                                   context:nil]
                               .size;
            return modifiedSize.height;

        } else if ([self.text respondsToSelector:@selector(sizeWithFont:constrainedToSize:)]) {

            modifiedSize = [self.text sizeWithFont:[UIFont systemFontOfSize:textFontSize] constrainedToSize:CGSizeMake(self.width, CGFLOAT_MAX)];
            return modifiedSize.height;
        }

    } @catch (NSException* exception) {
        [exception _saveCrashReport];
    }

    return 0;
}

@end
