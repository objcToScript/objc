
#import <UIKit/UIKit.h>

@interface UICollectionView (ex)

- (UICollectionViewCell*)_getCell:(NSIndexPath*)indexPath;

- (void)_reloadDataAndWait:(void (^)(void))waitBlock;

- (void)_checkCell:(NSIndexPath*)indexPath;

- (void)_unCheckCell:(NSIndexPath*)indexPath;

@end
