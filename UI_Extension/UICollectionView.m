
#import "UICollectionView.h"

@implementation UICollectionView (ex)

- (UICollectionViewCell*)_getCell:(NSIndexPath*)indexPath
{
    UICollectionViewCell* cell = [self cellForItemAtIndexPath:indexPath];
    return cell;
}

- (void)_reloadDataAndWait:(void (^)(void))waitBlock
{
    [self reloadData]; //if subclassed then super. else use [self.tableView
    if (waitBlock) {
        waitBlock();
    }
}

- (void)_checkCell:(NSIndexPath*)indexPath
{

    UICollectionViewCell* cell = [self cellForItemAtIndexPath:indexPath];

    [cell setSelected:YES];

}

- (void)_unCheckCell:(NSIndexPath*)indexPath
{

    UICollectionViewCell* cell = [self cellForItemAtIndexPath:indexPath];
    [cell setSelected:NO];
}

@end
