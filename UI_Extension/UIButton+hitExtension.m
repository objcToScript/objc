
#import "UIButton+hitExtension.h"

#import <objc/runtime.h>

@implementation UIButton (hitExtension)

@dynamic hitTestEdgeInsets;
@dynamic hitWidth;

static const NSString* KEY_HIT_TEST_EDGE_INSETS = @"HitTestEdgeInsets";

- (void)setHitWidth:(NSNumber*)hitWidth
{

    [self setHitTestEdgeInsets:UIEdgeInsetsMake([hitWidth intValue] * -1, [hitWidth intValue] * -1, [hitWidth intValue] * -1, [hitWidth intValue] * -1)];
}

- (void)_setHitArea:(int)hitWidth
{

    [self setHitTestEdgeInsets:UIEdgeInsetsMake(hitWidth * -1, hitWidth * -1, hitWidth * -1, hitWidth * -1)];
}

- (void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets
{
    NSValue* value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)hitTestEdgeInsets
{
    NSValue* value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
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
