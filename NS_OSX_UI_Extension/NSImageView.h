
#import <AppKit/AppKit.h>

@interface NSImageView (extension)

//uiimageをクリックするとイベントが発生
-(void)_setClick:(id)target selecter:(SEL)selecter;

//イメージビューをぼかす
-(void)_bokasu:(double)scale;

//マスクを生成する UIImageをマスクイメージする必要があり
-(void)_setMaskImage:(NSImage*)maskImg;

@end
