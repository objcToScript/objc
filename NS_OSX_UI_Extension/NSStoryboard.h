
#import <AppKit/AppKit.h>

@interface NSStoryboard (ex)

//ストリーボードから指定したIdentifierのcontrollerを取得する
-(id)_getViewCon:(NSString*)identifier;

//指定した名前のストリーボードを取得する
+(NSStoryboard*)_getUIStoryboard:(NSString*)storyboardName;

+(NSStoryboard*)_getNowStoryboard:(NSViewController*)viewCon;


@end

