
#import "UITextField+hitExtension.h"

#import <objc/runtime.h>

@implementation UITextField (hitExtension)

@dynamic hitWidth;
@dynamic hitTestEdgeInsets;

static const NSString* KEY_HIT_TEST_EDGE_INSETS_text = @"HitTestEdgeInsets_text";

- (void)setHitWidth:(NSNumber*)hitWidth
{

    CGFloat top = [hitWidth intValue] * -1;
    CGFloat left = [hitWidth intValue] * -1;
    CGFloat bottom = [hitWidth intValue] * -1;
    CGFloat right = [hitWidth intValue] * -1;

    [self setHitTestEdgeInsets:UIEdgeInsetsMake(top, left, bottom, right)];
}

- (void)_setHitArea:(int)hitWidth
{

    [self setHitTestEdgeInsets:UIEdgeInsetsMake(hitWidth * -1, hitWidth * -1, hitWidth * -1, hitWidth * -1)];
}

- (void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets
{
    NSValue* value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS_text, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)hitTestEdgeInsets
{
    NSValue* value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS_text);
    if (value) {
        UIEdgeInsets edgeInsets;
        [value getValue:&edgeInsets];
        return edgeInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    if (UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }

    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);

    return CGRectContainsPoint(hitFrame, point);
}

@end
