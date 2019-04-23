#import "clsNSMutableAttributedString.h"

@implementation NSMutableAttributedString (ex)

+(NSMutableAttributedString*)string:(NSString*)string attributes:(NSDictionary<NSAttributedStringKey, id>*)attributes{
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string attributes:attributes];

    return attrStr;
}


@end
