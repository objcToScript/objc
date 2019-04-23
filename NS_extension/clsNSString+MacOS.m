#import "clsNSString+MacOS.h"

#if TARGET_OS_OSX

@implementation NSString (MacOS)

#pragma mark hexをNSColorにする
-(NSColor*)_getNSColorFromHex{
    return
    [NSColor
     colorWithRed:[self _getNumberFromHex:0]/255.0
     green:[self _getNumberFromHex:2]/255.0
     blue:[self _getNumberFromHex:4]/255.0
     alpha:1.0f];
}

#pragma mark hexをNSColorにする
-(NSColor*)_getNSColorFromHex:(CGFloat)alpha{
    return
    [NSColor
     colorWithRed:[self _getNumberFromHex:0]/255.0
     green:[self _getNumberFromHex:2]/255.0
     blue:[self _getNumberFromHex:4]/255.0
     alpha:alpha];
}

-(NSColor*)_getNSColorFromHexWithAlpha:(CGFloat)alpha{
    return
    [NSColor
     colorWithRed:[self _getNumberFromHex:0]/255.0
     green:[self _getNumberFromHex:2]/255.0
     blue:[self _getNumberFromHex:4]/255.0
     alpha:alpha];
}


#pragma mark rgbをNSColorにする
-(NSColor*)_getNSColorFromRGB{
    
    if([self _indexOf:@" "] == -1){
        NSLog(@" RGBにスペースがない "     );
        return [NSColor redColor];
    }
    
    NSArray*array = [self _split:@" "];
    
    if([array count] == 3){

        NSColor*c = [NSColor
                     colorWithRed:[[array objectAtIndex:0] intValue]/255.0
                     green:[[array objectAtIndex:1] intValue]/255.0
                     blue: [[array objectAtIndex:2] intValue]/255.0
                     alpha:1.0f];
        
        return c;
        
    }else if([array count] == 4){
        NSColor *c = [NSColor
                      colorWithRed:[[array objectAtIndex:0] intValue]/255.0
                      green:[[array objectAtIndex:1] intValue]  /255.0
                      blue: [[array objectAtIndex:2] intValue] /255.0
                      alpha:[[array objectAtIndex:3] floatValue]];
        
        return c;
        
    }
    
    return [NSColor redColor];
    
}




@end

#endif






