
#import <Cocoa/Cocoa.h>

@interface NSMatrix (ex)


-(void)_addRow;
-(void)_addRowsWithTexts:(NSMutableArray*)array;

-(void)_setSelectedIndex:(NSMutableArray*)array;
-(void)_setSelectedValues:(NSMutableArray*)array;

-(void)_removeAllRow;
-(void)_removeAtRow:(int)index;



    -(NSCell*)_getSelectedCell;

    -(NSInteger)_getSelectedIndex;

    -(id)_getBindingRow:(id)array;

    -(void)_selectCell:(NSInteger)row column:(NSInteger)col;

    -(void)_setBindingRow:(id)array model:(id)model keyPath:(NSString*)keyPath;

    -(id)_getBindingRow_Value:(id)array keyPath:(NSString*)keyPath;


@end
