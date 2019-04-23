
#import <AppKit/AppKit.h>
#import "clsNSString.h"

@interface NSSegmentedControl (extension)

//フォントサイズを指定する
@property (nonatomic) int  fontSize;

-(void)_setSelectImage:(NSImage*)image segment:(NSInteger)segment;

-(NSImage*)_getSegmentImage:(NSInteger)segment;

//影に色をつける
@property (strong,nonatomic)NSString*shadowColor;
//テキストカラーを指定する
@property (strong,nonatomic)NSString*textColor;

//背景に画像を使った時にセグメントの色とセグメンの間にある仕切り棒と削除する
-(void)_removeColorBorder;

//セグメントの背景に画像をセットする
-(void)_setSelectImage:(NSImage*)image;

-(id)_safeObjectAtIndex:(NSArray*)array index:(NSUInteger)index ;

-(id)_getDataRow_selected;


@end
