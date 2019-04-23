#import <AppKit/AppKit.h>

@interface NSTableView (ex)

-(void)_setIndex_from_tableView:(int)index;
-(void)_setIndex_arrayCon;
-(void)_setIndex_arrayCon:(NSInteger)index;

-(BOOL)_isTargetTableColumn:(NSString*)keyPath;

-(NSTableColumn*)_getSelectedTableColumn;
-(id)_getDataRow;
-(NSMutableArray*)_getDataArray;

-(void)_deleteCell:(int)index;
-(void)_deleteCellMulti:(NSMutableArray*)indexArray;
-(void)_goToIndex:(NSIndexSet*)indexSet;
-(int)_getCount;
-(void)_setSelect:(int)index;
-(void)_cellSelectionSelected_indexPath:(int)index;

-(NSTextFieldCell*)_getCell_TextFieldCell;
-(NSTableCellView*)_getCell_TableCellView;

-(int)_getRowIndex;
-(int)_getColumnIndex;
-(NSMutableArray*)_getRowIndexs;
-(NSMutableArray*)_getColumnIndexs;
-(NSTableCellView*)_loadCell:(NSString*)cellIdentifierName;

//テーブルの　 viewDidLoadで設定すること
//テーブルセルの分割線を長さを指定する
-(void)_setSepartionZero;
-(void)_setSepartionZero:(int)leftMargin;
-(void)_setSepartionTableView:(BOOL)boolFlag;

//指定したテーブルの表示されているセルのみ背景色を指定する
-(void)_setColor_visibleTable:(NSColor*)targetColor;

//セルの座標を取得する
-(CGPoint)_getVisibleCell_point:(NSTableCellView*)cell;

//テーブルセルの分割線を左まで描画する
-(void)_sepalter_zero:(NSString*)color;

//rootに移動する
-(void)_moveRoot;

//SeparatorStyleを設定する
-(void)_isSeparatorStyle:(BOOL)boolFlag;

-(void)_registCell:(NSString*)nibName cellIdentifierName:(NSString*)cellIdentifierName;




@end









