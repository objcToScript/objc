
#import "UIApplication.h"

@implementation UIApplication (ex)

+ (id<UIApplicationDelegate>)_getApplicationDeleagete
{

    id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];

    return delegate;
}

- (void)_setLocalNotification:(UILocalNotification*)notification
{
    [self scheduleLocalNotification:notification];
}

- (void)_cancelLocalNotification:(UILocalNotification*)notification
{
    [self cancelLocalNotification:notification];
}

@end
