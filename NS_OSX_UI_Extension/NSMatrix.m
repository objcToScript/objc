
#import "NSMatrix.h"

@implementation NSMatrix (ex)

-(void)_setSelectedValues:(NSMutableArray*)array{
    
    NSDictionary*bindingInfo = [self infoForBinding:NSSelectedValuesBinding];
    
    if(bindingInfo == nil){
        return;
    }
    
    NSString* keyPath = [[[bindingInfo valueForKey:NSObservedKeyPathKey] _toNSString] _replace:@"values." replaceStr:@""];
    
    int selectIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:keyPath] intValue];
    
    for(int i=0;i<[array count];i++){
        NSCell*cell = [self.cells objectAtIndex:i];
        if(selectIndex == i){
            [cell setState:NSOnState];
        }else{
            [cell setState:NSOffState];
        }
    }
    
}

-(void)_setSelectedIndex:(NSMutableArray*)array{
    
    NSDictionary*bindingInfo = [self infoForBinding:NSSelectedIndexBinding];
    
    if(bindingInfo == nil){
        return;
    }
    
    NSString* keyPath = [[[bindingInfo valueForKey:NSObservedKeyPathKey] _toNSString] _replace:@"values." replaceStr:@""];
    
    int selectIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:keyPath] intValue];
    
    for(int i=0;i<[array count];i++){
        NSCell*cell = [self.cells objectAtIndex:i];
        if(selectIndex == i){
            [cell setState:NSOnState];
        }else{
            [cell setState:NSOffState];
        }
    }
    
}


-(void)_addRowsWithTexts:(NSMutableArray*)array{
    
   // CGFloat y = self.y;
    for(int i=0;i<self.numberOfRows;i++){
        [self removeRow:i];
    }

    for(int i=0;i<[array count];i++){
        [self addRow];
        NSCell*cell = [self.cells objectAtIndex:i];
        cell.title = [array objectAtIndex:i];
        
        [cell setState:NSOnState];
    }
    
    [self _setSelectedIndex:array];
    [self _setSelectedValues:array];
    
    [self sizeToCells];
    [self display];
    
   // self.y = y - self.height;
    
}

-(void)_addRow{
    
    [self addRow];
    [self sizeToCells];
    [self display];
    
}

-(void)_removeAllRow{
    
    for(int i=0;i<self.numberOfRows;i++){
        [self removeRow:1];
    }
   [self sizeToCells];
   [self display];
}

-(void)_removeAtRow:(int)index{
    
    if(index < self.numberOfRows){
        [self removeRow:index];
        [self sizeToCells];
        [self display];
    }
    
}





-(void)_unSelect{
    [self deselectAllCells];
}

-(void)_selectCell:(NSInteger)row column:(NSInteger)col{
 
    if(row < self.numberOfRows && col < self.numberOfColumns  ){
        [self selectCellAtRow:row column:col];
    }else{
        [self selectCellAtRow:0 column:0];
    }
}

-(NSCell*)_getSelectedCell{
    
    NSCell*cell = [self selectedCell];
    
    return cell;
}


-(NSInteger)_getSelectedIndex{
    NSInteger index = [self selectedRow];
    return index;
}

// *がないものはエラーになる
-(void)_setBindingRow:(id)array model:(id)model keyPath:(NSString*)keyPath{
    
    [self deselectAllCells];
    
    int i=0;
    for(id model2 in array){
        if([model2 respondsToSelector:NSSelectorFromString(keyPath)]){
            if([model respondsToSelector:NSSelectorFromString(keyPath)]){

                id a =  [model2 performSelector:NSSelectorFromString(keyPath)];
                id b =  [model performSelector:NSSelectorFromString(keyPath)];
                
                if([a isEqual:b]){
                    [self selectCellAtRow:i column:0];
                    break;
                }

            }
        }
        i++;
    }
}

-(id)_getBindingRow:(id)array{
    
    NSInteger index = [self selectedRow];
    
    if([array _safeObjectAtIndex:index] != nil){
        return [array objectAtIndex:index];
    }
    
    return nil;
}

// *がないものはエラーになる
-(id)_getBindingRow_Value:(id)array keyPath:(NSString*)keyPath{
    
    NSInteger index = [self selectedRow];
    
    if([array _safeObjectAtIndex:index] != nil){
        __strong id model = [array objectAtIndex:index];
        
        if([model respondsToSelector:NSSelectorFromString(keyPath)]){
            id b =  [model performSelector:NSSelectorFromString(keyPath)];
            return b;
        }
    }
    
    return nil;
}



@end
