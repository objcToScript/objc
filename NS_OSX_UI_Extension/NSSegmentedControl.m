
#import "NSSegmentedControl.h"

@implementation NSSegmentedControl (extension)


@dynamic fontSize;
@dynamic shadowColor;
@dynamic textColor;


-(void)_removeColorBorder{
    
}

-(void)setFontSize:(int)size{
    
}

-(void)setTextColor:(NSString*)colorCode{
    
    
}

-(id)_safeObjectAtIndex:(NSArray*)array index:(NSUInteger)index {
    if (index>=array.count) {
        return nil;
    }
    return [array objectAtIndex:index];
}


-(void)_setSelectImage:(NSImage*)image segment:(NSInteger)segment{
    [self setImage:image forSegment:segment];
}

-(NSImage*)_getSegmentImage:(NSInteger)segment{
   return [self imageForSegment:segment];
}


-(NSImage*)_imageColor:(NSColor*)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
   
    NSImage *image;

    return image;
}

-(void)setShadowColor:(NSString*)colorCode{
    NSArray *ary=[self subviews];
    for (id seg in ary)
        for (id label in [seg subviews])
            if ([label isKindOfClass:[NSTextField class]]) {
                [label setShadowColor:[colorCode _getNSColorFromHex]];
            }
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


@end
