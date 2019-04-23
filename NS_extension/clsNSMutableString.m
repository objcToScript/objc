
#import "clsNSMutableString.h"

@implementation NSMutableString (ex)

- (NSString*)_toNSString
{

    NSString* str = [NSString stringWithString:self];
    return str;
}

@end
