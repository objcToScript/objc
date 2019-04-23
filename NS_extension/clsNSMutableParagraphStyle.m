
#import "clsNSMutableParagraphStyle.h"

@implementation NSMutableParagraphStyle (ex)

+(NSMutableParagraphStyle*)alignment:(NSTextAlignment)alignment lineHeight:(CGFloat)lineHeight paragraphSpacing:(int)paragraphSpacing{
    
    // NSMutableParagraphStyleオブジェクト
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];

    paragraph.alignment = alignment;
    
    paragraph.lineHeightMultiple = lineHeight;
    
    paragraph.paragraphSpacing = paragraphSpacing;

    return paragraph;
    
}





@end
