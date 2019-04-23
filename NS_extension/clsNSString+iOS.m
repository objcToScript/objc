#import "clsNSString+iOS.h"

#if TARGET_OS_IOS

@implementation NSString (iOS)

#pragma mark hexをUIColorにする
- (UIColor*)_getUIColorFromHex
{
    return
        [UIColor
            colorWithRed:[self _getNumberFromHex:0] / 255.0
                   green:[self _getNumberFromHex:2] / 255.0
                    blue:[self _getNumberFromHex:4] / 255.0
                   alpha:1.0f];
}

#pragma mark hexをUIColorにする
- (UIColor*)_getUIColorFromHex:(CGFloat)alpha
{
    return
        [UIColor
            colorWithRed:[self _getNumberFromHex:0] / 255.0
                   green:[self _getNumberFromHex:2] / 255.0
                    blue:[self _getNumberFromHex:4] / 255.0
                   alpha:alpha];
}

- (UIColor*)_getUIColorFromHexWithAlpha:(CGFloat)alpha
{
    return
        [UIColor
            colorWithRed:[self _getNumberFromHex:0] / 255.0
                   green:[self _getNumberFromHex:2] / 255.0
                    blue:[self _getNumberFromHex:4] / 255.0
                   alpha:alpha];
}

#pragma mark rgbをUIColorにする
- (UIColor*)_getUIColorFromRGB
{

    if ([self _indexOf:@" "] == -1) {
        NSLog(@" RGBにスペースがない ");
        return [UIColor redColor];
    }

    NSArray* array = [self _split:@" "];

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

@end

#endif
