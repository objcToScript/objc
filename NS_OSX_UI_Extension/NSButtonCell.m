
#import <Cocoa/Cocoa.h>

#import "NSButtonCell.h"

@implementation NSButtonCell (ex)

-(id)_getDataRow_selected{
    
    NSDictionary*bindingInfo = [self infoForBinding:NSContentBinding];
    NSArrayController*arrayController = [bindingInfo valueForKey:NSObservedObjectKey];
    
    id selectedObjects = arrayController.selection;

    return selectedObjects;
    
}


-(BOOL)_isChecked{
    
    if ([self state] == NSOnState) {
        return YES;
    }
     return NO;    
}

-(void)_setOff{
    [self setState:NSOffState];
}
-(void)_setOn{
    [self setState:NSOnState];
}





@end
