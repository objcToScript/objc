
@interface NSError (ex)

- (void)_saveErrorReport;

//NSErrorを作成する
+ (NSError*)_mkNSError:(NSInteger)code reason:(NSString*)reason;

@end
