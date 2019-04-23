
#import "clsNSUserDefaults.h"

@implementation NSUserDefaults (ex)

+ (NSString*)_getString:(NSString*)key
{

    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)_setString:(NSString*)key value:(NSString*)value
{

    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}

@end
