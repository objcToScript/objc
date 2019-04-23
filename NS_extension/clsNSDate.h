
@interface NSDate (ex)

- (NSDateComponents*)_toDateComponents;

+ (int)_minitus_to_Second:(int)minitus;
+ (int)_hours_to_Second:(int)hours;

//日数を取得する
- (NSInteger)_getNisuu:(NSDate*)firstDate toDate:(NSDate*)toDate;

//曜日の文字列を取得する
- (NSString*)_getYoubiStr:(BOOL)isJapanese;

//時間を取得する
- (NSString*)_getHourTime;

//曜日を取得する
- (NSString*)_getYoubi;

//現在の時間からの差分を取得する
- (NSMutableDictionary*)_getJIkanSabunDic;
//秒の差分
- (float)_getJIkanSabun_second;

//現在のタイムスタンプを取得する
- (double)_toTimeStamp;

+ (NSDate*)_toDate_from_timeStamp:(double)timeStamp;

//コインチェック用
+ (NSString*)_getTimeStampMillionStr;
//コインチェック用
+ (double)_getTimeStampMillion;

+ (NSString*)_getTimeStampStr;

+ (NSNumber*)_getTimeStamp_number;

+ (double)_getTimeStamp;

- (double)_getTimeStamp;
- (NSString*)_getTimeStampStr;
+ (NSString*)_getTimeStampIntStr;
- (NSString*)_getTimeStampIntStr;

- (NSTimeInterval)_to_NSTimeInterval;

- (NSString*)_to_NSString_from_GMT;

- (NSString*)_to_NSString;

- (NSString*)_to_NSString:(NSString*)formatStr;

+ (NSDate*)_getNowTime;

+ (NSString*)_getNowTimeStr;

+ (NSString*)_getNowDateStr;

//何分後 +　何分前　-
- (NSDate*)_addMinute:(int)minitus;
//何時間後  何時間前　-
- (NSDate*)_addHours:(int)hours;
//何日後 何日前　-
- (NSDate*)_addDays:(int)days;
//何ヶ月後
- (NSDate*)_addMonths:(int)months;
//何年後
- (NSDate*)_addYears:(int)years;
//時間の比較
- (int)_compare:(NSDate*)targetDate;
//日付だけ
- (NSDate*)_getDayOnlyDate;
//最後の週を取得する
- (NSDate*)_getEndWeek;
//最初の週を取得する
- (NSDate*)_getBeginWeek;
//現在の年と月を取得する
- (NSString*)_getNowMonthStr;

@end

#import "clsNSDate+utility.h"
