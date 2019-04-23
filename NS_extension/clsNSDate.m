
#import "clsNSDate.h"

@implementation NSDate (ex)

- (NSDateComponents*)_toDateComponents
{

    NSCalendar* gregorian = [[NSCalendar alloc]
        initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* weekdayComponents =
        [gregorian components:(

                                  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
                                  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday)
                     fromDate:self];

    return weekdayComponents;
}

+ (int)_hours_to_Second:(int)hours
{
    return hours * 60 * 60;
}

+ (int)_minitus_to_Second:(int)minitus
{
    return minitus * 60;
}

//日数を取得する
- (NSInteger)_getNisuu:(NSDate*)firstDate toDate:(NSDate*)toDate
{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* components = [calendar components:NSCalendarUnitDay fromDate:firstDate toDate:toDate options:0];
    NSInteger pastDay = [components day];
    return pastDay;
}

//年月日だけのdateを取得する
- (NSDate*)_getDayOnlyDate
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSCalendar* calendar = [NSCalendar currentCalendar];

    NSDateComponents* components = [calendar components:flags fromDate:self];

    NSDate* dateOnly = [calendar dateFromComponents:components];
    return dateOnly;
}

- (NSString*)_getNowMonthStr
{

    NSDate* nowDate = [NSDate new];
    // 現在の時刻
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSString* dateString = [formatter stringFromDate:nowDate];

    return dateString;
}

- (NSDate*)_getBeginWeek
{

    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* oneDayAgoComponents = [[NSDateComponents alloc] init];

    // 週の連番 日曜が１土曜が７
    NSDateComponents* subcomponent = [calendar components:NSCalendarUnitWeekday fromDate:self];
    [oneDayAgoComponents setDay:0 - ([subcomponent weekday] - 1)];

    NSDate* beginningOfWeek = [calendar dateByAddingComponents:oneDayAgoComponents toDate:self options:0];

    return beginningOfWeek;
}

- (NSDate*)_getEndWeek
{

    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* oneDayAgoComponents = [[NSDateComponents alloc] init];

    // 週の連番 日曜が１土曜が７
    NSDateComponents* subcomponent = [calendar components:NSCalendarUnitWeekday fromDate:self];
    [oneDayAgoComponents setDay:7 - ([subcomponent weekday])];

    NSDate* endOfWeek = [calendar dateByAddingComponents:oneDayAgoComponents
                                                  toDate:self
                                                 options:0];
    return endOfWeek;
}

- (NSString*)_getHourTime
{

    NSDateFormatter* outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH"];
    outputFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];

    NSString* strNow = [outputFormatter stringFromDate:self];

    return strNow;
}

- (NSString*)_getYoubiStr:(BOOL)isJapanese
{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* comps = [calendar components:NSCalendarUnitWeekday
                                          fromDate:self];
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    if (isJapanese) {
        df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja"];
    } else {
        df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en"];
    }

    //comps.weekdayは 1-7の値が取得できるので-1する
    NSString* weekDayStr = df.shortWeekdaySymbols[comps.weekday - 1];
    return weekDayStr;
}
- (NSString*)_getYoubi
{

    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps;

    comps = [calendar components:(NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
                        fromDate:self];
    //NSInteger week = [comps week]; // 今年に入って何週目か
    NSInteger weekday = [comps weekday]; // 曜日
                                         // NSInteger weekdayOrdinal = [comps weekdayOrdinal]; // 今月の第何曜日か
                                         // NSLog(@"week: %d weekday: %d weekday ordinal: %d", week, weekday, weekdayOrdinal);
    //=> week: 21 weekday: 7(日曜日) weekday ordinal: 4(第4日曜日)

    int weekday_i = (int)weekday;

    return [NSString stringWithFormat:@"%d", weekday_i];
}

#pragma mark 現在の時間からの差分を取得する
- (NSMutableDictionary*)_getJIkanSabunDic
{

    NSDate* nowDate = [NSDate new];
    float tmp = [nowDate timeIntervalSinceDate:self]; //差分をfloatで取得
    int hh = (int)(tmp / 3600);
    int mm = (int)((tmp - hh) / 60);
    float ss = tmp - (float)(hh * 3600 + mm * 60);

    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:hh], @"h",
                                    [NSNumber numberWithInt:mm], @"m",
                                    [NSNumber numberWithInt:ss], @"s",
                                    nil];
}

- (float)_getJIkanSabun_second
{

    NSDate* nowDate = [NSDate new];

    float tmp = [nowDate timeIntervalSinceDate:self]; //差分をfloatで取得
    int hh = (int)(tmp / 3600);
    int mm = (int)((tmp - hh) / 60);
    float ss = tmp - (float)(hh * 3600 + mm * 60);

    return ss;
}

+ (NSDate*)_getNowTime
{
    NSDate* nowDate = [NSDate new];
    return nowDate;
}

+ (NSString*)_getNowTimeStr
{

    NSDate* now = [NSDate new];
    // 現在の時刻
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSString* dateString = [formatter stringFromDate:now];

    return dateString;
}

+ (NSString*)_getNowDateStr
{

    NSDate* now = [NSDate new];
    // 現在の時刻
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSString* dateString = [formatter stringFromDate:now];

    return dateString;
}

- (NSDate*)_addMinute:(int)minitus
{

    NSCalendar* calendar = [NSCalendar currentCalendar];

    NSDateComponents* date = [[NSDateComponents alloc] init];

    date.minute = minitus;

    NSDate* result = [calendar dateByAddingComponents:date toDate:self options:0];

    return result;
}

- (NSDate*)_addHours:(int)hours
{

    NSCalendar* calendar = [NSCalendar currentCalendar];

    NSDateComponents* date = [[NSDateComponents alloc] init];

    date.hour = hours;

    NSDate* result = [calendar dateByAddingComponents:date toDate:self options:0];

    return result;
}

- (NSDate*)_addDays:(int)days
{

    NSCalendar* calendar = [NSCalendar currentCalendar];

    NSDateComponents* date = [[NSDateComponents alloc] init];

    date.day = days;

    NSDate* result = [calendar dateByAddingComponents:date toDate:self options:0];

    return result;
}

- (NSDate*)_addMonths:(int)months
{

    NSCalendar* calendar = [NSCalendar currentCalendar];

    NSDateComponents* date = [[NSDateComponents alloc] init];

    date.month = months;

    NSDate* result = [calendar dateByAddingComponents:date toDate:self options:0];

    return result;
}

- (NSDate*)_addYears:(int)years
{

    NSCalendar* calendar = [NSCalendar currentCalendar];

    NSDateComponents* date = [[NSDateComponents alloc] init];

    date.year = years;

    NSDate* result = [calendar dateByAddingComponents:date toDate:self options:0];

    return result;
}

//現在のNSDataをNSIntervalにする　同じ
- (NSTimeInterval)_to_NSTimeInterval
{
    NSTimeInterval timestamp = [self timeIntervalSince1970];
    return timestamp;
}
//現在のTimeStampを取得する
- (double)_toTimeStamp
{
    double timestamp = [self timeIntervalSince1970];
    return timestamp;
}
+ (NSDate*)_toDate_from_timeStamp:(double)timeStamp
{
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return date;
}

//dateにはグリニッジを   [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]]
+ (double)_getTimeStamp
{
    double nowTimeStamp = [[NSDate date] timeIntervalSince1970];
    return nowTimeStamp;
}

- (double)_getTimeStamp
{
    double nowTimeStamp = [self timeIntervalSince1970];
    return nowTimeStamp;
}

- (NSString*)_getTimeStampStr
{
    double nowTimeStamp = [self timeIntervalSince1970];
    return [[NSNumber numberWithDouble:nowTimeStamp] stringValue];
}

- (NSString*)_getTimeStampIntStr
{
    int nowTimeStamp = (int)[self timeIntervalSince1970];
    return [[NSNumber numberWithInt:nowTimeStamp] stringValue];
}

+ (NSNumber*)_getTimeStamp_number
{
    double nowTimeStamp = [[NSDate date] timeIntervalSince1970];

    return [NSNumber numberWithDouble:nowTimeStamp];
}

+ (NSString*)_getTimeStampStr
{
    double nowTimeStamp = [[NSDate date] timeIntervalSince1970];
    return [[NSNumber numberWithDouble:nowTimeStamp] stringValue];
}
+ (NSString*)_getTimeStampIntStr
{
    int nowTimeStamp = (int)[[NSDate date] timeIntervalSince1970];
    return [[NSNumber numberWithInt:nowTimeStamp] stringValue];
}

//coinチェック用
+ (NSString*)_getTimeStampMillionStr
{

    double timestamp = [[NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]] timeIntervalSince1970];

    // double timestamp = [[NSDate new] timeIntervalSince1970];

    int64_t timeInMilisInt64 = (int64_t)(timestamp * 1000);
    return [[NSNumber numberWithLongLong:timeInMilisInt64] stringValue];
}
//coinチェック用
+ (double)_getTimeStampMillion
{

    double timestamp = [[NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]] timeIntervalSince1970];
    //double timestamp = [[NSDate new] timeIntervalSince1970];

    return timestamp;
}
//GMTからのNSDate
- (NSString*)_to_NSString_from_GMT
{

    NSDate* now = self;
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSString* dateString = [formatter stringFromDate:now];

    return dateString;
}

//現在のNSDataをNSStringにする
- (NSString*)_to_NSString
{

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    // 型変換：NSDate->NSString
    NSString* now_dateStr = [formatter stringFromDate:self];

    return now_dateStr;
}

//現在のNSDataをNSStringにする
- (NSString*)_to_NSString:(NSString*)formatStr
{

    NSString* formatStr_temp = @"";
    if (formatStr == nil || [formatStr isEqual:@""]) {
        formatStr_temp = @"YYYY/MM/dd HH:mm:ss";
    } else {
        formatStr_temp = formatStr;
    }

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatStr_temp];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    // 型変換：NSDate->NSString
    NSString* now_dateStr = [formatter stringFromDate:self];

    return now_dateStr;
}

- (int)_compare:(NSDate*)targetDate
{

    NSComparisonResult result = [self compare:targetDate];
    int resultInt = 0;

    switch (result) {

        // 同一時刻
        case NSOrderedSame: {
            resultInt = 0;
        } break;

        // nowよりotherDateのほうが未来
        case NSOrderedAscending: {
            resultInt = 1;
        }

        break;
        // nowよりotherDateのほうが過去
        case NSOrderedDescending: {
            resultInt = -1;

        }

        break;
    }

    return resultInt;
}

@end
