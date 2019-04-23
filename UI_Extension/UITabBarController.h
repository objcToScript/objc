
#import <UIKit/UIKit.h>

@interface UITabBarController (ex)

//現在選択されているviewConを取得する
- (UIViewController*)_getSelectViewCon;

//viewConを取得する
- (UIViewController*)_getViewCon:(int)index;

//指定したrestorationIdentifierがあれば取得する
- (UIViewController*)_getViewCon_restorationIdentifier:(NSString*)restorationIdentifier;

//タブを選択する
- (void)_setSelectIndex:(int)index;
//インデックスを取得する
- (int)_getSelectIndex;

//バーを表示する
- (void)_hideTabBar;
//バーを非表示する
- (void)_showTabBar;

@end
