
#import <AppKit/AppKit.h>

#import <QuartzCore/CoreAnimation.h>
//embed

@interface NSView(ex)


-(id)_getCon_from_IdentifierId:(NSString*)identifierId;

//ビューを追加する
-(void)_addSubViews:(NSView*)insertView tag:(int)tag;

//ビューを削除する
-(void)_removeSubViews:(int)tag;
-(void)_deleteSubViews:(int)tag;

//UIアニメーションを一時停止
- (void)_pauseAnimations;
//UIアニメーションを一時停止を解除する
- (void)_resumeAnimations;

//ビューに下線を追加する
-(void)_addBottomBar:(NSColor*)borderColor borderWidth:(int)borderWidth;

//ビューにボーダーを追加する
-(void)_setBorderLine:(CGFloat)kadomaru borderSize:(CGFloat)borderSize borderColor:(NSString*)borderColor;

//ビューに影を追加する
-(void)_mkShadou;

// 真ん中の位置情報を取得する
- (CGRect)_getCenterFrameWithView:(NSView*)argView parent:(NSView*)argParentView;

//ボーダーを追加 本命はtableView
-(void)_mkBorderLine:(int)size hex:(NSString*)hex;

//現在のviewからViewControllerを取得する
- (NSViewController *)_getViewController;
//現在のviewからSplitViewControllerを取得する
- (NSSplitViewController *)_getSplitViewController;

//viewの周りにボーダーを生成する
-(void)_addTBorderWithColor:(NSString *)hex
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

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGPoint center;

@property (nonatomic) CGFloat alpha;

@property (nonatomic) NSView* viewForBaselineLayout;










@end








