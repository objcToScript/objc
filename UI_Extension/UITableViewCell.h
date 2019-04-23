
#import <UIKit/UIKit.h>

@interface UITableViewCell (ex)

//選択色の選択
- (void)_setSelectionStyleNone;
- (void)_setSelectionStyleBlue;
- (void)_setSelectionStyleGray;

//背景色を追加する
- (void)_setBackGround:(int)color;

//セルに独自の分割線を描画する
- (void)_setSepartionCell:(int)leftMargin;

//チェックを外す
- (void)_unCheckCell:(NSMutableDictionary*)dic v0:(NSString*)v0;

//チェックを入れる
- (void)_checkCell:(NSMutableDictionary*)dic v0:(NSString*)v0;

@end
