
#import "UIFont.h"

@implementation UIFont (ex)

+(UIFont*)name:(NSString*)name size:(int)size{
        UIFont *font = [UIFont fontWithName:name size:size];
        return font;
}


@end
