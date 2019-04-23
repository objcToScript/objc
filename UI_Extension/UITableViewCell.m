
#import "UITableViewCell.h"

@implementation UITableViewCell (ex)

- (void)_setBackGround:(int)color
{
    /*
 willDisplayCellに記述すること
 - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor whiteColor];
 }
 */
}

- (void)_setSelectionStyleNone
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)_setSelectionStyleBlue
{
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
}
- (void)_setSelectionStyleGray
{
    self.selectionStyle = UITableViewCellSelectionStyleGray;
}

- (void)_setSepartionCell:(int)leftMargin
{

    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0, leftMargin, 0, 0)];
    }

    // Prevent the cell from inheriting the Table View's margin settings
    if ([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [self setPreservesSuperviewLayoutMargins:NO];
    }

    // Explictly set your cell's layout margins
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0, leftMargin, 0, 0)];
    }
}

- (void)_checkCell:(NSMutableDictionary*)dic v0:(NSString*)v0
{
    [dic setObject:@"1" forKey:v0];
}

- (void)_unCheckCell:(NSMutableDictionary*)dic v0:(NSString*)v0
{
    [dic setObject:@"0" forKey:v0];
}

@end
