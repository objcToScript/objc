/*
    UIAlertView+Blocks.h
    David Yamnitsky
*/

#import <UIKit/UIKit.h>

typedef enum {
    alertViewStyleDefault=0,
    alertViewStyleSecureTextInput=1,
    alertViewStylePlainTextInput=2,
    alertViewStyleLoginAndPasswordInput=3
} kAlertViewStyle;

@interface UIAlertView (Block)

-(id)initWithTitle_Trans:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(id)otherButtonTitles;

+ (UIAlertView *)showWithTitle:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle
              otherButtonTitles:(id)otherButtonTitles
                alertViewStyle:(kAlertViewStyle)alertViewStyle
                    completion:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))completionBlock;



+ (UIAlertView *)showWithTitle:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle
              otherButtonTitles:(id)otherButtonTitles
                    completion:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))completionBlock;

 
- (void)showCompletion:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))completionBlock;
 
@end
