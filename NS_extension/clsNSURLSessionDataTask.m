
#import "clsNSURLSessionDataTask.h"

@implementation NSURLSessionDataTask (ex)

-(long)_getStatusCode{
    long statusCode = 0;
    if ([self.response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)self.response;
        statusCode = httpResponse.statusCode;
    }
    return statusCode;
}

@end
