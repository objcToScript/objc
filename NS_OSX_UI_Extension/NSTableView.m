
#import "NSTableView.h"

#import "clsNSIndexSet.h"
#import "clsNSMutableArray.h"

@implementation NSTableView(ex)




-(void)_setIndex_from_tableView:(int)index{
    
   NSMutableArray*array =  [self _getDataArray];
    
    if(index < [array count]){
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
        [self selectRowIndexes:indexSet byExtendingSelection:NO];
    }
    
}


//array SelectIndexがうまく動かなかったため　手動で arrayConをSelectしている
-(void)_setIndex_arrayCon{
    NSDictionary*bindingDic = [self infoForBinding:NSContentBinding];
    NSArrayController* bindingDataArray = [bindingDic objectForKey:NSObservedObjectKey];

    if(bindingDataArray != nil && [self selectedRow] != -1 ){
        [bindingDataArray setSelectionIndex:[self selectedRow]];
    }
}


-(void)_setIndex_arrayCon:(NSInteger)index{
    NSDictionary*bindingDic = [self infoForBinding:NSContentBinding];
    NSArrayController* bindingDataArray = [bindingDic objectForKey:NSObservedObjectKey];
    
    if(bindingDataArray != nil && index != -1 ){
        [bindingDataArray setSelectionIndex:index];
    }
}


-(BOOL)_isTargetTableColumn:(NSString*)keyPath{
    
    NSTableColumn*tableColumn = [self _getSelectedTableColumn];
    NSString*keyPath_temp = [tableColumn _getKeyPath];
    if([keyPath_temp isEqual:keyPath]){
        return YES;
    }    
    return NO;
}


-(NSTableColumn*)_getSelectedTableColumn{
  
    NSInteger columnIndex1 = self.clickedColumn;
    if(columnIndex1 < [[self tableColumns] count]){
        return [[self tableColumns] objectAtIndex:columnIndex1];
    }
    return nil;
}

-(id)_getDataRow{
    
    NSDictionary*bindingInfo = [self infoForBinding:NSContentBinding];
    NSArrayController*arrayController = [bindingInfo valueForKey:NSObservedObjectKey];
    
    NSMutableArray* selectedObjects = arrayController.arrangedObjects;
    
    if([selectedObjects count] > 0 && [self selectedRow] != -1){
        id dataRow = [selectedObjects objectAtIndex:[self selectedRow]];
        return dataRow;
    }
    return nil;
}


-(NSMutableArray*)_getDataArray{
    
    NSDictionary*bindingInfo = [self infoForBinding:NSContentBinding];
    NSArrayController*arrayController = [bindingInfo valueForKey:NSObservedObjectKey];
    
    NSMutableArray* selectedObjects = arrayController.content;
    return selectedObjects;
}



/*
-(id)_getRowData:(NSArrayController*)arrayCon{
    
    NSMutableArray* selectedObjects = arrayCon.arrangedObjects;
    if([selectedObjects count] > 0){
        id dataRow = [selectedObjects objectAtIndex:[self selectedRow]];
        return dataRow;
    }
    return nil;
}
*/

-(void)_deleteCell:(int)index {
    
    if(index == -1){
        return;
    }
    int count = [self _getCount];
    if(index >= count){
        return;
    }
    
    NSIndexSet*indexSet = [[NSIndexSet alloc] initWithIndex:index];
    
    if(self.dataSource != nil &&
       [self.dataSource isKindOfClass:[NSMutableArray class]]){
        

        
         [((NSMutableArray*) self.dataSource) _deleteDataRowIndex:index];
    }
    
    [self beginUpdates];
    [self removeRowsAtIndexes:indexSet withAnimation:NSTableViewAnimationEffectFade];
    [self endUpdates];
    
}

-(void)_deleteCellMulti:(NSMutableArray*)indexArray {
    
    if(indexArray == nil || [indexArray count] == 0){
        return;
    }
    
    NSMutableIndexSet* indexes = [[NSMutableIndexSet alloc] init];
    int count = [self _getCount];
    
    for(NSNumber* value in indexArray){
        if([value intValue] < count){
            [indexes addIndex:[value intValue]];
            
            [((NSMutableArray*) self.dataSource) _deleteDataRowIndex:[value intValue]];
            
        }
    }
    NSIndexSet* result = [[NSIndexSet alloc] initWithIndexSet:indexes];
    
    [self beginUpdates];
    [self removeRowsAtIndexes:result withAnimation:NSTableViewAnimationEffectFade];
    [self endUpdates];
    
}

-(void)_goToIndex:(NSIndexSet*)indexSet{
    [self scrollRowToVisible:indexSet.firstIndex];
}

-(int)_getCount{
    
   id content = self.dataSource;
   if( [content respondsToSelector:@selector(count)]){
       int count1 = (int)[content performSelector:@selector(count)];
       return count1;
   }
   return 0;
}


-(void)_setSelect:(int)index{
    if(index < [self _getCount]){
        [self selectRowIndexes:[NSIndexSet indexSetWithIndex:index] byExtendingSelection:NO];
    }
}

//セル選択した時に非表示にする
-(void)_cellSelectionSelected_indexPath:(int)index{
    [self deselectRow:index];
}

-(NSTextFieldCell*)_getCell_TextFieldCell{
    NSInteger selected = [self selectedRow];
    NSInteger selectedColumn = [self selectedColumn];
    if(selectedColumn == -1){
        selectedColumn = 0;
    }
    NSTableColumn*column = [self.tableColumns objectAtIndex:selectedColumn];
    NSTextFieldCell *cell = [column dataCellForRow:selected];
    return cell;
}

-(NSTableCellView*)_getCell_TableCellView{
    NSInteger selected = [self selectedRow];
    NSInteger selectedColumn = [self selectedColumn];
    if(selectedColumn == -1){
        selectedColumn = 0;
    }
    NSTableColumn*column = [self.tableColumns objectAtIndex:selectedColumn];
    NSTableCellView *cell = [column dataCellForRow:selected];
    return cell;
}


-(int)_getRowIndex{
    NSInteger selectedIndex = self.clickedRow;
    return (int)selectedIndex;
}

-(int)_getColumnIndex{
    NSInteger selectedIndex = self.clickedColumn;
    return (int)selectedIndex;
}

-(NSMutableArray*)_getRowIndexs{
    NSIndexSet* selectedIndexs = [self selectedRowIndexes];
    return [selectedIndexs _getIndexsArray];
}

-(NSMutableArray*)_getColumnIndexs{
    NSIndexSet*columnIndexes = [self selectedColumnIndexes];
    return [columnIndexes _getIndexsArray];
}


//nibを登録する
-(void)_registCell:(NSString*)nibName cellIdentifierName:(NSString*)cellIdentifierName{
    NSNib* nib = [[NSNib alloc] initWithNibNamed:nibName bundle:nil];
    [self registerNib:nib forIdentifier:cellIdentifierName];
}

-(NSTableCellView*)_loadCell:(NSString*)cellIdentifierName{
    NSTableCellView *cell = [self makeViewWithIdentifier:cellIdentifierName owner:self];
    return cell;
}



//viewDidAppearで

#pragma mark セパレーションをON
-(void)_setSepartionTableView:(BOOL)boolFlag{
    if(boolFlag){
        self.gridStyleMask = NSTableViewSolidVerticalGridLineMask | NSTableViewSolidHorizontalGridLineMask;
    }else{
        self.gridStyleMask = NSTableViewGridNone;
    }
}


-(void)_setSepartionZero{
    

}

-(void)_setSepartionZero:(int)leftMargin{
    
    
}


#pragma mark 指定したテーブルのセルの背景色を指定する
-(void)_setColor_visibleTable:(NSColor*)targetColor{
    self.backgroundColor = targetColor;
}


-(CGPoint)_getVisibleCell_point:(NSTableCellView*)cell{
    
    CGPoint point = CGPointMake(cell.frame.origin.x, cell.frame.origin.y);
    CGPoint offset =  CGPointMake(0.0, 0.0);
    CGFloat x = point.x - offset.x;
    CGFloat y = point.y - offset.y;
    
    return CGPointMake(x, y);
    
}


-(void)_sepalter_zero:(NSString*)color{
    
    if(color == nil || [color isEqual:@""]){
        color = @"c8c7cc";
    }
    
    [self _setSepartionZero];
    
  //  self.gridColor = [color _getUIColorFromHex];
    //[[NSTableView appearance] setSeparatorColor:[color _getUIColorFromHex]];
    
    self.gridStyleMask = NSTableViewSolidVerticalGridLineMask | NSTableViewSolidHorizontalGridLineMask;
    
}


//rootに移動する
-(void)_moveRoot{
    [self scrollRowToVisible:0];
    [self scrollColumnToVisible:0];
}


-(void)_isSeparatorStyle:(BOOL)boolFlag{
    
    if(boolFlag){
        self.gridStyleMask = NSTableViewSolidVerticalGridLineMask | NSTableViewSolidHorizontalGridLineMask;
    }else{
        self.gridStyleMask = NSTableViewGridNone;
    }
    
}


/*
 -(void)_checkCell:(NSIndexPath*)indexPath{
 
 NSTableCellView *selectedRow = [self viewAtColumn:0 row:indexPath.index makeIfNecessary:YES];
 
 //   NSTableCellView *selectedRow = [self viewAtColumn:0 row:indexPath.index makeIfNecessary:YES];
 
 //indexPath getIndexes:<#(nonnull NSUInteger *)#>
 
 NSTableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
 
 cell.accessoryType = NSTableViewCellAccessoryCheckmark;
 
 }
 -(void)_cellCheckAllReset:(NSIndexPath*)indexPath{
 
 NSArray*cellArray = [self visibleCells];
 for(UITableViewCell*cell in cellArray){
 cell.accessoryType = UITableViewCellAccessoryNone;
 }
 }
 //セル選択した時に非表示にする
 +(void)_cellBlue_turnOff:(NSTableView*)tableView indexPath:(NSIndexPath*)indexPath{
 [tableView deselectRowAtIndexPath:indexPath animated:YES];
 }
 */
//MECategoryTableViewCell *cell = [tableView makeViewWithIdentifier:@"category_" owner:self];

@end
