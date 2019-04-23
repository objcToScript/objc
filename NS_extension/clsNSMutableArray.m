
#import "clsNSMutableArray.h"

@implementation NSMutableArray (ex)

-(NSString*)_toString{
    
    NSString *str = [self componentsJoinedByString:@""];
    
    return str;
    
}

-(NSString*)_toStringWithLine{
    
    NSString *str = [self componentsJoinedByString:@"\n"];
    
    return str;
    
}

- (NSNumber*)_getMaxNum_from_Number
{

    NSNumber* largestNumber = [NSNumber numberWithInt:0];

    for (int i = 0; i < self.count; i++) {
        NSNumber* number = [self objectAtIndex:i];
        if ([largestNumber intValue] < [number intValue]) {
            largestNumber = number;
        }
    }

    return largestNumber;
}

- (NSMutableArray*)_insertFirst:(id)data
{

    NSMutableArray* mutableArray = [[NSMutableArray alloc] init];
    [mutableArray addObject:data];
    [mutableArray addObjectsFromArray:self];
    return mutableArray;
}

- (void)_removeObject:(int)index
{
    [self removeObjectAtIndex:index];
}

- (void)_setObject_from_Index:(NSInteger)index value:(id)value
{

    [self replaceObjectAtIndex:index withObject:value];
}

- (NSMutableArray*)_deleteEmpty
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

    return [copyArray mutableCopy];
}

//配列の要素をランダムにシャッフルする
- (void)_exchange
{
    int count = (int)[self count];

    for (int i = count - 1; i > 0; i--) {
        int randomNum = arc4random() % i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:randomNum];
    }
}

- (NSMutableArray*)_slice:(NSUInteger)start length:(NSUInteger)length
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

    return [[[self copy] subarrayWithRange:NSMakeRange(start, length)] mutableCopy];
}

- (NSMutableArray*)_reverse
{
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:self.count];
    for (id value in self.reverseObjectEnumerator) {
        [array addObject:value];
    }
    return array;
}

- (BOOL)_containsDic:(id)dic
{
    for (id dic in self) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            if ([((NSDictionary*)dic) isEqualToDictionary:dic]) {
                return YES;
            }
        }
    }
    return NO;
}

- (NSMutableArray*)_removeLength:(NSString*)str
{

    NSMutableArray* array = [NSMutableArray new];
    for (NSString* key in self) {
        if (![key isEqual:str]) {
            [array addObject:key];
        }
    }

    return array;
}

- (void)_deleteDataRowIndex:(int)index
{

    if ([self _safeObjectAtIndex:index]) {
        [self removeObjectAtIndex:index];
    }
}
- (void)_lastDeleteDataRow
{
    [self removeLastObject];
}

//DataRowを比較して削除する
- (NSMutableArray*)_deleteDataRow:(NSMutableDictionary*)deleteDic
{
    NSMutableArray* array = [self mutableCopy];
    int i = 0;
    for (id a in array) {
        if ([deleteDic isEqualToDictionary:a]) {
            [array removeObjectAtIndex:i];
        }
        i++;
    }
    return array;
}

- (id)_getRandValue
{
    if (self.count == 0) {
        return nil;
    }
    int randInt = arc4random_uniform((int)self.count);

    return [self objectAtIndex:randInt];
}

- (NSString*)_arrayToJson
{

    NSError* error;
    NSArray* myArray;
    if ([self isKindOfClass:[NSMutableArray class]]) {
        myArray = [self copy];
    } else {
        myArray = self;
    }

    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:myArray options:NSJSONWritingPrettyPrinted error:&error];

    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    return jsonString;
}

- (void)_saveArray:(NSString*)fileName
{
    id array_t;
    if ([self isKindOfClass:[NSArray class]]) {
        array_t = [self mutableCopy];
    }

    //NSData* data = [NSKeyedArchiver archivedDataWithRootObject:array_t];
    NSError*error = nil;
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:array_t requiringSecureCoding:YES error:&error];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:fileName];
}

+ (void)_saveUserSettingArray:(NSString*)fileName
{
    id array_t;
    if ([self isKindOfClass:[NSArray class]]) {
        array_t = [self mutableCopy];
    }
    
    NSError*error = nil;
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:array_t requiringSecureCoding:YES error:&error];

    //NSData* data = [NSKeyedArchiver archivedDataWithRootObject:array_t];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:fileName];
}

+ (NSMutableArray*)_loadUserSettingArray:(NSString*)fileName
{

    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:fileName];
    if (data == nil) {
        return [NSMutableArray new];
    }

   NSArray* arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    return [arr mutableCopy];
}

- (NSMutableArray*)_loadArray:(NSString*)fileName
{

    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:fileName];
    if (data == nil) {
        return nil;
    }

    NSArray* arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    return [arr mutableCopy];
}

#pragma mark arrayをソートする
- (NSMutableArray*)_sortNum:(BOOL)isAsc
{

    NSArray* array = [self copy];

    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:nil ascending:isAsc];
    NSArray* sortedArray = [array sortedArrayUsingDescriptors:@[ sortDescriptor ]];

    return [sortedArray mutableCopy];
}

#pragma mark sort
- (NSMutableArray*)_sort_dic:(NSString*)dicKey isAsc:(BOOL)isAsc
{
    //Numberはintを使うこと nsintegerは使わないこと

    //ソート対象となるメンバ変数をキーとして指定した、NSSortDescriptorの生成
    NSSortDescriptor* sortDescNumber;
    sortDescNumber = [[NSSortDescriptor alloc] initWithKey:dicKey ascending:isAsc];

    // NSSortDescriptorは配列に入れてNSArrayに渡す
    NSArray* sortDescArray;
    sortDescArray = [NSArray arrayWithObjects:sortDescNumber, nil];

    NSArray* data_t = [self copy];

    // ソートの実行
    NSArray* sortArray;
    sortArray = [data_t sortedArrayUsingDescriptors:sortDescArray];

    return [sortArray mutableCopy];
}

#pragma mark Json化
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

- (NSMutableArray*)_arrayUnique
{

    NSMutableArray* newArray = [[NSMutableArray alloc] init];

    for (id a in self) {
        if (![newArray containsObject:a]) {
            [newArray addObject:a];
        }
    }

    return newArray;
}

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

- (BOOL)_safeObjecAtIndex_Bool:(NSUInteger)index
{
    if (index >= self.count) {
        return NO;
    }
    return YES;
}

#pragma mark
- (id)_objectAtIndex:(int)index
{

    if (self == nil) {
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

#pragma mark
- (int)_searchContainsIndex:(NSString*)word
{
    for (int i = 0; i < self.count; i++) {
        if (word == [self objectAtIndex:i]) {
            return i;
        }
    }
    return -1;
}

@end
