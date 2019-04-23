
#import "NSLabel.h"

@implementation NSTextField(ex)

-(id)_getDataRow_selected{
    
    NSDictionary*bindingInfo = [self infoForBinding:NSContentBinding];
    NSArrayController*arrayController = [bindingInfo valueForKey:NSObservedObjectKey];
    
    id selectedObjects = arrayController.selection;
    
    return selectedObjects;
    
}


-(void)_setLableColor:(NSColor*)textColor{

    self.textColor = textColor;

}


-(void)_setClick:(id)target selecter:(SEL)selecter{
    
    if(target != nil && [target respondsToSelector:selecter]){

        NSClickGestureRecognizer *tapGesture =
        [[NSClickGestureRecognizer alloc] initWithTarget:target
                                                action:selecter];
       // self.userInteractionEnabled = YES;
        tapGesture.numberOfClicksRequired = 1;
        [self addGestureRecognizer:tapGesture];
    }
}

-(CGFloat)_getHeightFix:(CGFloat)textFontSize{

    @try {
        // 表示最大幅・高さ
        CGSize  maxSize = CGSizeMake(self.frame.size.width, CGFLOAT_MAX);

        // 表示するフォントサイズ
        NSDictionary *attr = @{NSFontAttributeName: [NSFont systemFontOfSize:textFontSize]};
        CGSize modifiedSize;
        
        // 以上踏まえた上で、表示に必要なサイズ
        if([self.stringValue respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
            
            modifiedSize = [self.stringValue boundingRectWithSize:maxSize
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:attr
                                                   context:nil
                            ].size;
            return modifiedSize.height;
            
        }
        
        /*
        else if( [self.stringValue respondsToSelector:@selector(sizeWithFont:constrainedToSize:)]){
            
            self.stringValue size
            
            modifiedSize = [self.stringValue sizeWithFont:[NSFont systemFontOfSize:textFontSize] constrainedToSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)];
            return modifiedSize.height;
        }
        */
        
    }  @catch (NSException *exception) {
        //
        
    }
    
    return 0;
    
}

@end








