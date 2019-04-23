
#import <AppKit/AppKit.h>

@interface NSTabViewController(ex)

-(NSViewController*)_getViewCon_Identifier:(NSString*)identifierId;

//現在選択されているviewConを取得する
-(NSViewController*)_getSelectViewCon;

//viewConを取得する
-(NSViewController*)_getViewCon:(int)index;

//タブを選択する
-(void)_setSelectIndex:(int)index;
//インデックスを取得する
-(int)_getSelectIndex;

//バーを表示する
//-(void)_hideTabBar;
//バーを非表示する
//-(void)_showTabBar;

@end




