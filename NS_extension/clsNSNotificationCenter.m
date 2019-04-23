
#import "clsNSNotificationCenter.h"

@implementation NSNotificationCenter (ex)

/*
-(void)_addNSNotificationCenter{
    
    __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName: kDetail object: nil queue: nil usingBlock:^(NSNotification *notification){

        UIViewController *iv = (UIViewController *)[notification object];
        NSDictionary *userInfo = [notification userInfo];
        
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
        observer = nil;
        
    }];
    
}
 
-(void)_removeNSNotificationCenter{
    
    NSDictionary *dic = @{@"name": @"sasami", @"sex":@"female"};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kDetail object:self userInfo:dic];
    
}
*/

@end
