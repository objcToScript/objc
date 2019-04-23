
#import "UNNotification.h"

@implementation UNNotification (ex)

- (UNNotificationContent*)_getContent
{
    return self.request.content;
}

@end
