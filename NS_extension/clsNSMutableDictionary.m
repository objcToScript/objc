
#import "clsNSException.h"
#import "clsNSMutableDictionary.h"
#import "clsNSString.h"

@implementation NSMutableDictionary (ex)

- (NSMutableDictionary*)_concat:(NSMutableDictionary*)dic
{

    for (NSString* key in [dic allKeys]) {
        [self setObject:[dic objectForKey:key] forKey:key];
    }

    return self;
}

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

- (BOOL)_containsKey:(NSString*)key
{
    for (NSString* key2 in [self allKeys]) {
        if ([key2 isEqual:key]) {
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

- (void)_fetchDic:(NSMutableDictionary*)secondDic
{
    for (NSString* key in [secondDic allKeys]) {
        if ([[self allKeys] containsObject:key]) {
            [self setObject:[secondDic objectForKey:key] forKey:key];
        }
    }
}

- (void)_fetch_schema:(NSMutableArray*)schme addDic:(NSMutableDictionary*)addDic
{
    if (schme != nil) {
        for (NSString* key in schme) {
            if ([self objectForKey:key] == nil) {
                continue;
            }
            if ([addDic objectForKey:key] != nil) {
                [self setObject:[addDic objectForKey:key] forKey:key];
            }
        }
    }
}

- (void)_add:(NSString*)key value:(id)value
{
    [self setObject:value forKey:key];
}

#pragma mark jsonをstrに変換
- (NSString*)_jsonDicToStr
{

    id dict = self;
    if ([self isKindOfClass:[NSMutableDictionary class]]) {
        dict = [self copy];
    } else if ([self  isKindOfClass:[NSDictionary class]]) {
        dict = self;
    }

    NSError* error = nil;
    NSData* data = nil;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }

    if (error.localizedFailureReason != nil) {
        NSLog(@"  %@", error.localizedFailureReason);
    }

    return @"";
}

- (void)_saveUserSettingDic:(NSString*)fileName
{
    id dic_t = self;
    if ([self isKindOfClass:[NSDictionary class]]) {
        dic_t = [self mutableCopy];
    }

    NSError*error = nil;
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:dic_t requiringSecureCoding:YES error:&error];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:fileName];

    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSMutableDictionary*)_loadUserSettingDic:(NSString*)fileName
{
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:fileName];
    if (data == nil) {
        return nil;
    }
    
    NSError*error = nil;
    NSArray* arr = (NSArray*)[NSKeyedArchiver archivedDataWithRootObject:data requiringSecureCoding:YES error:&error];
 
    return [arr mutableCopy];
}

- (void)_deleteUsertSettingDic:(NSString*)fileName
{

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:fileName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString*)_arrayToJsonStr
{

    NSError* error = nil;
    NSData* data = [NSJSONSerialization dataWithJSONObject:self options:2 error:&error];
    NSString* jsonstr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    return jsonstr;
}

- (void)_sqlEscapeDic
{

    if ([self isKindOfClass:[NSMutableDictionary class]]) {

        for (NSString* key in [self allKeys]) {

            id a = [self objectForKey:key];

            if ([a isKindOfClass:[NSString class]]) {
                NSString* v = [a _sqlEscapeStr];
                [self setObject:v forKey:key];
            }
        }
    } else {
        NSLog(@"NSMutableDictionaryではない  %@", self);
    }
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

- (NSMutableArray*)_addObject:(NSString*)key
{

    if ([self objectForKey:key] == nil) {
        [self setObject:[[NSMutableArray alloc] init] forKey:key];
    }

    return [self objectForKey:key];
}

- (NSObject*)_jsonXPath:(NSString*)jsonXPath withAutoLable:(BOOL)withAutoLable
{

    if (withAutoLable) {
        NSString* substr = [jsonXPath substringFromIndex:([jsonXPath length] - 1)];

        if ([substr isEqual:@"/"]) {
            jsonXPath = [jsonXPath stringByAppendingString:@"label"];
        }
    }

    return [self jsonXPath:jsonXPath jsonObj:self];
}

#pragma mark jsonXPath
- (NSObject*)_jsonXPath:(NSString*)jsonXPath
{
    return [self jsonXPath:jsonXPath jsonObj:self];
}

- (NSObject*)jsonXPath:(NSString*)jsonXPath jsonObj:(NSObject*)currentNode
{
    @try {

        if (currentNode == nil) {
            return nil;
        }
        // we cannot go any further
        if (![currentNode isKindOfClass:[NSDictionary class]] && ![currentNode isKindOfClass:[NSArray class]]) {
            return currentNode;
        }

        if ([jsonXPath hasPrefix:@"/"]) {
            jsonXPath = [jsonXPath substringFromIndex:1];
        }

        NSString* currentKey = [[jsonXPath componentsSeparatedByString:@"/"] objectAtIndex:0];
        NSString* currentKey_ArrayStr = @"";

        NSObject* nextNode;

        // if dict -> get value
        if ([currentNode isKindOfClass:[NSDictionary class]]) {

            NSDictionary* currentDict = (NSDictionary*)currentNode;

            //[]のあるものは配列になる
            if ([currentKey _indexOf:@"["] != -1 && [currentKey _indexOf:@"]"] != -1) {
                NSArray* splitArray = [currentKey _split:@"["];

                int index = -1;
                //インデックスを取得する
                index = [[[splitArray objectAtIndex:1] _replace:@"]" replaceStr:@""] intValue];

                //カレントキーの更新
                currentKey_ArrayStr = [splitArray objectAtIndex:0];

                if ([currentDict objectForKey:currentKey_ArrayStr] != nil && ![[currentDict objectForKey:currentKey_ArrayStr] isEqual:@""]) {
                    nextNode = [currentDict objectForKey:currentKey_ArrayStr];

                    if ([nextNode isKindOfClass:[NSArray class]]) {
                        int i = 0;
                        for (id obj in (NSArray*)nextNode) {
                            if (index == i) {
                                nextNode = obj;
                                break;
                            }
                            i++;
                        }
                    }
                }

                //  []があるなら　それは arrayになる
                // その場合 []を取る　数字を取る
                // 名前で参照し arraryとする
                //そのインデックスを取る

            } else if ([currentDict objectForKey:currentKey] != nil && ![[currentDict objectForKey:currentKey] isEqual:@""]) {
                nextNode = [currentDict objectForKey:currentKey];
            } else {
                nextNode = @""; //[currentDict objectForKey:currentKey];
            }
        }

        NSMutableArray* hitArray = [[NSMutableArray alloc] init];

        if ([currentNode isKindOfClass:[NSArray class]]) {
            // current key must be an number
            NSArray* currentArray = (NSArray*)currentNode;
            if ([currentArray count] > 0) {
                for (id dic in currentArray) {
                    if ([dic isKindOfClass:[NSDictionary class]]) {
                        NSDictionary* dic_t = (NSDictionary*)dic;

                        if ([dic_t objectForKey:currentKey_ArrayStr] != nil && ![[dic_t objectForKey:currentKey_ArrayStr] isEqual:@""]) {

                            [hitArray addObject:[dic_t objectForKey:currentKey_ArrayStr]];

                        } else if ([dic_t objectForKey:currentKey] != nil && ![[dic_t objectForKey:currentKey] isEqual:@""]) {

                            [hitArray addObject:[dic_t objectForKey:currentKey]];

                        } else {
                            [hitArray addObject:@""];
                        }
                    } else if ([dic isKindOfClass:[NSArray class]]) {
                        [hitArray addObject:dic];
                    }
                }
            }

            nextNode = [hitArray copy]; //NSArray
        }

        // remove the currently processed key from the xpath like path
        NSString* nextXPath = [jsonXPath stringByReplacingCharactersInRange:NSMakeRange(0, [currentKey length]) withString:@""];

        if ([nextXPath isEqual:@""] || nextXPath == nil) {
            return nextNode;
        }

        // call recursively with the new xpath and the new Node
        return [self jsonXPath:nextXPath jsonObj:nextNode];

    } @catch (NSException* exception) {
        printf("Json解析エラー");
        NSLog(@"%@", exception.description);
        //
    }

    return nil;
}

@end
