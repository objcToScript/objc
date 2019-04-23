
#import <UIKit/UIKit.h>

@interface UIStoryboard (ex)

//ストリーボードから指定したstoryBoardIdのcontrollerを取得する
- (id)_getViewCon:(NSString*)storyBoardId;
//指定した名前のストリーボードを取得する
+ (UIStoryboard*)_getUIStoryboard:(NSString*)storyboardName;

+ (UIStoryboard*)_getNowStoryboard:(UINavigationController*)naviCon;

@end
