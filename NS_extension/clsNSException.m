
#import "clsNSException.h"

#import "clsNSMutableDictionary.h"
#import "clsNSString.h"
#import "clsUtility.h"

@implementation NSException (ex)

- (void)_saveCrashReport
{

    NSString* errorLogPath = [clsFile _getApplicationSupportDirectory_FileNameOnly:@"errorLog.txt"];

    if ([clsFile _isFile:errorLogPath]) {
        [clsFile _addSave:[@"\n" _add:self.description, nil] filePath:errorLogPath];
    } else {
        [clsFile _save:self.description filePath:errorLogPath];
    }
}

+ (void)_mkException:(NSString*)errorName reason:(NSString*)reason
{

    [NSException raise:errorName format:reason];
}

- (void)_cracshReportReq:(NSString*)url appId:(NSString*)appId reportDic:(NSMutableDictionary*)reportDic
{

    url = [url _replace:@"" replaceStr:[@"" _addStr:@"_staging"]];

    if (reportDic == nil) {
        reportDic = [[NSMutableDictionary alloc] init];
    }

    NSMutableDictionary* newDic = [[NSMutableDictionary alloc] init];

    NSString* versionNo = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    ;

    if (versionNo != nil) {
        [newDic setObject:versionNo forKey:@"versions"];
    }

    if ([clsUtility _getTimeNow] != nil) {
        [newDic setObject:[clsUtility _getTimeNow] forKey:@"create_date"];
    }

    if (appId != nil) {
        [newDic setObject:appId forKey:@"app_child_id"];
    }

    if (self.description != nil) {
        [reportDic setObject:self.description forKey:@"description"];
    }

    // [reportDic setObject:self.callStackSymbols forKey:@"callStackSymbols"];
    if (self.reason != nil) {
        [reportDic setObject:self.reason forKey:@"reason"];
    }
    if (self.name != nil) {
        [reportDic setObject:self.name forKey:@"name"];
    }

    /*
     NSString*device = [UIDevice currentDevice].model;
    
     if(device!= nil){
         [reportDic setObject:device forKey:@"device"];
     }
    
     NSString* iOSVersion = [[UIDevice currentDevice] systemVersion] ;
     if(iOSVersion != nil){
         [reportDic setObject:iOSVersion forKey:@"OS"];
     }
    */

    if ([reportDic _toJson] != nil) {
        [newDic setObject:[reportDic _toJson] forKey:@"report"];
    }

    //エラー 行
    //関数
    //バージョン   [clsUtility _getAppVersion]
    //日付 [clsUtility _getTimeNow]

    NSString* jsonStr = [newDic _toJson];

    NSString* encodeStr = [jsonStr _urlEncode];

    NSString* params = [NSString stringWithFormat:@"q=%@", encodeStr];

    NSString* crashUrl = [url _addStr:params];

    [clsUtility _req_async:crashUrl
                      func:^(NSString* n, NSError* error) {
                          NSLog(@"crash result  %@", n);

                          NSLog(@"crash error  %@", error.description);
                      }];
}

- (void)_cracshReportReq:(NSString*)url appId:(NSString*)appId
{

    [self _cracshReportReq:url appId:appId reportDic:nil];
}

@end
