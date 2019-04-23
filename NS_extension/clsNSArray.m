#import "clsNSArray.h"

@implementation NSArray (ex)


-(void)_compare_asc:(NSString*)key func:(void (^)(NSArray*))func{
    
    __block NSArray*sortArray = [self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        id obj1_1 = [obj1 performSelector:NSSelectorFromString(key)];
        id obj2_2 = [obj2 performSelector:NSSelectorFromString(key)];
        
        NSComparisonResult result = [obj1_1 compare:obj2_2];
        //昇順
        if (result == NSOrderedAscending) return NSOrderedAscending;
        else if (result == NSOrderedDescending) return NSOrderedDescending;
        else return NSOrderedSame;
    }];
    
    func(sortArray);
}

-(void)_compare_desc:(NSString*)key func:(void (^)(NSArray*))func{
    
    __block NSArray*sortArray = [self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        id obj1_1 = [obj1 performSelector:NSSelectorFromString(key)];
        id obj2_2 = [obj2 performSelector:NSSelectorFromString(key)];
        
        NSComparisonResult result = [obj1_1 compare:obj2_2];
        //降順
        if (result == NSOrderedAscending) return NSOrderedDescending;
        else if (result == NSOrderedDescending) return NSOrderedAscending;
        else return NSOrderedSame;
        
    }];
    
    func(sortArray);
}

-(NSArray*)_sort{
    
    NSArray*array = [self sortedArrayUsingSelector:@selector(compare:)];
    
    return array;
}

- (NSMutableDictionary*)_to_dic_keyOnly
{

    NSMutableDictionary* dic = [NSMutableDictionary new];

    for (NSString* key in self) {
        [dic setObject:@"" forKey:key];
    }

    return dic;
}

//配列の要素をランダムにシャッフルする
- (NSArray*)_exchange
{

    NSMutableArray* array_copy = [self mutableCopy];

    int count = (int)[array_copy count];

    for (int i = count - 1; i > 0; i--) {
        int randomNum = arc4random() % i;
        [array_copy exchangeObjectAtIndex:i withObjectAtIndex:randomNum];
    }

    return [array_copy copy];
}

- (NSArray*)_slice:(NSUInteger)start length:(NSUInteger)length
{

    NSUInteger const N = self.count;

    if (N == 0) {
        return self;
    }

    // forgive
    if (start > N - 1)
        start = N - 1;
    if (start + length > N)
        length = N - start;

    return [self subarrayWithRange:NSMakeRange(start, length)];
}

- (NSMutableDictionary*)_toDic
{

    NSMutableDictionary* dic = [NSMutableDictionary new];

    int i = 0;
    for (id v in self) {
        if ([self _safeObjecAtIndex_Bool:i] &&
            [self _safeObjecAtIndex_Bool:i + 1]) {
            [dic setObject:[self objectAtIndex:i + 1] forKey:[self objectAtIndex:i]];
        }
        i++;
        i++;
    }
    return dic;
}

- (NSArray*)_reverse
{
    return self.reverseObjectEnumerator.allObjects;
}

//結合
- (NSArray*)_concat:(NSArray*)secondArray
{
    NSArray* newArray = [self arrayByAddingObjectsFromArray:secondArray];
    return newArray;
}

- (NSArray*)_deleteEmpty
{
    NSMutableArray* copyArray = [NSMutableArray new];
    for (NSObject* a in self) {
        if (a != nil) {
            if ([a isKindOfClass:[NSString class]]) {
                if (![((NSString*)a) isEqual:@""]) {
                    [copyArray addObject:a];
                }
            } else {
                [copyArray addObject:a];
            }
        }
    }

    return [copyArray copy];
}

- (BOOL)_containsDic:(id)dic2
{
    for (id dic in self) {
        if ([((NSDictionary*)dic) isEqualToDictionary:dic2]) {
            return YES;
        }
    }
    return NO;
}

- (NSArray*)_removeLength:(NSString*)str
{
    NSMutableArray* array = [NSMutableArray new];
    for (NSString* key in self) {
        if (![key isEqual:str]) {
            [array addObject:key];
        }
    }
    return [array copy];
}

- (NSArray*)_removeObjct:(int)index
{
    if ([self _safeObjecAtIndex_Bool:index]) {
        NSMutableArray* array_copy = [self mutableCopy];
        [array_copy removeObjectAtIndex:index];
        return [array_copy copy];
    }

    return self;
}

#pragma mark 結合
- (NSString*)_toJson
{
    NSError* error;

    id dic = [self copy];

    if ([NSJSONSerialization isValidJSONObject:dic]) {

        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                           options:0
                                                             error:&error];
        if (!jsonData) {
            NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
            return @"{}";
        } else {
            return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }

    NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);

    return @"{}";
}

#pragma mark 結合
- (NSString*)_join:(NSString*)str
{
    
    if (self.count == 0) {
        return @"";
    }

    NSString* joinedString = @"";

    if (str != nil && ![str isEqual:@""]) {
        joinedString = [[self copy] componentsJoinedByString:str];
    } else {
        joinedString = [[self copy] componentsJoinedByString:@""];
    }

    return joinedString;
}

#pragma mark
- (id)_safeObjectAtIndex:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self objectAtIndex:index];
}

#pragma mark
- (int)_searchAtIndex:(NSString*)word
{
    for (int i = 0; i < self.count; i++) {
        if ([word isEqual:[self objectAtIndex:i]]) {
            return i;
        }
    }
    return -1;
}

#pragma mark
- (int)_searchAtIndex_range:(NSString*)word
{
    for (int i = 0; i < self.count; i++) {
        NSRange range = [word rangeOfString:[self objectAtIndex:i]];
        if (range.length > 0) {
            return (int)range.location;
        }
    }
    return -1;
}

- (BOOL)_safeObjecAtIndex_Bool:(NSUInteger)index
{
    if (index >= self.count) {
        return NO;
    }
    return YES;
}

@end
