#import "NSPopUpButton.h"

@implementation NSPopUpButton (ex)


-(id)_getData{
    
    NSDictionary*bindingInfo = [self infoForBinding:NSContentBinding];
    NSArrayController*arrayController = [bindingInfo valueForKey:NSObservedObjectKey];
    
    NSMutableArray* selectedObjects = arrayController.arrangedObjects;
    
    if([selectedObjects count] > 0){
        id dataRow = [selectedObjects objectAtIndex:[self indexOfSelectedItem]];
        return dataRow;
    }
    return nil;
}


-(int)_getIndex{
    int i=0;
    for(NSMenuItem*item in self.itemArray){
        if(self.selectedItem == item){
            return i;
        }
        i++;
    }
    return i;    
}



@end
