
#import "clsNSTimer.h"

@implementation NSTimer (ex)

/*
 
 __block int i = 10;
 
 __block NSTimer*timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:[NSBlockOperation blockOperationWithBlock:^{
 
 if(i < 1){
 [timer invalidate];
 return ;
 }
 
 i--;
 
 }] selector:@selector(main) userInfo:nil repeats:YES];
 
 
 
 */

- (void)_stop
{
    if ([self isValid]) {
        [self invalidate];
    }
}
- (void)_start
{
    [self fire];
}

@end
