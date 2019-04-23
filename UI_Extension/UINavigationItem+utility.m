
#import "UINavigationItem+utility.h"
//#import "clsUtility.h"

@implementation UINavigationItem (utility)


-(void)_setTitle:(NSString*)title{

  UILabel* navigationTitle = [[UILabel alloc] init];
  //ラベルの大きさと位置を調整
  navigationTitle.frame = CGRectMake(78,-2,160,33);
  navigationTitle.text = title;
  navigationTitle.font =[UIFont fontWithName:@"HiraKakuProN-W3" size:16];    //fontサイズ
  
  navigationTitle.backgroundColor = [UIColor clearColor];     //Labelの背景色
  navigationTitle.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];     //影の部分
  
  //文字揃え　（NSTextAlignmentLightとNSTextAligmentLeftもある）
  navigationTitle.textAlignment = NSTextAlignmentCenter;
  navigationTitle.textColor = [UIColor blackColor];//[clsUtility _getUIColorFromHex:@"5A5B5B"];    //文字色
  
  //navigationItemのtitleViewをLabelに置き換える
  self.titleView = navigationTitle;

}


@end
