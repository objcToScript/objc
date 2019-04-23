
#import "clsNSDate_utility.h"
#if TARGET_OS_IOS
#import "clsTranslate.h"
#elif TARGET_OS_MAC
#import "clsTranslate_ns.h"
#endif

#import "clsNSString.h"

@implementation clsNSDate_utility

+ (NSMutableArray*)_date_split:(int)splitNum startDateStr:(NSString*)startDateStr dateFormat:(NSString*)dateFormat
{

    if (dateFormat == nil) {
        dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    }

    double oldTimeStamp = [[startDateStr _toDate] _toTimeStamp];
    double nowTimeStamp = [[NSDate new] _toTimeStamp];
    double saNum = nowTimeStamp - oldTimeStamp;

    NSMutableArray* dateArray = [NSMutableArray new];

    int everNum = saNum / splitNum;
    for (int i = 0; i < splitNum; i++) {
        int startNum = oldTimeStamp + (i * everNum);
        int endNum = oldTimeStamp + ((i + 1) * everNum);
        NSDate* startDate = [NSDate _toDate_from_timeStamp:startNum];
        NSDate* endDate = [NSDate _toDate_from_timeStamp:endNum];

        NSString* startStr = [startDate _to_NSString:dateFormat];
        NSString* endStr = [endDate _to_NSString:dateFormat];

        NSMutableDictionary* dateDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:startStr, @"start", endStr, @"end", nil];
        [dateArray addObject:dateDic];
    }
    return dateArray;
}

//NSTimeInterval 拡張できず
+ (NSString*)_stringFromTimeInterval:(NSTimeInterval)interval
{
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    NSString* time = nil;
    if (hours > 0) {
        time = [NSString stringWithFormat:@"%ld:%ld:%ld", hours, minutes, seconds];
    } else {
        time = [NSString stringWithFormat:@"%ld:%ld", minutes, seconds];
    }

    return time;
}

//NSTimeInterval 拡張できず
+ (NSMutableDictionary*)_stringFromTimeInterval_Dic:(NSTimeInterval)interval
{

    NSInteger ti = (NSInteger)interval;
    NSInteger hours = (ti / 3600) % 24 + 9;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger seconds = ti % 60;

    NSMutableDictionary* dic = [NSMutableDictionary new];

    if (hours != 0 && minutes != 0 && seconds != 0) {

        [dic setObject:[NSNumber numberWithInteger:hours] forKey:@"hours"];
        [dic setObject:[NSNumber numberWithInteger:minutes] forKey:@"minutes"];
        [dic setObject:[NSNumber numberWithInteger:seconds] forKey:@"seconds"];

    } else if (hours == 0 && minutes != 0 && seconds != 0) {

        [dic setObject:[NSNumber numberWithInteger:minutes] forKey:@"minutes"];
        [dic setObject:[NSNumber numberWithInteger:seconds] forKey:@"seconds"];

    } else {

        [dic setObject:[NSNumber numberWithInteger:seconds] forKey:@"seconds"];
    }

    return dic;
}

+ (NSTimeInterval)_NSStringData_To_NSInterval:(NSString*)data_str dateFormat:(NSString*)dateFormat
{

    @try {

        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale* locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormatter.locale = locale;

        if (dateFormat != nil && ![dateFormat isEqual:@""]) {
            dateFormatter.dateFormat = dateFormat;
        } else {
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss ZZZ";
        }

        dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];

        NSDate* date3 = [dateFormatter dateFromString:data_str];

        NSTimeInterval intval2 = [date3 timeIntervalSince1970];

        return intval2;

    } @catch (NSException* exception) {

        NSLog(@"  %@", exception.debugDescription);
    }

    return 0;

    // NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    /// [formatter setTimeStyle:NSDateFormatterFullStyle];

    // if(dateFormat != nil && ![dateFormat isEqual:@""]){
    //    [formatter setDateFormat:dateFormat];
    // }else{
    //    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    // }

    //2011-03-16 14:14:02 +0000
    //Mon Jan 28 02:31:55 +0000 2013
    //EEE MMM dd HH:mm:ss ZZZ yyyy
    //NSDate *date2 = [formatter dateFromString:data_str];

    //NSTimeInterval intval = [date2 timeIntervalSince1970];

    // return intval;
}

//timestamp
+ (NSDate*)_NSString_To_NSDate:(NSString*)timeStamp
{

    NSTimeInterval interval = [timeStamp doubleValue] / 1000;
    NSDate* NSData1 = [NSDate dateWithTimeIntervalSince1970:interval];

    return NSData1;
}

+ (NSDate*)_NSTimeInterval_To_NSDate:(NSTimeInterval)interval
{

    //NSTimeInterval interval = [interval doubleValue] / 1000;

    NSDate* NSData1 = [NSDate dateWithTimeIntervalSince1970:interval];

    return NSData1;
}

//NSStringを NSDataにしてからNSIntervalにする
+ (NSDate*)_NSString_date_To_NSDate:(NSString*)date_str
{

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterFullStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    //2011-03-16 14:14:02 +0000
    //Mon Jan 28 02:31:55 +0000 2013
    //EEE MMM dd HH:mm:ss ZZZ yyyy
    NSDate* date1 = [formatter dateFromString:date_str];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];

    return date1;
}

+ (NSString*)_getNowDateTime
{

    NSDate* nowdate = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];

    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];

    NSString* datamoji = [formatter stringFromDate:nowdate];

    return datamoji;
}

+ (NSString*)_getNowDate
{

    NSDate* nowdate = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]];

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];

    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setDateFormat:@"yyyy/MM/dd"];

    NSString* datamoji = [formatter stringFromDate:nowdate];

    return datamoji;
}

+ (NSString*)_getNowMonthly
{

    NSDate* nowdate = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];

    [formatter setDateFormat:@"yyyy/MM"];

    NSString* datamoji = [formatter stringFromDate:nowdate];

    return datamoji;
}

+ (int)_getWeekOfMont
{

    NSInteger ordinalityOfFirstDay =
        [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay
                                                inUnit:NSCalendarUnitWeekOfMonth
                                               forDate:[NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]]];

    return (int)ordinalityOfFirstDay;
}

+ (NSString*)_getTimeAgo:(NSString*)data_str dateFormat:(NSString*)dateFormat
{

    NSTimeInterval timestamp;

    @try {
        if (data_str != nil && ![data_str isEqual:@""] && ![dateFormat isEqual:@"0"]) {
            timestamp = [clsNSDate_utility _NSStringData_To_NSInterval:data_str dateFormat:dateFormat];
        } else if (data_str == nil || [data_str isEqual:@""]) {
            return @"";
        }

        NSDate* now = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]];
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)timestamp];
        NSTimeInterval passed = [now timeIntervalSinceDate:date];

        int min = passed / 60;

        if (min <= 1) {

#if TARGET_OS_IOS
            NSString* n = [clsTranslate _translate_basic:@"1分前"];
#elif TARGET_OS_MAC
            NSString* n = [clsTranslate_ns _translate_basic:@"1分前"];
#endif

            if (n == nil || [n isEqual:@""]) {
                return @"";
            }
            return [NSString stringWithFormat:n, min];
        }

        if (min < 60) {

#if TARGET_OS_IOS
            NSString* n = [clsTranslate _translate_basic:@"%d週間前"];
#elif TARGET_OS_MAC
            NSString* n = [clsTranslate_ns _translate_basic:@"%d週間前"];
#endif
            n = [n _replace:@"%@" replaceStr:@"%d"];
            if (n == nil || [n isEqual:@""]) {
                return @"";
            }

            return [NSString stringWithFormat:n, min];
        }
        int hour = min / 60;
        if (hour > 0 && hour < 24) {

#if TARGET_OS_IOS
            NSString* n = [clsTranslate _translate_basic:@"%d週間前"];
#elif TARGET_OS_MAC
            NSString* n = [clsTranslate_ns _translate_basic:@"%d週間前"];
#endif

            n = [n _replace:@"%@" replaceStr:@"%d"];
            if (n == nil || [n isEqual:@""]) {
                return @"";
            }
            return [NSString stringWithFormat:n, hour];
        }

        int day = hour / 24;
        if (day > 0 && day < 31) {
            double week = day / 7;
            if (week < 1) {

#if TARGET_OS_IOS
                NSString* n = [clsTranslate _translate_basic:@"%d日前"];
#elif TARGET_OS_MAC
                NSString* n = [clsTranslate_ns _translate_basic:@"%d日前"];
#endif

                n = [n _replace:@"%@" replaceStr:@"%d"];
                if (n == nil || [n isEqual:@""]) {
                    return @"";
                }
                return [NSString stringWithFormat:n, day];
            } else {

#if TARGET_OS_IOS
                NSString* n = [clsTranslate _translate_basic:@"%d週間前"];
#elif TARGET_OS_MAC
                NSString* n = [clsTranslate_ns _translate_basic:@"%d週間前"];
#endif
                n = [n _replace:@"%@" replaceStr:@"%d"];
                if (n == nil || [n isEqual:@""]) {
                    return @"";
                }
                return [NSString stringWithFormat:n, (int)floor(week)];
            }
        }

        int month = day / 31;
        if (month > 0 && month < 12) {
            //%@

#if TARGET_OS_IOS
            NSString* n = [clsTranslate _translate_basic:@"%dか月前"];
#elif TARGET_OS_MAC
            NSString* n = [clsTranslate_ns _translate_basic:@"%dか月前"];
#endif

            n = [n _replace:@"%@" replaceStr:@"%d"];

            if (n == nil || [n isEqual:@""]) {
                return @"";
            }
            return [NSString stringWithFormat:n, month];
        }

        int year = month / 12;
        if (year < 1000000 && year > 0) {

#if TARGET_OS_IOS
            NSString* n = [clsTranslate _translate_basic:@"%d年前"];
#elif TARGET_OS_MAC
            NSString* n = [clsTranslate_ns _translate_basic:@"%d年前"];
#endif
            n = [n _replace:@"%@" replaceStr:@"%d"];
            if (n == nil || [n isEqual:@""]) {
                return @"";
            }

            return [NSString stringWithFormat:n, year];
        }

    } @catch (NSException* exception) {

        NSLog(@"  %@", exception.debugDescription);

        //CLS_LOG(@"  %@ dateFormat  %@", exception.debugDescription  ,dateFormat  );
    }

    return @"";
}

@end
