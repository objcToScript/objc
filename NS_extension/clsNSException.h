
@interface NSException (ex)

- (void)_saveCrashReport;

//Exceptionを生成する
+ (void)_mkException:(NSString*)errorName reason:(NSString*)reason;

- (void)_cracshReportReq:(NSString*)url appId:(NSString*)appId reportDic:(NSMutableDictionary*)reportDic;

- (void)_cracshReportReq:(NSString*)url appId:(NSString*)appId;

@end
