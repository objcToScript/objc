#import "NSTabViewController.h"

@implementation NSTabViewController(ex)

-(NSViewController*)_getViewCon_Identifier:(NSString*)identifierId{
    for(NSViewController*viewCon in self.childViewControllers){
        if([viewCon.identifier isEqual:identifierId]){
            return viewCon;
        }
    }
    return nil;
}

-(void)_setSelectIndex:(int)index{
    NSTabView *tabView = self.tabView;
    int n = (int)tabView.numberOfTabViewItems;
    //NSArray *tabViewItems = self.tabViewItems;
    
    if(index < n){
        [tabView selectTabViewItemAtIndex: index];
    }else{
        [tabView selectTabViewItemAtIndex: 0];
    }
    // * Sierra (10.12) or lower has a bug which doesn't update tab bar
}


-(int)_getSelectIndex{
    return (int)self.selectedTabViewItemIndex;
}


-(NSViewController*)_getSelectViewCon{
    //NSTabView *tabView = self.tabView;
    NSArray *tabViewItems = self.tabViewItems;
    NSInteger i = self.selectedTabViewItemIndex;
    NSTabViewItem *item = [tabViewItems objectAtIndex:i];
    
    return item.viewController;
}

-(NSViewController*)_getViewCon:(int)index{
    NSTabView *tabView = self.tabView;
    int n = (int)tabView.numberOfTabViewItems;
    
    if(index >=n){
        return nil;
    }
    NSArray *tabViewItems = self.tabViewItems;
    NSTabViewItem *item = [tabViewItems objectAtIndex:index];
    return item.viewController;
}

// hide on bar push にチェックを入れること
- (void)_hideTabBar{
    
}

- (void)_showTabBar{
    
}

@end
