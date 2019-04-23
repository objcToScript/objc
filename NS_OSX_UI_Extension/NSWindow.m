
#import "NSWindow.h"

@implementation NSWindow (ex)


-(void)_open{
    
    [self makeKeyAndOrderFront:NSApp];
    
}

-(NSViewController*)_getContentViewCon{
    
    return self.contentViewController;
    
}



@end
