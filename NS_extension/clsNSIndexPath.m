
#import "clsNSIndexPath.h"

@implementation NSIndexPath (extension)

#if TARGET_OS_IOS

+ (NSIndexPath*)_getNSIndexPath:(int)section row:(int)row
{

    NSIndexPath* pathIndex = [NSIndexPath indexPathForRow:row inSection:section];

    return pathIndex;
}

#endif

- (NSArray*)_allIndexes
{
    NSMutableArray* indexes = [NSMutableArray arrayWithCapacity:[self length]];
    for (NSInteger i = 0; i < [self length]; i++) {
        [indexes addObject:[NSNumber numberWithInteger:[self indexAtPosition:i]]];
    }
    return [indexes copy];
}

@end
