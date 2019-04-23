#import "clsNSDate+utility.h"

@implementation NSDate (utility)

+ (NSNumber*)_everSecond_timeStamp:(int)second
{
    return [NSNumber numberWithDouble:[[self _everSecond:second] _to_NSTimeInterval]];
}

+ (NSNumber*)_everMinitues_timeStamp:(int)minitues
{
    return [NSNumber numberWithDouble:[[self _everMinitues:minitues] _to_NSTimeInterval]];
}

+ (NSNumber*)_everHour_timeStamp:(int)hour
{
    return [NSNumber numberWithDouble:[[self _everHour:hour] _to_NSTimeInterval]];
}

+ (NSNumber*)_everDay_timeStamp:(int)day
{
    return [NSNumber numberWithDouble:[[self _everDay:day] _to_NSTimeInterval]];
}

+ (NSNumber*)_everMonth_timeStamp:(int)month
{
    return [NSNumber numberWithDouble:[[self _everMonth:month] _to_NSTimeInterval]];
}

+ (NSDate*)_everSecond:(int)second
{
    
    NSDate* nowDate = [NSDate new];
    
    NSDateComponents* comp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitCalendar fromDate:nowDate];
    
    double num = floor(comp.second / second) * second;
    
    [comp setSecond:num];
    
    NSDate* date = [comp date];
    
    return date;
}

+ (NSDate*)_everMinitues:(int)minitues
{
    
    NSDate* nowDate = [NSDate new];
    
    NSDateComponents* comp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitCalendar fromDate:nowDate];
    
    double num = floor(comp.minute / minitues) * minitues;
    
    [comp setMinute:num];
    [comp setSecond:0];
    
    NSDate* date = [comp date];
    
    return date;
}

+ (NSDate*)_everMinitues_ceil:(int)minitues
{
    
    NSDate* nowDate = [NSDate new];
    
    NSDateComponents* comp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitCalendar fromDate:nowDate];
    
    double num = ceil(comp.minute / minitues) * minitues;
    
    [comp setMinute:num];
    [comp setSecond:0];
    
    NSDate* date = [comp date];
    
    return date;
}

+ (NSDate*)_everHour:(int)hour
{
    
    NSDate* nowDate = [NSDate new];
    
    NSDateComponents* comp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitCalendar fromDate:nowDate];
    
    double num = floor(comp.hour / hour) * hour;
    
    [comp setHour:num];
    [comp setMinute:0];
    [comp setSecond:0];
    NSDate* date = [comp date];
    
    return date;
}

+ (NSDate*)_everDay:(int)day
{
    
    NSDate* nowDate = [NSDate new];
    
    NSDateComponents* comp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitCalendar fromDate:nowDate];
    
    double num = floor(comp.day / day) * day;
    
    [comp setDay:[[NSNumber numberWithDouble:num] intValue]];
    [comp setHour:0];
    [comp setMinute:0];
    [comp setSecond:0];
    
    NSDate* date = [comp date];
    
    return date;
}

+ (NSDate*)_everMonth:(int)month
{
    
    NSDate* nowDate = [NSDate new];
    
    NSDateComponents* comp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitCalendar fromDate:nowDate];
    
    double num = floor(comp.month / month) * month;
    
    [comp setDay:[[NSNumber numberWithDouble:num] intValue]];
    [comp setDay:1];
    [comp setHour:0];
    [comp setMinute:0];
    [comp setSecond:0];
    
    NSDate* date = [comp date];
    
    return date;
}

+ (NSNumber*)_everSecond_timeStamp_from_nsDate:(int)second nowDate:(NSDate*)nowDate
{
    return [NSNumber numberWithDouble:[[self _everSecond_from_nsDate:second nowDate:nowDate] _to_NSTimeInterval]];
}

+ (NSNumber*)_everMinitues_timeStamp_from_nsDate:(int)minitues nowDate:(NSDate*)nowDate
{
    return [NSNumber numberWithDouble:[[self _everMinitues_from_nsDate:minitues nowDate:nowDate] _to_NSTimeInterval]];
}

+ (NSNumber*)_everHour_timeStamp_from_nsDate:(int)hour nowDate:(NSDate*)nowDate
{
    return [NSNumber numberWithDouble:[[self _everHour_from_nsDate:hour nowDate:nowDate] _to_NSTimeInterval]];
}

+ (NSNumber*)_everDay_timeStamp_from_nsDate:(int)day nowDate:(NSDate*)nowDate
{
    return [NSNumber numberWithDouble:[[self _everDay_from_nsDate:day nowDate:nowDate] _to_NSTimeInterval]];
}

+ (NSNumber*)_everMonth_timeStamp_from_nsDate:(int)month nowDate:(NSDate*)nowDate
{
    return [NSNumber numberWithDouble:[[self _everMonth_from_nsDate:month nowDate:nowDate] _to_NSTimeInterval]];
}

+ (NSDate*)_everSecond_from_nsDate:(int)second nowDate:(NSDate*)nowDate
{

    NSDateComponents* comp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitCalendar fromDate:nowDate];

    double num = floor(comp.second / second) * second;

    [comp setSecond:num];

    NSDate* date = [comp date];

    return date;
}

+ (NSDate*)_everMinitues_from_nsDate:(int)minitues nowDate:(NSDate*)nowDate
{

    NSDateComponents* comp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitCalendar fromDate:nowDate];

    double num = floor(comp.minute / minitues) * minitues;

    [comp setMinute:num];
    [comp setSecond:0];

    NSDate* date = [comp date];

    return date;
}

+ (NSDate*)_everHour_from_nsDate:(int)hour nowDate:(NSDate*)nowDate
{

    NSDateComponents* comp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitCalendar fromDate:nowDate];

    double num = floor(comp.hour / hour) * hour;

    [comp setHour:num];
    [comp setMinute:0];
    [comp setSecond:0];
    NSDate* date = [comp date];

    return date;
}

+ (NSDate*)_everDay_from_nsDate:(int)day nowDate:(NSDate*)nowDate
{

    NSDateComponents* comp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitCalendar fromDate:nowDate];

    double num = floor(comp.day / day) * day;

    [comp setDay:[[NSNumber numberWithDouble:num] intValue]];
    [comp setHour:0];
    [comp setMinute:0];
    [comp setSecond:0];

    NSDate* date = [comp date];

    return date;
}

+ (NSDate*)_everMonth_from_nsDate:(int)month nowDate:(NSDate*)nowDate
{

    NSDateComponents* comp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitCalendar fromDate:nowDate];

    double num = floor(comp.month / month) * month;

    [comp setDay:[[NSNumber numberWithDouble:num] intValue]];
    [comp setDay:1];
    [comp setHour:0];
    [comp setMinute:0];
    [comp setSecond:0];

    NSDate* date = [comp date];

    return date;
}

@end
