
#import <UIKit/UIKit.h>

@interface UINib (ex)

+ (UINib*)_getNib:(NSString*)name;

- (UIView*)_getView:(NSString*)reuseIdentifierId;

- (UITableViewCell*)_getCell:(NSString*)cellIdentifierName
                     nibName:(NSString*)nibName
                    isRegist:(BOOL)isRegist
                   tableView:(UITableView*)tableView;

@end
