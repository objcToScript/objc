#import <AppKit/AppKit.h>

@interface NSTextField (ex)

-(id)_getDataRow_selected;

//-(void)_setLableColor:(UIColor*)textColor;

//テキストだけの高さを取得する
-(CGFloat)_getHeightFix:(CGFloat)textFontSize;

//ラベルをクリックするとイベントが発生する
-(void)_setClick:(id)target selecter:(SEL)selecter;


@end



