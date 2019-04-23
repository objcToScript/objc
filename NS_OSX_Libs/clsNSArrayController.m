
#import "clsNSArrayController.h"

@implementation NSArrayController (ex)


-(void)_resetIndex{
    [self setSelectionIndex:-1];
}

-(void)_setSelectIndex:(int)index{
    [self setSelectionIndex:index];
}


-(void)_updateReload{
    
    [self rearrangeObjects];
    
}





@end
