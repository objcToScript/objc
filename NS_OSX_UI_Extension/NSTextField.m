
#import "NSTextField.h"

@implementation NSTextField (ex)


-(void)_focus_out{ 
     [self.window makeFirstResponder:nil];
}

-(void)_focus_in{
    [self.window makeFirstResponder:self];
}

-(id)_getDataRow_selected{
    
    NSDictionary*bindingInfo = [self infoForBinding:NSContentBinding];
    NSArrayController*arrayController = [bindingInfo valueForKey:NSObservedObjectKey];
    
    id selectedObjects = arrayController.selection;
  
    return selectedObjects;
    
}


@end
