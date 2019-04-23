
#import "NSTableColumn.h"

@implementation NSTableColumn (ex)


-(NSDictionary*)_getBindingInfoDic{
    
    NSDictionary*bindingDic = [self infoForBinding:@"value"];
    
    return bindingDic;
}


-(NSString*)_getKeyPath{
    
    NSDictionary*bindingDic = [self infoForBinding:@"value"];
    
    NSString*keyPath = [bindingDic objectForKey:@"NSObservedKeyPath"];
    
    if([keyPath _indexOf:@"."] != -1){
       return [[keyPath _split:@"."] objectAtIndex:1];
    }

    return keyPath;
}




@end
