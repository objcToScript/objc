
#import <UIKit/UIKit.h>

#import "UISwipeGestureRecognizerEx.h"

@interface UIViewController (utility)

- (void)_widthHeightFix_fromViewCon:(UIViewController*)fromViewCon;
//StoryBoardからViewConをインスタンスで取った後に大きさを修正する
- (void)_widthHeightFix;

- (int)_getChildViewConNum:(NSArray*)restorationIdArray;

- (void)_removeChildViewConLimitNum_Asc:(int)kagenNum restorationIdArray:(NSArray*)restorationIdArray;

- (void)_removeChildViewConLimitNum_Desc:(int)kagenNum restorationIdArray:(NSArray*)restorationIdArray;

- (void)_removeChildViewCon:(NSArray*)removeRestorationIdArray
    exceptRestorationIdArray:(NSArray*)exceptRestorationIdArray;

- (UIViewController*)_getViewConWithRestorationId:(NSString*)restorationId;

- (void)_removeViewConWithRestorationId:(NSString*)restorationId;

//ViewConと指定したViewに追加する
- (void)_addViewConWithView:(UIViewController*)viewCon targetInsertView:(UIView*)targetInsertView;

//ViewConとViewを追加する
- (void)_addViewConWithView:(UIViewController*)viewCon;

//viewConを削除する
- (void)_removeViewConWithView;

//viewConの親元のcontrollerを呼ぶ　 dismiss presentの際に使う
- (id)_getParentViewCon;

//次の画面をSegueで呼ぶ
- (void)_nextViewCon:(NSString*)Identifier sender:(id)sender;

//SwipGestureを追加する
- (void)_mkSwipGesture;

//viewConwをスワイプすると前の画面へ戻る
- (void)_swipe:(UISwipeGestureRecognizerEx*)gesture;

//viewConを表示する
- (void)_showViewCon:(UIViewController*)viewCon isAnime:(BOOL)isAnime;

- (void)_showViewCon:(UIViewController*)viewCon isAnime:(BOOL)isAnime func:(void (^)(NSString*))func;

//presentViewControllerで開かれたviewConを閉じる
- (void)_close:(BOOL)isAnime;

- (void)_close:(BOOL)isAnime func:(void (^)(NSString*))func;

//コントロールを全て取得する
- (NSMutableArray*)_getAllCon;

//_setBind関数をもつコントロールを_setBindを実行させる
- (void)_setAllBind:(id)dic;

//restrationIdのコントロールを取得する
- (id)_getCon_from_RestrationId:(NSString*)restrationId;

@end
