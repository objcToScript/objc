
#import "clsNSColor.h"

@implementation NSColor (ex)


//UIColor
+(NSColor*)_toNSColorFromHex:(NSString*)hex{
    
    if([hex isKindOfClass:[NSColor class]]){
        return (NSColor*)hex;
    }
    
   unsigned int a = [self _getNumberFromHex:hex rangeFrom:0]/255.0;
   unsigned int b =  [self _getNumberFromHex:hex rangeFrom:2]/255.0;
   unsigned int c =  [self _getNumberFromHex:hex rangeFrom:4]/255.0;
    
    return [NSColor
            colorWithRed:a
            green:b
            blue:c
            alpha:1.0f];
}


+(unsigned int)_getNumberFromHex:(NSString*)hex rangeFrom:(int)rangeFrom{
    
    NSString *hexString = [hex substringWithRange:NSMakeRange(rangeFrom, 2)];
    
    NSScanner* hexScanner = [NSScanner scannerWithString:hexString];
    
    unsigned int intColor;
    [hexScanner scanHexInt:&intColor];
    return intColor;
}


// color from hex
-(NSString*)_toString{
    
    NSString* hexString = [NSString stringWithFormat:@"#%02X%02X%02X",
                           (int) (self.redComponent * 0xFF), (int) (self.greenComponent * 0xFF),
                           (int) (self.blueComponent * 0xFF)];
    
    return hexString;
}



@end
