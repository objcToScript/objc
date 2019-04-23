
@interface NSNumber (myExtension)

- (BOOL)_isFlaot;

+ (float)_getPercent:(float)centerBase upDown:(float)upDown;
//比較して大きい数字を取得する
- (NSNumber*)_Max:(NSNumber*)num;
//比較して小さい数字を取得する
- (NSNumber*)_Min:(NSNumber*)num;

+ (NSNumber*)_sum_float:(NSNumber*)number number1:(NSNumber*)number1;
+ (NSNumber*)_sum_int:(NSNumber*)number number1:(NSNumber*)number1;
+ (NSNumber*)_sum_double:(NSNumber*)number number1:(NSNumber*)number1;

- (const char*)_toChar;
- (NSString*)_toString;
+ (NSString*)_toString_from_Integer:(NSInteger)num;

+ (NSString*)_toString_from_Int:(int)num;

+ (NSInteger)_toInteger_from_Int:(int)num;

- (NSNumber*)_addInt:(int)num;
- (NSNumber*)_addOne;

//四捨五入を取得する 第二位が1
- (float)_getSisyaGonyu:(int)rankNum;

//整数かどうか
+ (BOOL)_checkIsInt:(NSString*)str;

//flootかどうか
+ (BOOL)_checkIsFloat:(NSString*)str;

//doubleかどうか
+ (BOOL)_checkIsDouble:(NSString*)str;

//小数点第何位以下か
- (int)_getDigits;

- (NSUInteger)_getDigits2;

@end
