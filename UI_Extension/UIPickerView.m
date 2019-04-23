
#import "UIPickerView.h"

@implementation UIPickerView (ex)

- (int)_getIndex
{
    return (int)[self selectedRowInComponent:0];
}

- (void)_reloadComponet
{
    [self reloadComponent:0];
}

- (void)_selectRowComponet:(int)index
{
    [self selectRow:index inComponent:0 animated:NO];
}

@end
