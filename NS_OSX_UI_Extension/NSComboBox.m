
#import "NSComboBox.h"

@implementation NSComboBox (ex)

-(id)_getSelectItem_from_NSUserDefualt{
    
    NSDictionary*bindingInfo = [self infoForBinding:NSValueBinding];
    NSString* keyPath = [bindingInfo valueForKey:NSObservedKeyPathKey];
    
    keyPath = [keyPath _replace:@"values." replaceStr:@""];
    
    NSString*selectValut = [[NSUserDefaults standardUserDefaults] objectForKey:keyPath];

    return selectValut ;
}

-(id)_getDataRow_selected{
    
    NSDictionary*bindingInfo = [self infoForBinding:NSContentBinding];
    NSArrayController*arrayController = [bindingInfo valueForKey:NSObservedObjectKey];
    
    NSMutableArray* selectedObjects = arrayController.arrangedObjects;
    
    if([selectedObjects count] > 0){
        id dataRow = [selectedObjects objectAtIndex:[self indexOfSelectedItem]];
        return dataRow;
    }
    
    return selectedObjects;
    
}


/*
-(id)_getDataRow{
    
    NSDictionary*bindingInfo = [self infoForBinding:NSContentBinding];
    NSArrayController*arrayController = [bindingInfo valueForKey:NSObservedObjectKey];
    
    id selectedObjects = arrayController.selection;
    
    return selectedObjects;
    
}
*/



@end
