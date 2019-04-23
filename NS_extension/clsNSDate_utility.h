
@interface clsNSDate_utility : NSObject

//日付を分割して文字列に返す
+ (NSMutableArray*)_date_split:(int)splitNum startDateStr:(NSString*)startDateStr dateFormat:(NSString*)dateFormat;

+ (NSString*)_getTimeAgo:(NSString*)data_str dateFormat:(NSString*)dateFormat;

+ (NSTimeInterval)_NSStringData_To_NSInterval:(NSString*)data_str dateFormat:(NSString*)dateFormat;

+ (NSString*)_getNowDateTime;

+ (NSString*)_getNowDate;

+ (NSString*)_getNowMonthly;

+ (NSString*)_stringFromTimeInterval:(NSTimeInterval)interval;

+ (NSMutableDictionary*)_stringFromTimeInterval_Dic:(NSTimeInterval)interval;

+ (NSDate*)_NSString_To_NSDate:(NSString*)timeStamp;

+ (NSDate*)_NSTimeInterval_To_NSDate:(NSTimeInterval)interval;

+ (NSDate*)_NSString_date_To_NSDate:(NSString*)date_str;

+ (int)_getWeekOfMont;

@end
