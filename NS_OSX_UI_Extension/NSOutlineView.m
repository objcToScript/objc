
#import "NSOutlineView.h"

@implementation NSOutlineView (ex)


-(void)_initExpand:(NSInteger)length{
    for(int i=0;i<length;i++){
        NSTreeNode* treeNode = [self itemAtRow:i];
        [self expandItem:treeNode];
    }
}



-(id)_getSlectedData{
    
    id selectedItem = [self itemAtRow:[self selectedRow]];
    
    return selectedItem;
    
}






@end
