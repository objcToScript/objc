
#import "NSStoryboard.h"

@implementation NSStoryboard (ex)


+(NSStoryboard*)_getUIStoryboard:(NSString*)storyboardName{
    
    NSStoryboard *MainStoryboard = [NSStoryboard storyboardWithName:storyboardName bundle:nil];
    
    return MainStoryboard;
    
}

-(id)_getViewCon:(NSString*)identifier{    
    
    id myView_navi = [self instantiateControllerWithIdentifier:identifier];
    
    return myView_navi;
}

+(NSStoryboard*)_getNowStoryboard:(NSViewController*)viewCon{
    
    NSStoryboard*storyBoard = viewCon.storyboard;
    
    return storyBoard;
}



@end





