
#import "clsNSDate.h"

@interface NSDate (utility)

+ (NSNumber*)_everSecond_timeStamp_from_nsDate:(int)second nowDate:(NSDate*)nowDate;
+ (NSNumber*)_everMinitues_timeStamp_from_nsDate:(int)minitues nowDate:(NSDate*)nowDate;
+ (NSNumber*)_everHour_timeStamp_from_nsDate:(int)hour nowDate:(NSDate*)nowDate;
+ (NSNumber*)_everMonth_timeStamp_from_nsDate:(int)month nowDate:(NSDate*)nowDate;

+ (NSNumber*)_everSecond_timeStamp:(int)second;
+ (NSNumber*)_everMinitues_timeStamp:(int)minitues;
+ (NSNumber*)_everHour_timeStamp:(int)hour;
+ (NSNumber*)_everDay_timeStamp:(int)day;
+ (NSNumber*)_everMonth_timeStamp:(int)month;

//秒ごと
+ (NSDate*)_everSecond:(int)second;
//分ごと
+ (NSDate*)_everMinitues:(int)minitues;
//分ごと
+ (NSDate*)_everMinitues_ceil:(int)minitues;

//時間ごと
+ (NSDate*)_everHour:(int)hour;
//日ごと
+ (NSDate*)_everDay:(int)day;
//月ごと
+ (NSDate*)_everMonth:(int)month;

@end
