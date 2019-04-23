
#import "UIToolbar.h"

@implementation UIToolbar (ex)

- (void)_backImage:(NSString*)imageName
{

    for (NSString* key in [[NSArray alloc] initWithObjects:@".png", @".jpg", @".gif", @".PNG", nil]) {
        NSRange range = [imageName rangeOfString:key];
        if (range.length > 0) {
            imageName = [imageName stringByReplacingOccurrencesOfString:key withString:@""];
        }
    }

    NSString* myFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:imageName];
    UIImage* image = [[UIImage alloc] initWithContentsOfFile:myFilePath];

    [self setBackgroundImage:image
          forToolbarPosition:UIToolbarPositionAny
                  barMetrics:UIBarMetricsDefault];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
