
#import "UIStoryboard.h"

@implementation UIStoryboard (ex)

+ (UIStoryboard*)_getNowStoryboard:(UINavigationController*)naviCon
{

    return naviCon.storyboard;
}

+ (UIStoryboard*)_getUIStoryboard:(NSString*)storyboardName
{

    UIStoryboard* MainStoryboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];

    return MainStoryboard;
}

//ViewConはStoryBoardIdで取得する
- (id)_getViewCon:(NSString*)storyBoardId
{

    UIViewController* myView_navi = [self instantiateViewControllerWithIdentifier:storyBoardId];

    return myView_navi;
}

@end
