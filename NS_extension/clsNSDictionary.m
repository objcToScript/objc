
#import "clsFile.h"
#import "clsNSDictionary.h"

@implementation NSDictionary (extension)

- (NSString*)_toString
{
    return [NSString stringWithFormat:@"%@", self];
}

- (BOOL)_containsDic:(id)dic2
{
    for (NSString* key in [self allKeys]) {
        if ([[self objectForKey:key] isEqualToDictionary:dic2]) {
            return YES;
        }
    }
    return NO;
}

- (NSString*)_getKey_one
{
    NSArray* keys = [self allKeys];
    if (keys != nil && [keys count] > 0) {
        return [keys objectAtIndex:0];
    }
    return @"";
}

//シリアライズ
- (NSData*)_toNSPropertyData_from_JsonDic
{

    if (![NSPropertyListSerialization propertyList:self isValidForFormat:NSPropertyListXMLFormat_v1_0]) {
        NSLog(@"can't save as XML");
        return nil;
    }

    NSData* siriData = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:NSJSONReadingMutableContainers error:nil];

    return siriData;
}

- (void)_saveJson_ProjectFile_fromPath:(NSString*)filePath
{

    NSData* siriData = [self _toNSPropertyData_from_JsonDic];

    if (siriData != nil) {
        [clsFile _saveData:siriData filePath:filePath];
    } else {
        NSLog(@" 保存失敗　");
    }
}

//シリアライズ
- (NSData*)_toData
{

    NSData* myData = [NSKeyedArchiver archivedDataWithRootObject:self];
    return myData;
}

- (NSString*)_toJson
{
    NSError* error;

    id dic = self;

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

+ (NSDictionary*)_dicToDic_merge:(NSDictionary*)dict1 with:(NSDictionary*)dict2
{
    NSMutableDictionary* result = [NSMutableDictionary dictionaryWithDictionary:dict1];

    [dict2 enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
        if (![dict1 objectForKey:key]) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary* newVal = [[dict1 objectForKey:key] _dicToDic_merge:(NSDictionary*)obj];
                [result setObject:newVal forKey:key];
            } else {
                [result setObject:obj forKey:key];
            }
        }
    }];

    return (NSDictionary*)[result mutableCopy];
}

- (NSDictionary*)_dicToDic_merge:(NSDictionary*)dict
{
    return [[self class] _dicToDic_merge:self with:dict];
}

@end
