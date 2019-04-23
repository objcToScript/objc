
#import <UIKit/UIKit.h>

@interface UILabel (ex)

- (void)_setLableColor:(UIColor*)textColor;

//テキストだけの高さを取得する
- (CGFloat)_getHeightFix:(CGFloat)textFontSize;

//ラベルをクリックするとイベントが発生する
- (void)_setClick:(id)target selecter:(SEL)selecter;

@end
