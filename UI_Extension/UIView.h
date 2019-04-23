
#import <UIKit/UIKit.h>

@interface UIView (ex)

//gestureをすべて削除する
- (void)_removeGestureAll;

//viewAの座標をviewB上の座標へ変換する
- (CGPoint)_convetView_Point:(UIView*)targetView;

//viewAのRectをviewB上のRectへ変換する
- (CGRect)_convetView_Rect:(UIView*)targetView;

//baseViewにtargetViewのプロパティをフェッチする
- (void)_fetchProperty_from_Rotation:(UIView*)targetView;

//RestrationIdのあるviewのみ取得する
- (void)_getView_from_RestrationIdOnly:(NSMutableArray*)array isRootViewInsert:(BOOL)isRootViewInsert;

//プロパティをフェッチする
- (void)_fetchProperty:(UIView*)targetView;

//UiViewを比較してviewを削除する
- (void)_removeSubViews_from_view:(UIView*)targetView;

- (void)_setAutoSizeWidthHeight;

- (void)_setAutoSizeWidthHeightMargin;

- (void)_setClick:(id)target selecterStr:(NSString*)selecterSt userInfo:(id)userInfo;

- (void)_setClick:(id)target selecter:(SEL)selecte userInfo:(id)userInfo;

//指定したrestrationIdのコントロールを取得する
- (id)_getCon_from_RestrationId:(NSString*)restrationId;

//ビューを追加する
- (void)_addSubViews:(UIView*)insertView tag:(int)tag;

//ビューを削除する
- (void)_removeSubViews:(int)tag;
- (void)_deleteSubViews:(int)tag;

//UIアニメーションを一時停止
- (void)_pauseAnimations;
//UIアニメーションを一時停止を解除する
- (void)_resumeAnimations;

//ビューに下線を追加する
- (void)_addBottomBar:(UIColor*)borderColor borderWidth:(int)borderWidth;

//ビューにボーダーを追加する
- (void)_setBorderLine:(CGFloat)kadomaru borderSize:(CGFloat)borderSize borderColor:(NSString*)borderColor;

//ビューに影を追加する
- (void)_mkShadou;

// 真ん中の位置情報を取得する
- (CGRect)_getCenterFrameWithView:(UIView*)argView parent:(UIView*)argParentView;

//ボーダーを追加 本命はtableView
- (void)_mkBorderLine:(int)size hex:(NSString*)hex;

//現在のviewからViewControllerを取得する
- (UIViewController*)_getViewController;
//現在のviewからSplitViewControllerを取得する
- (UISplitViewController*)_getSplitViewController;

//viewの周りにボーダーを生成する
- (void)_addTBorderWithColor:(NSString*)hex
                 borderWidth:(CGFloat)borderWidth
                       isTop:(BOOL)isTop
                    isBottom:(BOOL)isBottom
                      isLeft:(BOOL)isLeft
                     isRight:(BOOL)isRight;

// view.x で位置を指定できるようにする
// view.width で大きさを指定できるようにする
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@end
