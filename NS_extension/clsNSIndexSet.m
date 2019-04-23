
#import "clsNSIndexSet.h"

@implementation NSIndexSet (extension)

- (NSMutableArray*)_getIndexsArray
{

    NSMutableArray* array = [NSMutableArray new];

    NSUInteger indexValue;
    // 最初のインデックス値を取得します。
    indexValue = self.firstIndex;
    // ここから、最後の値を取得し終えるまで、繰り返し値を取得して行きます。
    while (indexValue != NSNotFound) {
        // ここで取得したインデックス値に対する処理を行います。
        // 取得したインデックス値をもとに、その次のインデックス値を取得します。
        indexValue = [self indexGreaterThanIndex:indexValue];
        [array addObject:[NSNumber numberWithUnsignedInteger:indexValue]];
    }

    return array;
}

@end
