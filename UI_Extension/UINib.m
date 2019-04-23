
#import "UINib.h"

@implementation UINib (ex)

+ (UINib*)_getNib:(NSString*)name
{

    UINib* nib = [UINib nibWithNibName:name bundle:nil];

    return nib;
}

- (UIView*)_getView:(NSString*)reuseIdentifierId
{

    NSArray* cellTemplateArray = [self instantiateWithOwner:nil options:nil];

    for (UIView* view in cellTemplateArray) {

        if ([view.restorationIdentifier isEqual:reuseIdentifierId]) {
            return view;
        }
        if ([view isKindOfClass:[UIView class]] && [[view subviews] count] > 0) {
            UIView* con = [self _getView_do:view reuseIdentifierId:reuseIdentifierId];
            if (con != nil) {
                return con;
            }
        }
    }

    return nil;
}

- (UIView*)_getView_do:(UIView*)views reuseIdentifierId:(NSString*)reuseIdentifierId
{

    NSArray* cellTemplateArray = [views subviews];

    for (UIView* view in cellTemplateArray) {

        if ([view.restorationIdentifier isEqual:reuseIdentifierId]) {
            return view;
        }
        if ([view isKindOfClass:[UIView class]] && [[view subviews] count] > 0) {
            UIView* con = [self _getView_do:view reuseIdentifierId:reuseIdentifierId];
            if (con != nil) {
                return con;
            }
        }
    }

    return nil;
}

- (UITableViewCell*)_getCell:(NSString*)cellIdentifierName
                     nibName:(NSString*)nibName
                    isRegist:(BOOL)isRegist
                   tableView:(UITableView*)tableView
{

    NSArray* cellTemplateArray = [self instantiateWithOwner:nil options:nil];

    if ([cellTemplateArray count] > 0) {
        UITableViewCell* cell = [cellTemplateArray objectAtIndex:0];
        if (isRegist && [[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
            [tableView registerNib:nibName forCellReuseIdentifier:cellIdentifierName];
        }
        return cell;
    }

    return nil;
}

@end
