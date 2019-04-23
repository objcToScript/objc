
#import "UITableView.h"

@implementation UITableView (ex)

/*
 [self.tableView _reloadDataAndWait:^{
 //call the required method here
 }];
 */
- (void)_reloadDataAndWait:(void (^)(void))waitBlock
{
    [self reloadData]; //if subclassed then super. else use [self.tableView
    if (waitBlock) {
        waitBlock();
    }
}

- (void)_registClassCell:(Class) class cellIdentifier:(NSString*)cellIdentifier
{
    //nibファイルのみ使用できる
    //storyboardは使うとエラー
    //traingCell *cell = (traingCell*)[tableView dequeueReusableCellWithIdentifier:@"traingCell" forIndexPath:indexPath];

    //forIndexPathが必要
    [self registerClass:class forCellReuseIdentifier:cellIdentifier];
}

    //viewDidAppearで
    - (void)_deleteSellection : (int)index
{

    [self beginUpdates];
    [self deleteSections:[NSIndexSet indexSetWithIndex:index]
        withRowAnimation:UITableViewRowAnimationNone];
    [self endUpdates];
}

//viewDidAppearで
- (void)_deleteStaticCell:(NSMutableArray*)intArray section:(int)section
{

    if (intArray == nil || [intArray count] == 0) {
        return;
    }

    NSMutableArray* array = [[NSMutableArray alloc] init];

    for (NSNumber* value in intArray) {
        NSIndexPath* pathIndex = [NSIndexPath indexPathForRow:[value intValue] inSection:section];
        [array addObject:pathIndex];
    }
    [self beginUpdates];
    [self deleteRowsAtIndexPaths:[array copy]
                withRowAnimation:UITableViewRowAnimationNone];
    [self reloadSections:[NSIndexSet indexSetWithIndex:section]
        withRowAnimation:UITableViewRowAnimationFade]; // 「なし」を表示
    [self endUpdates];
}

#pragma mark セパレーションをON
- (void)_setSepartionTableView:(BOOL)boolFlag
{

    if (boolFlag) {
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    } else {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

- (void)_setSepartionZero
{

    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }

    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)_setSepartionZero:(int)leftMargin
{

    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0, leftMargin, 0, 0)];
    }

    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0, leftMargin, 0, 0)];
    }
}

#pragma mark 指定したテーブルのセルの背景色を指定する
- (void)_setColor_visibleTable:(UIColor*)targetColor
{

    if (self == nil) {
        return;
    }

    NSArray* cellArray = [self visibleCells];
    for (UITableViewCell* cell in cellArray) {
        cell.backgroundColor = targetColor == nil ? [UIColor whiteColor] : targetColor;
    }
}

- (CGPoint)_getVisibleCell_point:(UITableViewCell*)cell
{

    CGPoint point = CGPointMake(cell.frame.origin.x, cell.frame.origin.y);
    CGPoint offset = self.contentOffset;
    CGFloat x = point.x - offset.x;
    CGFloat y = point.y - offset.y;

    return CGPointMake(x, y);
}

- (UITableViewCell*)_getCell:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [self cellForRowAtIndexPath:indexPath];
    return cell;
}

- (void)_checkCell:(NSIndexPath*)indexPath
{

    UITableViewCell* cell = [self cellForRowAtIndexPath:indexPath];

    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (void)_cellCheckAllReset:(NSIndexPath*)indexPath
{

    NSArray* cellArray = [self visibleCells];
    for (UITableViewCell* cell in cellArray) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)_sepalter_zero:(NSString*)color
{

    if (color == nil || [color isEqual:@""]) {
        color = @"c8c7cc";
    }

    [self _setSepartionZero];

    self.separatorColor = [color _getUIColorFromHex];
    [[UITableView appearance] setSeparatorColor:[color _getUIColorFromHex]];

    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

//nibを登録する
- (void)_registCell:(NSString*)nibName cellIdentifierName:(NSString*)cellIdentifierName
{

    UINib* nib = [UINib nibWithNibName:nibName bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:cellIdentifierName];
}

//セル選択した時に非表示にする
- (void)_cellSelectionSelected_indexPath:(NSIndexPath*)indexPath
{
    [self deselectRowAtIndexPath:indexPath animated:YES];
}

//セル選択した時に非表示にする
- (void)_cellSelectionSelected:(NSMutableDictionary*)indexInfoArray
{

    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:[[indexInfoArray objectForKey:@"indexRow"] intValue] inSection:[[indexInfoArray objectForKey:@"sectionInt"] intValue]];

    [self deselectRowAtIndexPath:indexPath animated:YES];
}

//rootに移動する
- (void)_moveRoot:(BOOL)isAnime
{

    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:isAnime];
}

//Bottomに移動する
- (void)_moveBottom:(BOOL)isAnime
{

    int section = (int)[self numberOfSections] - 1;
    int row = (int)[self numberOfRowsInSection:section] - 1;
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:isAnime];
}

- (void)_goToIndex:(NSIndexPath*)indexPath
{

    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)_isSeparatorStyle:(BOOL)boolFlag
{

    if (boolFlag) {
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    } else {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

+ (void)_cellBlue_turnOff:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
