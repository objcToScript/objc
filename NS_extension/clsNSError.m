
#import "clsNSError.h"

@implementation NSError (ex)

- (void)_saveErrorReport
{

    NSString* errorLogPath;

#if TARGET_OS_OSX
    errorLogPath = [clsFile _getAppExePath:@"errorLog.txt"];
#elif TARGET_OS_IOS
    errorLogPath = [clsFile _getDocumentPath:@"errorLog.txt"];
#endif

    if ([clsFile _isFile:errorLogPath]) {
        [clsFile _addSave:[@"\n" _add:self.description, nil] filePath:errorLogPath];
    } else {
        [clsFile _save:self.description filePath:errorLogPath];
    }
}

+ (NSError*)_mkNSError:(NSInteger)code reason:(NSString*)reason
{

    NSDictionary* errorUserInfo = @{NSLocalizedDescriptionKey : reason};

    NSError* _error = [NSError errorWithDomain:@"test" code:code userInfo:errorUserInfo];

    return _error;
}

@end
