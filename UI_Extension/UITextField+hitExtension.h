
#import <UIKit/UIKit.h>

@interface UITextField (hitExtension)

//テキストエリアの周りにヒットエリア作成　UITextFieldアィテクブエリアを広くする
- (void)_setHitArea:(int)hitWidth;

@property (nonatomic, assign) NSNumber* hitWidth;

@property (nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;

@end
