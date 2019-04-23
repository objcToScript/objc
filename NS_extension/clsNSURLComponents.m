
#import "clsNSURLComponents.h"

@implementation NSURLComponents (ex)

+(NSURLComponents*)_mkQueryUrl_from_url:(NSString*)url parameterDic:(NSDictionary*)paramDic{
    
    NSMutableArray*quryArray = [NSMutableArray new];
    for(NSString*key in [paramDic allKeys]){
        NSURLQueryItem *item1 = [NSURLQueryItem queryItemWithName:key value:[paramDic objectForKey:key]];
        [quryArray addObject:item1];
    }

    NSURLComponents *components = [[NSURLComponents alloc] initWithString:url];
    components.queryItems = [quryArray copy];
    return components;
    
}


@end
