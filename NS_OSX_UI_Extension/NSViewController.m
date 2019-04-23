
#import "NSViewController.h"

@implementation NSViewController (utility)

- (NSView *)_viewWithIdentifier:(NSString *)identifier{
    for (__strong NSView *view in [self.view subviews]) {
        if(view == nil){
            continue;
        }
        if ([view.identifier isEqualToString:identifier]) {
            return view;
        }
        if([view isKindOfClass:[NSView class]] && [view subviews] > 0){
            return [self _viewWithIdentifier:identifier];
        }
    }
    return nil;
}


-(NSView*)_getView:(NSString*)identifierId{
    NSView *viewToFind = [self _viewWithIdentifier:identifierId];
    return viewToFind;
}
-(NSTextView*)_getTextView:(NSString*)identifierId{
    NSTextView *viewToFind = (NSTextView*)[self _viewWithIdentifier:identifierId];
    return viewToFind;
}
-(NSTextField*)_getTextField:(NSString*)identifierId{
    NSTextField *viewToFind = (NSTextField*)[self _viewWithIdentifier:identifierId];
    return viewToFind;
}
-(NSButton*)_getButton:(NSString*)identifierId{
    NSButton *viewToFind = (NSButton*)[self _viewWithIdentifier:identifierId];
    return viewToFind;
}
-(NSPopUpButton*)_getPopUpButton:(NSString*)identifierId{
    NSPopUpButton *viewToFind = (NSPopUpButton*)[self _viewWithIdentifier:identifierId];
    return viewToFind;
}
-(NSImageView*)_getImageView:(NSString*)identifierId{
    NSImageView *viewToFind = (NSImageView*)[self _viewWithIdentifier:identifierId];
    return viewToFind;
}

-(NSTableView*)_getTableView:(NSString*)identifierId{
    NSTableView *viewToFind = (NSTableView*)[self _viewWithIdentifier:identifierId];
    return viewToFind;
}

//ゲットウィンドウ
-(NSWindow*)_getMainWindow{
    return [[NSApplication sharedApplication] mainWindow];
}
-(NSWindow*)_getKeyWindow{
    return [[NSApplication sharedApplication] keyWindow];
}
-(NSWindow*)_getModalWindow{
    return [[NSApplication sharedApplication] modalWindow];
}

-(NSViewController*)_getViewCon:(Class)viewConClass{
    for(NSViewController* viewCon in self.childViewControllers){
        if([viewCon isKindOfClass:viewConClass]){
            return viewCon;
        }
    }
    return nil;
}


-(id)_getParentViewCon{
    NSViewController *vc = self.presentingViewController;
    return vc;
    
}

// 次の画面を呼ぶ
-(void)_nextViewCon:(NSString*)Identifier sender:(id)sender{
    [self performSegueWithIdentifier:Identifier sender:sender];
}

// 閉じる
-(void)_close{
    
    if(self.view.window.windowController != nil){
        [self.view.window.windowController close];
    }else{
        [self dismissViewController:self];
    }
}
// 閉じる
-(void)_close_viewCon{
    
    
 [self dismissViewController:self];
}


-(void)_showViewCon:(NSViewController*)viewCon{
    [self presentViewControllerAsModalWindow:viewCon];
}



#pragma mark Conを取得する
-(NSMutableArray*)_getAllCon{
    
    NSMutableArray* newArray = [NSMutableArray new];
    
    [self _getAllBind_do:self.view newArray:newArray];
    
    return newArray;
    
}

-(NSMutableArray*)_getAllBind_do:(NSView*)view_t newArray:(NSMutableArray*)newArray{
    
    for (id con in view_t.subviews) {
        
        if([con respondsToSelector:@selector(_setBind:)]){
            [newArray addObject:con];
            continue;
        }
        if([con isKindOfClass:[NSView class]] &&
           [[(NSView*)con subviews] count] > 0){
            [self _getAllBind_do:con newArray:newArray];
            continue;
        }
    }
    
    return newArray;
}



#pragma mark すべてのbindConにデーターをセットする
-(void)_setAllBind:(NSMutableDictionary*)dic{
    
    [self _setAllBind_do:self.view dic:dic];
    
}

-(void)_setAllBind_do:(NSView*)view_t dic:(NSMutableDictionary*)dic{
    
    for (id con in view_t.subviews) {
        if([con respondsToSelector:@selector(_setBind:)]){
            [con performSelector:@selector(_setBind:) withObject:dic];
            continue;
        }
        if([con isKindOfClass:[NSView class]]){
            [self _setAllBind_do:con dic:dic];
            continue;
        }
    }
    
}



#pragma mark bindのConを取得する
-(id)_getCon_from_RestrationId:(NSString*)restrationId{
    
    id conArray = [self _getCon_from_RestrationId_do:self.view restrationId:restrationId ];
    
    return conArray;
    
}

-(id)_getCon_from_RestrationId_do:(NSView*)view_t restrationId:(NSString*)restrationId{
    
    for (NSView* con in view_t.subviews) {
        if(con != nil && [con.identifier isEqual:restrationId]){
            return con;
            break;
        }
        if(con != nil && [con isKindOfClass:[NSView class]] && [con subviews] > 0){
            id result = [self _getCon_from_RestrationId_do:con restrationId:restrationId ];
            if(result != nil){
                return result;
            }
        }
    }
    
    return nil;
}


/*
 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
 if([[segue identifier] isEqualToString:@"identifier名"]) {
 //遷移先のViewController
 NextViewController *nextViewController = [segue destinationViewController];
 }
 }
 */





@end

