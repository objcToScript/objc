
#import "clsNSString.h"

#if TARGET_OS_OSX

#import <AppKit/AppKit.h>

@interface NSString (MacOS)

-(NSColor*)_getNSColorFromHex;
-(NSColor*)_getNSColorFromHexWithAlpha:(CGFloat)alpha;
-(NSColor*)_getNSColorFromHex:(CGFloat)alpha;
-(NSColor*)_getNSColorFromRGB;


@end

#endif

