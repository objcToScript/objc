
#import "clsNSNumber.h"

#import "clsNSString.h"

@implementation NSNumber (myExtension)

+ (float)_getPercent:(float)centerBase upDown:(float)upDown
{

    NSLog(@" upDown %f   centerBase %f   ", upDown, centerBase);

    float percent = upDown / centerBase;

    // centerBase  * percent = upDown

    return percent;
}

- (NSNumber*)_Max:(NSNumber*)num
{

    if ([self floatValue] > [num floatValue]) {
        return self;
    }
    return num;
}

- (NSNumber*)_Min:(NSNumber*)num
{

    if ([self floatValue] < [num floatValue]) {
        return self;
    }
    return num;
}

+ (NSNumber*)_sum_float:(NSNumber*)number number1:(NSNumber*)number1
{
    return [NSNumber numberWithFloat:([number floatValue] + [number1 floatValue])];
}
+ (NSNumber*)_sum_int:(NSNumber*)number number1:(NSNumber*)number1
{
    return [NSNumber numberWithFloat:([number intValue] + [number1 intValue])];
}
+ (NSNumber*)_sum_double:(NSNumber*)number number1:(NSNumber*)number1
{
    return [NSNumber numberWithFloat:([number doubleValue] + [number1 doubleValue])];
}

- (float)_getSisyaGonyu:(int)rankNum
{

    NSDecimalNumber* decimal = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", [self floatValue]]];
    // 小数点第2位を四捨五入
    int scale = rankNum;
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:scale raiseOnExactness:FALSE raiseOnOverflow:TRUE raiseOnUnderflow:TRUE raiseOnDivideByZero:TRUE];
    decimal = [decimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];

    return [decimal floatValue];
}

- (const char*)_toChar
{
    return [self stringValue].UTF8String;
}

- (NSString*)_toString
{
    return [self stringValue];
}

+ (NSInteger)_toInteger_from_Int:(int)num
{
    return [[NSNumber numberWithInt:num] integerValue];
}

+ (NSString*)_toString_from_Integer:(NSInteger)num
{
    return [[NSNumber numberWithInteger:num] stringValue];
}

+ (NSString*)_toString_from_Int:(int)num
{
    return [[NSNumber numberWithInt:num] stringValue];
}

- (NSNumber*)_addInt:(int)num
{

    int value = [self intValue];
    NSNumber* number = [NSNumber numberWithInt:value + num];

    return number;
}

- (NSNumber*)_addOne
{

    int value = [self intValue];
    NSNumber* number = [NSNumber numberWithInt:value + 1];

    return number;
}

- (BOOL)_isFlaot
{
    switch(CFNumberGetType((CFNumberRef)self))
  {
      case kCFNumberFloat32Type:
      case kCFNumberFloat64Type:
      case kCFNumberFloatType:
      case kCFNumberCGFloatType:{
          return YES;
      }
  }
 
  return NO;
}

- (int)_getDigits
{
    int count = 0;
    int intNumber = [self intValue];
    while (intNumber) {
        intNumber = intNumber / 10;
        count++;
    }
    return count;
}

//桁数の取得
- (NSUInteger)_getDigits2
{

    NSString* numStr = [self _toString];

    if ([self _indexOf:numStr searchText:@"."] == -1) {
        return 0;
    } else if ([self _indexOf:numStr searchText:@"."] != -1) {

        NSArray* array = [numStr _split:@"."];

        NSString* str = [array objectAtIndex:1];
        return [str length];
    }

    return 0;
}

#pragma mark _indexOf
- (int)_indexOf:(NSString*)targetStr searchText:(NSString*)searchText
{

    if (targetStr == nil) {
        return -1;
    }

    NSRange range = [targetStr rangeOfString:searchText];
    if (range.length > 0) {
        return (int)range.location;
    } else {
        return -1;
    }
}

+ (BOOL)_checkIsInt:(NSString*)str
{
    NSScanner* scan = [NSScanner scannerWithString:str];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
+ (BOOL)_checkIsFloat:(NSString*)str
{
    NSScanner* scan = [NSScanner scannerWithString:str];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}
+ (BOOL)_checkIsDouble:(NSString*)str
{
    NSScanner* scan = [NSScanner scannerWithString:str];
    double val;
    return [scan scanDouble:&val] && [scan isAtEnd];
}

@end
