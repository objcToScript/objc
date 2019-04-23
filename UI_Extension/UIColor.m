
#import "UIColor.h"

@implementation UIColor (ex)


+ (UIColor*)red:(float)red green:(float)green blue:(float)blue alpha:(float)alpha{
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

#pragma mark hexをUIColorにする
+ (UIColor*)_getUIColorFromHex:(NSString*)colorCode
{

    
    
    colorCode = [self _replace:colorCode search:@"#" replaceStr:@""];
    return
        [UIColor
            colorWithRed:[self _getNumberFromHex:colorCode from:0] / 255.0
                   green:[self _getNumberFromHex:colorCode from:2] / 255.0
                    blue:[self _getNumberFromHex:colorCode from:4] / 255.0
                   alpha:1.0f];
}

#pragma mark hexをUIColorにする
+ (UIColor*)_getUIColorFromHex:(NSString*)colorCode alpha:(CGFloat)alpha
{

    colorCode = [self _replace:colorCode search:@"#" replaceStr:@""];

    return
        [UIColor
            colorWithRed:[self _getNumberFromHex:colorCode from:0] / 255.0
                   green:[self _getNumberFromHex:colorCode from:2] / 255.0
                    blue:[self _getNumberFromHex:colorCode from:4] / 255.0
                   alpha:alpha];
}

+ (UIColor*)_getUIColorFromHexWithAlpha:(NSString*)colorCode alpha:(CGFloat)alpha
{

    colorCode = [self _replace:colorCode search:@"#" replaceStr:@""];

    return
        [UIColor
            colorWithRed:[self _getNumberFromHex:colorCode from:0] / 255.0
                   green:[self _getNumberFromHex:colorCode from:2] / 255.0
                    blue:[self _getNumberFromHex:colorCode from:4] / 255.0
                   alpha:alpha];
}

#pragma mark rgbをUIColorにする
+ (UIColor*)_getUIColorFromRGB:(NSString*)colorCode
{
    colorCode = [self _replace:colorCode search:@"#" replaceStr:@""];

    NSRange range = [colorCode rangeOfString:@" "];
    if (range.length <= 0) {
        NSLog(@" RGBにスペースがない ");
        return [UIColor redColor];
    }

    NSArray* array = [colorCode componentsSeparatedByString:@" "];

    if ([array count] == 3) {

        UIColor* c = [UIColor
            colorWithRed:[[array objectAtIndex:0] intValue] / 255.0
                   green:[[array objectAtIndex:1] intValue] / 255.0
                    blue:[[array objectAtIndex:2] intValue] / 255.0
                   alpha:1.0f];

        return c;

    } else if ([array count] == 4) {
        UIColor* c = [UIColor
            colorWithRed:[[array objectAtIndex:0] intValue] / 255.0
                   green:[[array objectAtIndex:1] intValue] / 255.0
                    blue:[[array objectAtIndex:2] intValue] / 255.0
                   alpha:[[array objectAtIndex:3] floatValue]];

        return c;
    }

    return [UIColor redColor];
}

+ (unsigned int)_getNumberFromHex:(NSString*)colorCode from:(int)from
{
    NSString* hexString = [colorCode substringWithRange:NSMakeRange(from, 2)];
    NSScanner* hexScanner = [NSScanner scannerWithString:hexString];
    unsigned int intColor;
    [hexScanner scanHexInt:&intColor];
    return intColor;
}


#pragma mark replace
+ (NSString*)_replace:(NSString*)str search:(NSString*)search replaceStr:(NSString*)replaceStr
{
    NSString* result = @"";

    result = [str stringByReplacingOccurrencesOfString:search withString:replaceStr];

    return result;
}

@end
