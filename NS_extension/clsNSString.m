#import "clsFile.h"
#import "clsNSData.h"
#import "clsNSDictinary+deepCopy.h"
#import "clsNSDictionary.h"
#import "clsNSString.h"

#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access

@implementation NSString (ex)

- (NSString*)_getLastWord{
    
    if([self isEqual:@""] ){
        return @"";
    }
    
    int length = (int)[self length];
    
    NSString *str = [self substringFromIndex:(length-1)];
    return str;
}

- (BOOL)_isLastNumStr{

    BOOL bl = [[self _getLastWord] _isNum];
    return bl;
    
}

- (BOOL)_isLastStr:(NSString*)searchWord{
    
    BOOL bl = [self hasSuffix:searchWord];
    return bl;
    
}

- (BOOL)_isFirstStr:(NSString*)searchWord{
    
    BOOL bl = [self hasPrefix:searchWord];
    return bl;
    
}

- (BOOL)_isDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyyMMdd";
    dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    NSString*str = [self _replace:@":" replaceStr:@""];
    str = [str _replace:@"/" replaceStr:@""];
    
    NSDate *date = [dateFormatter dateFromString:str];
    
    if(date != nil){
        return YES;
    }
    return NO;
}

- (BOOL)_isNum{

    NSRange match = [self rangeOfString:@"^[0-9]+$" options:NSRegularExpressionSearch];
    //数値の場合
    if(match.location != NSNotFound) {
        return YES;
    }
    
    return NO;
}

- (BOOL)_isFloat{    
    if([self _indexOf:@"."] != -1){
        return YES;
    }
    return NO;
}

- (BOOL)_isBool{
    
    NSString*str = [self lowercaseString];

    if([str isEqual:@"yes"] || [str isEqual:@"no"] || [str isEqual:@"true"] || [str isEqual:@"false"]){
        return YES;
    }
    
    return NO;
}

- (BOOL)isNotEmpty
{
    if (self.length > 0) {
        return YES;
    }
    return NO;
}


- (NSAttributedString*)_to_AttributedString
{
    return [[NSAttributedString alloc] initWithString:self];
}

- (NSString*)_getMaruKako_methodStr
{

    int hitCount = 0;
    BOOL hitFlag = NO;
    NSMutableString* strM = [NSMutableString string];

    for (int i = 0; i < [self length]; i++) {

        NSRange range = NSMakeRange(i, 1);
        NSString* word = [self substringWithRange:range];

        [strM appendString:word];
        if ([word isEqual:@"("]) {
            hitCount++;
        }
        if ([word isEqual:@")"]) {
            hitFlag = YES;
            hitCount--;
        }
        if (hitCount == 0 && hitFlag) {
            break;
        }
    }

    NSString* str1 = [NSString stringWithString:strM];
    return str1;
}

- (NSString*)_getKako_methodStr
{

    int hitCount = 0;
    BOOL hitFlag = NO;
    NSMutableString* strM = [NSMutableString string];

    for (int i = 0; i < [self length]; i++) {

        NSRange range = NSMakeRange(i, 1);
        NSString* word = [self substringWithRange:range];

        [strM appendString:word];
        if ([word isEqual:@"{"]) {
            hitCount++;
        }
        if ([word isEqual:@"}"]) {
            hitFlag = YES;
            hitCount--;
        }
        if (hitCount == 0 && hitFlag) {
            break;
        }
    }

    NSString* str1 = [NSString stringWithString:strM];
    return str1;
}

//文字を1文字ずつ配列に入れる
- (NSArray*)_splitCharacterEvery:(NSUInteger)splitNum
{
    if ([self length] <= splitNum) {
        return @[ self ];
    }

    NSMutableArray* mArray = [NSMutableArray new];
    NSMutableString* mStr = [NSMutableString stringWithString:self];

    NSRange range = NSMakeRange(0, splitNum);

    while ([mStr length] > 0) {
        if ([mStr length] < splitNum) {
            [mArray addObject:[NSString stringWithString:mStr]];
            [mStr deleteCharactersInRange:NSMakeRange(0, [mStr length])];
        } else {
            [mArray addObject:[mStr substringWithRange:range]];
            [mStr deleteCharactersInRange:range];
        }
    }

    return [NSArray arrayWithArray:mArray];
}

- (void)_saveReXml_ProjectFile_fromPath
{

    NSData* siriData = [self _toData_fromPath];

    if ([siriData _isOpenStepFormat_from_NSPropertyList]) {

        NSString* formatStr;
        NSDictionary* dic = [siriData _toDic_from_NSPropertyList:&formatStr];

        NSData* sirialData = [dic _toNSPropertyData_from_JsonDic];

        [clsFile _saveData:sirialData filePath:self];
    }
}

- (NSDictionary*)_getJson_ProjectFile_fromPath
{

    NSData* siriData = [self _toData_fromPath];

    NSString* formatStr;
    NSDictionary* dic = [siriData _toDic_from_NSPropertyList:&formatStr];

    NSString* jsonStr = [dic _toJson];

    NSMutableDictionary* jsonDic = [jsonStr _jsonStrToDic];

    jsonDic = [jsonDic mutableDeepCopy];

    return jsonDic;
}

- (void)_saveNSUserText:(NSString*)fileName
{
    NSString* saveContent = self;
    if (saveContent == nil) {
        saveContent = @"";
    }

    [[NSUserDefaults standardUserDefaults] setObject:saveContent forKey:fileName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString*)_loadNSUserText:(NSString*)fileName
{

    NSString* fileContent = [[NSUserDefaults standardUserDefaults] objectForKey:fileName];

    if (fileContent != nil) {
        return fileContent;
    }

    return @"";
}

- (NSString*)_randomString:(int)kestaNum
{
    NSString* str = @"";
    for (int i = 0; i < kestaNum; i++) {
        arc4random_uniform(9);
        int num = arc4random_uniform(9);
        NSString* numStr = [[NSNumber numberWithInt:num] stringValue];
        str = [str stringByAppendingString:numStr];
    }
    return str;
}

- (NSString*)_add:(NSString*)list, ...
{
    NSMutableString* res = [NSMutableString string];
    [res appendString:list];

    va_list args;
    va_start(args, list);
    id arg = nil;

    while ((arg = va_arg(args, id))) {
        if ([arg isKindOfClass:[NSNumber class]]) {
            [res appendString:[((NSNumber*)arg)stringValue]];
        } else {
            [res appendString:arg];
        }
    }

    va_end(args);

    return [NSString stringWithFormat:@"%@%@", self, res];
}

#pragma mark addStr
- (NSString*)_addStr:(NSString*)str
{
    return [self stringByAppendingString:str];
}

- (NSArray*)_getPathArray_fromPath
{
    return [self pathComponents];
}

- (NSString*)_getFileExtension_fromPath
{
    return [self pathExtension];
}

- (NSString*)_replaceFileExtension_fromPath:(NSString*)extension
{

    NSString* oldExtension = [@"." _add:[self pathExtension], nil];
    NSString* newExtension = [@"." _add:extension, nil];
    NSString* newPath = [self _replace:oldExtension replaceStr:newExtension];
    return newPath;
}

- (NSString*)_getFileName_NoExtension_fromPath
{
    return [[self lastPathComponent] stringByDeletingPathExtension];
}

- (NSString*)_getFileName_NoPlus_fromPath
{
    NSString* fileName = [self lastPathComponent];
    if ([fileName _indexOf:@"+"] != -1) {
        NSArray* array = [fileName _split:@"+"];
        if ([array count] > 0) {
            NSString* fileNoPlusName = [@"" _add:[array objectAtIndex:0], @".", [[array objectAtIndex:1] pathExtension], nil];
            return fileNoPlusName;
        }
    }
    return fileName;
}

- (NSString*)_getCategoryName_NoFileName_fromPath
{
    NSString* fileName = [self lastPathComponent];
    if ([fileName _indexOf:@"+"] != -1) {
        NSArray* array = [fileName _split:@"+"];
        if ([array count] > 0) {
            return [array objectAtIndex:1];
        }
    }
    return @"";
}

- (NSString*)_getFileName_NoExtension_NoPlus_fromPath
{
    NSString* fileName = [self lastPathComponent];
    if ([fileName _indexOf:@"+"] != -1) {
        NSArray* array = [fileName _split:@"+"];
        if ([array count] > 0) {
            return [[array objectAtIndex:0] _getFileName_noPath_noExtension];
        }
    }

    return [fileName _getFileName_noPath_noExtension];
}

- (NSString*)_getReplaceFilePath_fromPath:(NSString*)fileName
{
    NSString*filePath_new = [self _replace:[self _getFileName_fromPath] replaceStr:fileName];

    return filePath_new;
}



- (NSString*)_getFilePath_FileNameNoExtension_fromPath
{

    NSString* filePath = [self _getDirPath_fromPath];

    NSString* fileName = [self _getFileName_NoExtension_NoPlus_fromPath];

    NSString* filePath_FileNameNoExtension = [@"" _add:filePath, @"/", fileName, nil];

    return filePath_FileNameNoExtension;
}

- (NSString*)_getDirPath_fromPath
{
    return [self stringByDeletingLastPathComponent];
}

- (NSString*)_getDirName_fromPath
{

    NSString* dirPath = @"";
    NSArray* dirsArray = nil;

    BOOL isFile = [clsFile _isFile:self];
    BOOL isDir = [clsDirectory _isDirectory:self];

    NSString* pathExension = [self pathExtension];

    if (isFile && ![pathExension isEqual:@""]) {
        dirPath = [self stringByDeletingLastPathComponent];
        dirsArray = [dirPath pathComponents];
    } else if (isDir) {
        dirsArray = [self _split:@"/"];
    } else {
        dirsArray = [self pathComponents];
    }

    dirsArray = [dirsArray _deleteEmpty];

    dirsArray = [dirsArray _removeLength:@"/"];

    if ([dirsArray count] > 0) {
        return [dirsArray objectAtIndex:dirsArray.count - 1];
    }
    return @"";
}

//一個上のDir
- (NSString*)_getParentDirPath_fromPath
{

    NSString* dirPath = @"";
    NSArray* dirsArray = nil;

    BOOL isFile = [clsFile _isFile:self];
    BOOL isDir = [clsDirectory _isDirectory:self];

    NSString* pathExension = [self pathExtension];

    if (isFile && ![pathExension isEqual:@""]) {
        dirPath = [self stringByDeletingLastPathComponent];
        dirsArray = [dirPath pathComponents];

    } else if (isDir) {
        dirsArray = [self _split:@"/"];
    } else {
        dirsArray = [self pathComponents];
    }

    dirsArray = [dirsArray _deleteEmpty];

    dirsArray = [dirsArray _removeObjct:(int)[dirsArray count] - 1];

    NSString* margeUrl = [dirsArray _join:@"/"];

    return [@"/" _add:margeUrl, nil];
}

- (NSString*)_getCategoryFilePath_fromPath:(NSString*)categoryFileName isHFile:(BOOL)isHFile
{
    
    NSString*motoFileName = [self _getFileName_fromPath];
    NSString*fileName_new = [motoFileName _replace:@".h" replaceStr:@""];
    fileName_new = [fileName_new _replace:@".m" replaceStr:@""];
    fileName_new = [fileName_new _replace:@".swift" replaceStr:@""];

    NSString*extension = isHFile ? @".h" : @".m";

    return [self _replace:motoFileName replaceStr:[@"" _add:fileName_new,@"+",categoryFileName,extension,nil]];

}

- (NSString*)_getFileName_fromPath
{
    return [self lastPathComponent];
}

- (NSString*)_renameFilePath_fromPath:(NSString*)replaceValue_old
                     replaceValue_new:(NSString*)replaceValue_new
{

    NSMutableArray* pathArray = [[self _split:@"/"] mutableCopy];

    pathArray = [pathArray _deleteEmpty];

    NSString* fileName = [pathArray objectAtIndex:[pathArray count] - 1];

    fileName = [fileName _replace:replaceValue_old replaceStr:replaceValue_new];

    [pathArray _setObject_from_Index:[pathArray count] - 1 value:fileName];

    NSString* path_new = [pathArray _join:@"/"];

    return [@"/" _add:path_new, nil];
}

//no どっと
- (NSString*)_replaceExtension_fromPath:(NSString*)extension
{
    NSString* path = [[self stringByDeletingPathExtension] stringByAppendingPathExtension:extension];
    return path;
}

- (NSString*)_renameLastName_fromPath:(NSString*)newFileName
{
    NSString* oldFileName = [self lastPathComponent];
    NSString* newFilePath = [self _replace:oldFileName replaceStr:newFileName];
    return newFilePath;
}

- (NSString*)_getSentouStr:(int)length
{

    if (self == nil) {
        return @"";
    }
    if ([self isEqual:@""]) {
        return self;
    }
    if (length > [self length] - 1) {
        return self;
    }
    return [self substringToIndex:length];
}

- (NSString*)_getKouhouStr:(int)length
{

    if (self == nil) {
        return @"";
    }
    if ([self isEqual:@""]) {
        return self;
    }

    if (length > [self length] - 1) {
        return self;
    }
    return [self substringFromIndex:length];
}

- (NSString*)_getFileName_noPath_noExtension
{

    if ([self _indexOf:@"."] != -1) {
        NSArray* array = [self _split:@"."];
        if ([array count] > 0) {
            return [array objectAtIndex:0];
        }
        return self;
    }
    return self;
}

- (BOOL)_isExits
{
    if (self != nil && ![self isEqual:@""]) {
        return YES;
    }
    return NO;
}

#pragma mark 文字列をNSDateにする
- (NSDate*)_getStrToNSDate
{

    //NSString* dateString = @"2014-09-14 15:45:00";

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //タイムゾーンの指定
    //[formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

    NSDate* date = [formatter dateFromString:self];

    return date;
}

#pragma mark 文字列をNSDateにする
- (NSDate*)_getStrToNSDate:(NSString*)formatStr
{

    if (formatStr == nil || [formatStr isEqual:@""]) {
        formatStr = @"yyyy-MM-dd HH:mm:ss";
    }

    //NSString* dateString = @"2014-09-14 15:45:00";

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatStr];
    //タイムゾーンの指定
    // [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

    NSDate* date = [formatter dateFromString:self];

    return date;
}

- (unsigned int)_getNumberFromHex:(int)from
{
    NSString* hexString = [self substringWithRange:NSMakeRange(from, 2)];
    NSScanner* hexScanner = [NSScanner scannerWithString:hexString];
    unsigned int intColor;
    [hexScanner scanHexInt:&intColor];
    return intColor;
}

#pragma mark urlEncode
- (NSString*)_urlEncode
{

    NSString* urlEncode = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];

    return urlEncode;
}

#pragma mark urlDecode
- (NSString*)_urlDecode
{
    NSString* decodedUrlString = [self stringByRemovingPercentEncoding];
    return decodedUrlString;
}

- (id)_jsonToArray
{

    NSData* jsonData = [self dataUsingEncoding:NSUnicodeStringEncoding];

    NSError* error;
    id array = [NSJSONSerialization JSONObjectWithData:jsonData
                                               options:NSJSONReadingAllowFragments
                                                 error:&error];

    return array;
}

#pragma mark nsnumberをstrに変換する
- (NSString*)_numberToStr:(NSString*)str
{

    if ([str isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@", (NSNumber*)str];
    }

    return str;
}

//jsonをarrayに変換
- (NSMutableDictionary*)_jsonStrToArray
{

    NSData* jsonData = [self dataUsingEncoding:NSUnicodeStringEncoding];
    NSError* error;
    id array = [NSJSONSerialization JSONObjectWithData:jsonData
                                               options:NSJSONReadingAllowFragments
                                                 error:&error];

    if (error.localizedFailureReason != nil) {
        NSLog(@"  %@", error.localizedFailureReason);
    }

    return [array mutableCopy];
}

//jsonをDicに変換
- (NSMutableDictionary*)_jsonStrToDic
{
    //NSString *json = @"{\"name\":\"fkm\"}";
    NSData* jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];

    NSError* error = nil;
    NSDictionary* jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingAllowFragments
                                                              error:&error];
    if (error != nil) {
        NSLog(@"failed to parse Json %ld", error.code);
        return nil;
    }

    return [jsonDic mutableCopy];
}

- (NSString*)_getDirPath
{

    NSString* path = self.stringByDeletingLastPathComponent;

    return path;
}

- (NSString*)_canma_split
{

    if (self == nil || [self isEqual:@""]) {
        return @"";
    }

    NSNumber* number = [NSNumber numberWithInt:[self intValue]];
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@",###"];
    return [formatter stringForObjectValue:number];
}

- (NSString*)_removeKaigyou
{

    __block NSMutableArray* lines = [NSMutableArray array];
    [self enumerateLinesUsingBlock:^(NSString* line, BOOL* stop) {
        [lines addObject:line];
    }];

    NSString* renketu_string = [lines componentsJoinedByString:@""];

    return renketu_string;
}

- (NSMutableArray*)_split_Kaigyou
{

    __block NSMutableArray* lines = [NSMutableArray array];
    [self enumerateLinesUsingBlock:^(NSString* line, BOOL* stop) {
        [lines addObject:line];
    }];
    return lines;
}

- (NSString*)_xmlEscapeEncode
{

    NSMutableDictionary* escapeArray = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                                @"&amp;", @"&",
                                                                @"&quot;", @"\"",
                                                                @"&apos;", @"'",
                                                                @"&lt;", @"<",
                                                                @"&gt;", @">",
                                                                @"&yen;", @"¥",
                                                                @"＼", @"\\",

                                                                nil];

    NSString* intputText = self;
    for (NSString* key in [escapeArray allKeys]) {
        intputText = [intputText stringByReplacingOccurrencesOfString:key withString:[escapeArray objectForKey:key]];
    }
    return intputText;
}

- (NSString*)_xmlEscapeDecode
{

    NSMutableDictionary* escapeArray = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                                @"&amp;", @"&",
                                                                @"&quot;", @"\"",
                                                                @"&apos;", @"'",
                                                                @"&lt;", @"<",
                                                                @"&gt;", @">",
                                                                @"&yen;", @"¥",
                                                                @"＼", @"\\",

                                                                nil];

    NSString* intputText = self;
    for (NSString* key in [escapeArray allKeys]) {
        intputText = [intputText stringByReplacingOccurrencesOfString:[escapeArray objectForKey:key] withString:key];
    }

    return intputText;
}

#pragma mark _md5
- (NSString*)_md5
{
    const char* cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
                         @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                         result[0], result[1], result[2], result[3],
                         result[4], result[5], result[6], result[7],
                         result[8], result[9], result[10], result[11],
                         result[12], result[13], result[14], result[15]];
}

#pragma mark _indexOf
- (int)_indexOf:(NSString*)text
{

    if (text == nil) {
        return -1;
    }

    NSRange range = [self rangeOfString:text];
    if (range.length > 0) {
        return (int)range.location;
    } else {
        return -1;
    }
}

- (NSArray*)_split:(NSString*)splitStr
{
    return [self componentsSeparatedByString:splitStr];
}

#pragma mark getLineNum
#if TARGET_OS_IOS
- (int)_getLineNum:(UILabel*)label
{

    CGSize maxSize = CGSizeMake(label.width, label.height);

    CGRect fontSize = [label.text boundingRectWithSize:maxSize
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName : label.font}
                                               context:nil];

    float numberOfLines = fontSize.size.height / label.font.lineHeight;

    return (int)numberOfLines;
}
#endif

- (const char*)_toChar
{
    return self.UTF8String;
}

#pragma mark convertToNSData
- (NSData*)_toData
{

    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];

    return data;
}

- (NSData*)_toData_fromPath
{

    NSData* data = [NSData dataWithContentsOfFile:self];

    return data;
}

- (NSDate*)_toDate
{

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];

    if ([self _indexOf:@"Z"] != -1 && [self _indexOf:@"."] != -1) {
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];

    } else if ([self _indexOf:@"Z"] != -1 && [self _indexOf:@"'"] != -1) {
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    } else if ([self _indexOf:@"Z"] != -1) {
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    } else {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }

    //NSDate* now = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]];
    //タイムゾーンの指定
    //[formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    // [formatter setTimeZone: [NSTimeZone timeZoneWithAbbreviation:@"JST"]];

    NSDate* date = [formatter dateFromString:self];

    return date;
}

#pragma mark rTrim
/*
- (NSString *)_rTrim:(NSString*)str{
    NSCharacterSet* charsToTrim = [NSCharacterSet characterSetWithCharactersInString:str];
    return [self stringByTrimmingCharactersInSet:charsToTrim];
 }
*/

- (NSString*)_lTrim:(NSString*)str
{
    NSCharacterSet* charsToTrim = [NSCharacterSet characterSetWithCharactersInString:str];
    NSRange rangeOfFirstWantedCharacter = [self rangeOfCharacterFromSet:[charsToTrim invertedSet]];
    if (rangeOfFirstWantedCharacter.location == NSNotFound) {
        return @"";
    }
    return [self substringFromIndex:rangeOfFirstWantedCharacter.location];
}

- (NSString*)_lTrim2:(NSString*)targetWord
{
    
    int strLen = (int)[self length];
    int targetLen = (int)[targetWord length];
    
    NSRange range = [self rangeOfString:self options:NSBackwardsSearch range:NSMakeRange(0, strLen)];
    NSString* test = @"";
    if (range.location != NSNotFound) {
        test = [self substringWithRange:NSMakeRange(targetLen, strLen - targetLen)];
    }
    
    return test;
}

- (NSString*)_lTrim_newLineSpace
{
    return [self _lTrim:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString*)_rTrim:(NSString*)str
{
    
    return [self _rTrim2:str];
    
    /*
    NSCharacterSet* charsToTrim = [NSCharacterSet characterSetWithCharactersInString:str];
    NSRange rangeOfLastWantedCharacter = [self rangeOfCharacterFromSet:[charsToTrim invertedSet]
                                                               options:NSBackwardsSearch];
    if (rangeOfLastWantedCharacter.location == NSNotFound) {
        return @"";
    }
    return [self substringToIndex:rangeOfLastWantedCharacter.location + 1]; // non-inclusive
    */
}

- (NSString*)_rTrim_newLineSpace
{
    return [self _rTrim:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark rTrim2
//エラー1
- (NSString*)_rTrim2:(NSString*)str
{

    int strLen = (int)[self length];
    int trimLen = (int)[str length];

    NSRange range = [self rangeOfString:self options:NSBackwardsSearch range:NSMakeRange(0, strLen)];
    NSString* test = @"";
    if (range.location != NSNotFound) {
        
       NSString*targetWord = [self substringWithRange:NSMakeRange((strLen - trimLen), trimLen)];
                                                                  
       if(![targetWord isEqual:str]){
           return self;
       }
        
       test = [self substringWithRange:NSMakeRange(0, strLen - trimLen)];
    }

    return test;
}

- (NSString*)_substr:(int)i length:(int)length
{
    return [self substringWithRange:NSMakeRange(i, length)];
}

//指定した位置から最後まで
- (NSString*)_substr:(int)i
{
    return [self substringFromIndex:i];
}

- (NSString*)_strrev
{

    if ([self length] == 0) {
        return [NSString string];
    }

    NSMutableString* tmpstr = [NSMutableString string];
    NSUInteger strlength = [self length];
    for (NSUInteger i = 0; i < strlength; i++) {
        [tmpstr appendFormat:@"%C", [self characterAtIndex:strlength - 1 - i]];
    }
    return [NSString stringWithString:tmpstr];
}

#pragma mark _addLeftStr
- (NSString*)_addLeftStr:(NSString*)str
{
    return [NSString stringWithFormat:@"%@%@", str, self];
}

#pragma mark _addRightStr
- (NSString*)_addRightStr:(NSString*)str
{
    return [self stringByAppendingString:str];
}

#pragma mark sqlStr
- (NSString*)_sqlEscapeStr
{
    return [self stringByReplacingOccurrencesOfString:@"'" withString:@"’"];
}

#pragma mark regReplace
- (NSString*)_regReplace:(NSString*)pattern
{

    NSString* replacement = @"$2";

    NSRegularExpression* regexp = [NSRegularExpression
        regularExpressionWithPattern:pattern
                             options:NSRegularExpressionCaseInsensitive
                               error:nil];
    NSString* str = [regexp
        stringByReplacingMatchesInString:self
                                 options:NSMatchingReportProgress
                                   range:NSMakeRange(0, self.length)
                            withTemplate:replacement];

    return str;
}

#pragma mark 正規表現　置き換え    " \\<(.*?)\\> " patternに括弧()を複数 replaceTextに$1から $1 $2 $3  残すものだけ 記入する   (1) = $1 (2) = $2 (3) = $3
#pragma mark regReplace　//@".*1(.*?)1.*" パターンの前後に .*をつけること

//あまりうまく動かず
- (NSString*)_regReplacePartarn2:(NSString*)pattern replaceText:(NSString*)replaceText
{

    //エスケープは　\\を使う事
    // \\d{4}/\\d{2}/\\d{2}\\(.*?\\)

    NSString* baseStr = self;

    __block NSMutableArray* lines = [NSMutableArray array];
    [baseStr enumerateLinesUsingBlock:^(NSString* line, BOOL* stop) {
        line = [line stringByAppendingString:@"#KAIGYOU#"];
        [lines addObject:line];
    }];

    baseStr = [[lines copy] componentsJoinedByString:@""];

    NSMutableString* source1 = [NSMutableString stringWithString:baseStr];

    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];

    [regex stringByReplacingMatchesInString:source1
                                    options:0
                                      range:NSMakeRange(0, source1.length)
                               withTemplate:replaceText];

    NSString* source2 = [NSString stringWithString:source1];

    source2 = [source2 _replace:@"#KAIGYOU#" replaceStr:@"\n"];

    return source2;
}

//正しく動く
- (NSString*)_regMatchOne:(NSString*)pattern
{

    NSString* baseStr = self;

    __block NSMutableArray* lines = [NSMutableArray array];
    [baseStr enumerateLinesUsingBlock:^(NSString* line, BOOL* stop) {
        line = [line stringByAppendingString:@"#KAIGYOU#"];
        [lines addObject:line];
    }];

    baseStr = [[lines copy] componentsJoinedByString:@""];
    NSMutableString* source1 = [NSMutableString stringWithString:baseStr];

    // パターンから正規表現を生成する
    NSError* error = nil;
    NSRegularExpression* reg = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];

    // 正規表現を適用して結果を得る
    NSTextCheckingResult* match = [reg firstMatchInString:source1 options:0 range:NSMakeRange(0, source1.length)];

    if (match.numberOfRanges > 1) {
        NSString* matchStr = [source1 substringWithRange:[match rangeAtIndex:1]];
        matchStr = [matchStr _replace:@"#KAIGYOU#" replaceStr:@"\n"];
        return matchStr;
    }
    return @"";
}

//正しく動く
- (NSMutableArray*)_regMatchMauti:(NSString*)pattern
{

    NSString* baseStr = self;

    __block NSMutableArray* lines = [NSMutableArray array];
    [baseStr enumerateLinesUsingBlock:^(NSString* line, BOOL* stop) {
        line = [line stringByAppendingString:@"#KAIGYOU#"];
        [lines addObject:line];
    }];

    baseStr = [[lines copy] componentsJoinedByString:@""];
    NSMutableString* source1 = [NSMutableString stringWithString:baseStr];

    // パターンから正規表現を生成する
    NSError* error = nil;
    NSRegularExpression* reg = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];

    NSArray* matches = [reg matchesInString:source1
                                    options:0
                                      range:NSMakeRange(0, [source1 length])];

    NSMutableArray* array = [NSMutableArray new];

    for (NSTextCheckingResult* match in matches) {
        //NSRange matchRange = [match range];
        NSRange matchRange = [match rangeAtIndex:1];
        NSString* matchString = [source1 substringWithRange:matchRange];
        matchString = [matchString _replace:@"#KAIGYOU#" replaceStr:@"\n"];
        [array addObject:matchString];
    }

    return array;
}

#pragma mark replace
- (NSString*)_replace:(NSString*)search replaceStr:(NSString*)replaceStr
{
    NSString* result = @"";

    result = [self stringByReplacingOccurrencesOfString:search withString:replaceStr];

    return result;
}

- (char*)_convertToChar
{
    char* cp = (char*)[self UTF8String];
    return cp;
}

- (NSString*)_convertToNSString:(char*)str
{
    NSString* str2 = [NSString stringWithCString:str encoding:NSUTF8StringEncoding];
    return str2;
}

// 最初の文字だけ大文字にする
- (NSString*)_oomojiFirst
{

    if ([self length] == 0) {
        return self;
    }

    NSString* capitalisedSentence = [self stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                                                  withString:[[self substringToIndex:1] capitalizedString]];
    return capitalisedSentence;
}

//指定した最初の文字が同じなら削除する

- (NSString*)_firstMojiRemove:(NSString*)removeMoji
{

    if ([self length] == 0 || removeMoji == nil || [removeMoji isEqual:@""]) {
        return self;
    }

    NSString* resultStr = [self substringWithRange:NSMakeRange(0, 1)];

    if ([resultStr isEqual:removeMoji]) {
        return [self _replace:removeMoji replaceStr:@""];
    }

    return self;
}

- (NSString*)_charAt:(int)i
{
    NSString* newString = [self substringWithRange:NSMakeRange(i, 1)];
    return newString;
}

//前後の改行
- (NSString*)_trim_newLine
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}

//前後の半角スペース
- (NSString*)_trim_whiteSpace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

//前後の改行と半角スペース
- (NSString*)_trim_newLine_whiteSpace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//前後の指定した文字を削除する
- (NSString*)_trim_characterSet:(NSString*)str
{
    NSCharacterSet* charsToTrim = [NSCharacterSet characterSetWithCharactersInString:str];
    return [self stringByTrimmingCharactersInSet:charsToTrim];
}

@end
