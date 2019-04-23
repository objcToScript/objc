
#import <UIKit/UIKit.h>

@interface UIButton (hitExtension)

//UIButtonの大きさを変えずにヒットエリアだけを大きくする
- (void)_setHitArea:(int)hitWidth;

@property (nonatomic, assign) NSNumber* hitWidth;

@property (nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;

@end
