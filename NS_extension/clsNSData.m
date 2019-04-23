
#import "clsNSData.h"

@implementation NSData (ex)

- (const char*)_toChar
{
    NSString* string = [[NSString alloc] initWithData:self
                                             encoding:NSUTF8StringEncoding];
    return string.UTF8String;
}

- (NSString*)_toString
{
    NSString* string = [[NSString alloc] initWithData:self
                                             encoding:NSUTF8StringEncoding];
    return string;
}

- (NSDictionary*)_toDicJson_fromJsonData
{
    NSError* error;
    NSDictionary* dJSON = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:&error];
    return dJSON;
}

- (NSArray*)_toArrayJson_fromJsonData
{
    NSError* error;
    NSArray* dJSON = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:&error];
    return dJSON;
}

- (BOOL)_isOpenStepFormat_from_NSPropertyList
{

    NSPropertyListFormat format;

    [NSPropertyListSerialization propertyListWithData:self options:NSPropertyListMutableContainers format:&format error:nil];

    if (NSPropertyListOpenStepFormat == format) {
        return YES;
    }
    return NO;
}

- (NSDictionary*)_toDic_from_NSPropertyList:(NSString**)formatStr
{

    NSPropertyListFormat format;

    NSMutableDictionary* dic = [NSPropertyListSerialization propertyListWithData:self options:NSPropertyListMutableContainers format:&format error:nil];

    *formatStr = [self _showFormat:format];

    return dic;
}

- (NSString*)_showFormat:(NSPropertyListFormat)format
{

    NSString* formatDescription;
    switch (format) {
        case NSPropertyListOpenStepFormat:
            formatDescription = @"openstep";
            break;
        case NSPropertyListXMLFormat_v1_0:
            formatDescription = @"xml";
            break;
        case NSPropertyListBinaryFormat_v1_0:
            formatDescription = @"binary";
            break;
        default:
            formatDescription = @"unknown";
            break;
    }

    return formatDescription;

    NSLog(@"formatDescription  %@", formatDescription);
}

@end
