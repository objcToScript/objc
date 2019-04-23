
#import <AppKit/AppKit.h>

@interface NSViewController (utility)

-(NSWindow*)_getMainWindow;
-(NSWindow*)_getKeyWindow;
-(NSWindow*)_getModalWindow;

//viewConの親元のcontrollerを呼ぶ　 dismiss presentの際に使う
-(id)_getParentViewCon;

//次の画面をSegueで呼ぶ
-(void)_nextViewCon:(NSString*)Identifier sender:(id)sender;

-(void)_close;

-(void)_close_viewCon;

//viewConを表示する
-(void)_showViewCon:(NSViewController*)viewCon isAnime:(BOOL)isAnime;

//SwipGestureを追加する
//-(void)_mkSwipGesture;

//viewConwをスワイプすると前の画面へ戻る
//-(void)_swipe:(UISwipeGestureRecognizerEx *)gesture;


//コントロールを全て取得する
-(NSMutableArray*)_getAllCon;

-(NSView *)_viewWithIdentifier:(NSString *)identifier;
-(NSView*)_getView:(NSString*)identifierId;
-(NSTextView*)_getTextView:(NSString*)identifierId;
-(NSTextField*)_getTextField:(NSString*)identifierId;
-(NSButton*)_getButton:(NSString*)identifierId;
-(NSPopUpButton*)_getPopUpButton:(NSString*)identifierId;
-(NSImageView*)_getImageView:(NSString*)identifierId;
-(NSTableView*)_getTableView:(NSString*)identifierId;

-(NSViewController*)_getViewCon:(Class)viewConClass;



@end
