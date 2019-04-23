/*
    UIAlertView+Blocks.m
    David Yamnitsky
*/

#import "UIAlertView+Block.h"
#import <objc/runtime.h>

@interface UIAlertViewWrapper : NSObject <UIAlertViewDelegate>

@property (copy) void(^completionBlock)(UIAlertView *alertView, NSInteger buttonIndex);

@end

@implementation UIAlertViewWrapper

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.completionBlock)
        self.completionBlock(alertView, buttonIndex);
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    if (self.completionBlock)
        self.completionBlock(alertView, alertView.cancelButtonIndex);
}

@end

static const char kUIAlertViewWrapper;

@implementation UIAlertView (Block)



-(id)initWithTitle_Trans:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(id)otherButtonTitles{
  
    title = [clsTranslate _translate_basic:title];
    message = [clsTranslate _translate_basic:message];
    cancelButtonTitle = [clsTranslate _translate_basic:cancelButtonTitle];
    otherButtonTitles = [clsTranslate _translate_basic:otherButtonTitles];

  
  if([otherButtonTitles isEqual:@""]){
    otherButtonTitles = nil;
  }
  if([cancelButtonTitle isEqual:@""]){
    cancelButtonTitle = @"OK";
  }
  
  id alert =
  [self  initWithTitle:title message:message
                            delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil];
  
  return alert;
}


+ (UIAlertView *)showWithTitle:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle
              otherButtonTitles:(id)otherButtonTitles
                    completion:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))completionBlock
{
    

        title = [clsTranslate _translate_basic:title];        
        message = [clsTranslate _translate_basic:message];
        cancelButtonTitle = [clsTranslate _translate_basic:cancelButtonTitle];
        otherButtonTitles = [clsTranslate _translate_basic:otherButtonTitles];
  
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles:otherButtonTitles, nil];

    
    [alertView showCompletion:completionBlock];
    
    return alertView;
}




+ (UIAlertView *)showWithTitle:(NSString *)title
              message:(NSString *)message
    cancelButtonTitle:(NSString *)cancelButtonTitle
     otherButtonTitles:(id)otherButtonTitles
       alertViewStyle:(kAlertViewStyle)alertViewStyle
           completion:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))completionBlock
{
  

    title = [clsTranslate _translate_basic:title];
    
    message = [clsTranslate _translate_basic:message];
    cancelButtonTitle = [clsTranslate _translate_basic:cancelButtonTitle];
    otherButtonTitles = [clsTranslate _translate_basic:otherButtonTitles];

  
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles:otherButtonTitles, nil];

    if(alertViewStyle == alertViewStyleSecureTextInput){
        alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    }else if(alertViewStyle == alertViewStylePlainTextInput){
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    }else if(alertViewStyle == alertViewStyleLoginAndPasswordInput){
        alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    }
 
    [alertView showCompletion:completionBlock];

  return alertView;
}

- (void)showCompletion:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))completionBlock
{
    UIAlertViewWrapper *wrapper = [[UIAlertViewWrapper alloc] init];
    wrapper.completionBlock = completionBlock;
    self.delegate = wrapper;
    objc_setAssociatedObject(self, &kUIAlertViewWrapper, wrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self show];
}

@end
