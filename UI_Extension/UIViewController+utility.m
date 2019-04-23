
#import "UIViewController+utility.h"

@implementation UIViewController (utility)

//ストリーボードから取得時大きさがうまく取得できないため 修正する必要がある preferredContentSizeを再設定すること
//縦回転 w 320
//横回転 w 568
//要確認
//StoryBoardからViewConをインスタンスで取った後に大きさを修正する
- (void)_widthHeightFix
{

    if (!CGSizeEqualToSize(CGSizeZero, self.preferredContentSize)) {

        self.view.width = self.preferredContentSize.width * [clsUtility _getHiritu].x;
        self.view.height = self.preferredContentSize.height * [clsUtility _getHiritu].x;
    }
}

- (void)_widthHeightFix_fromViewCon:(UIViewController*)fromViewCon
{

    if (!CGSizeEqualToSize(CGSizeZero, self.preferredContentSize)) {

        self.view.width = fromViewCon.preferredContentSize.width * [clsUtility _getHiritu].x;
        self.view.height = fromViewCon.preferredContentSize.height * [clsUtility _getHiritu].x;
    }
}

//指定したviewConが何個あるか
- (int)_getChildViewConNum:(NSArray*)restorationIdArray
{
    int hitNum = 0;
    for (int i = 0; i < (int)self.childViewControllers.count; i++) {
        UIViewController* viewCon1 = [self.childViewControllers objectAtIndex:i];
        if ([restorationIdArray containsObject:viewCon1.restorationIdentifier]) {
            hitNum++;
        }
    }

    return hitNum;
}

//指定したviewConのみ下限より上を削除する
- (void)_removeChildViewConLimitNum_Desc:(int)kagenNum restorationIdArray:(NSArray*)restorationIdArray
{
    int hitNum = 0;
    for (int i = (int)self.childViewControllers.count - 1; i > -1; i--) {
        UIViewController* viewCon1 = [self.childViewControllers objectAtIndex:i];
        if ([restorationIdArray containsObject:viewCon1.restorationIdentifier]) {
            hitNum++;
        }
    }
    if (hitNum > kagenNum) {
        int deleteNum = hitNum - kagenNum;
        hitNum = 0;
        for (int i = (int)self.childViewControllers.count - 1; i > -1; i--) {
            UIViewController* viewCon1 = [self.childViewControllers objectAtIndex:i];
            if ([restorationIdArray containsObject:viewCon1.restorationIdentifier]) {
                [viewCon1.view removeFromSuperview];
                [viewCon1 removeFromParentViewController];
                hitNum++;
                if (hitNum >= deleteNum) {
                    break;
                }
            }
        }
    }
}

//指定したviewConのみ下限より上を削除する
- (void)_removeChildViewConLimitNum_Asc:(int)kagenNum restorationIdArray:(NSArray*)restorationIdArray
{

    int hitNum = 0;
    for (int i = 0; i < (int)self.childViewControllers.count; i++) {
        UIViewController* viewCon1 = [self.childViewControllers objectAtIndex:i];
        if ([restorationIdArray containsObject:viewCon1.restorationIdentifier]) {
            hitNum++;
        }
    }
    if (hitNum > kagenNum) {
        int deleteNum = hitNum - kagenNum;
        hitNum = 0;
        for (int i = 0; i < (int)self.childViewControllers.count; i++) {
            UIViewController* viewCon1 = [self.childViewControllers objectAtIndex:i];
            if ([restorationIdArray containsObject:viewCon1.restorationIdentifier]) {
                [viewCon1.view removeFromSuperview];
                [viewCon1 removeFromParentViewController];
                hitNum++;
                if (hitNum >= deleteNum) {
                    break;
                }
            }
        }
    }
}

- (void)_removeChildViewCon:(NSArray*)removeRestorationIdArray
    exceptRestorationIdArray:(NSArray*)exceptRestorationIdArray
{

    for (UIViewController* viewCon1 in self.childViewControllers) {

        if ([exceptRestorationIdArray containsObject:viewCon1.restorationIdentifier]) {
            continue;
        }
        if ([removeRestorationIdArray containsObject:viewCon1.restorationIdentifier]) {
            [viewCon1.view removeFromSuperview];
            [viewCon1 removeFromParentViewController];
        }
    }
}

- (UIViewController*)_getViewConWithRestorationId:(NSString*)restorationId
{
    for (UIViewController* viewCon1 in self.childViewControllers) {

        NSLog(@" restorationIdentifier  %@", viewCon1.restorationIdentifier);

        if ([viewCon1.restorationIdentifier isEqual:restorationId]) {
            return viewCon1;
        }
    }
    return nil;
}

- (void)_removeViewConWithRestorationId:(NSString*)restorationId
{
    for (UIViewController* viewCon1 in self.childViewControllers) {
        if ([viewCon1.restorationIdentifier isEqual:restorationId]) {
            [viewCon1.view removeFromSuperview];
            [viewCon1 removeFromParentViewController];
        }
    }
}

- (void)_addViewConWithView:(UIViewController*)viewCon targetInsertView:(UIView*)targetInsertView
{

    [self addChildViewController:viewCon];
    [targetInsertView addSubview:viewCon.view];
}

- (void)_addViewConWithView:(UIViewController*)viewCon
{

    [self addChildViewController:viewCon];
    [self.view addSubview:viewCon.view];
}

- (void)_removeViewConWithView
{

    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (id)_getParentViewCon
{

    UIViewController* vc = self.presentingViewController;

    return vc;
}

//viewDidAppearで　viewDidLoadは無理
// 表示する
- (void)_showViewCon:(UIViewController*)viewCon isAnime:(BOOL)isAnime
{

    [self presentViewController:viewCon
                       animated:isAnime
                     completion:^{
                     }];
}

- (void)_showViewCon:(UIViewController*)viewCon isAnime:(BOOL)isAnime func:(void (^)(NSString*))func
{
    [self presentViewController:viewCon
                       animated:isAnime
                     completion:^{
                         func(@"");
                     }];
}

// 閉じる
- (void)_close:(BOOL)isAnime
{
    [self dismissViewControllerAnimated:isAnime
                             completion:^{

                             }];
}

- (void)_close:(BOOL)isAnime func:(void (^)(NSString*))func
{
    [self dismissViewControllerAnimated:isAnime
                             completion:^{
                                 func(@"");
                             }];
}

// 次の画面を呼ぶ
- (void)_nextViewCon:(NSString*)Identifier sender:(id)sender
{
    [self performSegueWithIdentifier:Identifier sender:sender];
}
/*
 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
 if([[segue identifier] isEqualToString:@"identifier名"]) {
 //遷移先のViewController
 NextViewController *nextViewController = [segue destinationViewController];
 }
 }
 */

// スワイプジェスチャーを作成して、登録する。
- (void)_mkSwipGesture
{

    UISwipeGestureRecognizerEx* swipe = [[UISwipeGestureRecognizerEx alloc]
        initWithTarget:self
                action:@selector(_swipe:)];
    // スワイプの方向は右方向を指定する。
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    // スワイプ動作に必要な指は1本と指定する。
    swipe.numberOfTouchesRequired = 1;

    swipe.viewCon = self;

    [self.view addGestureRecognizer:swipe];
}

- (void)_swipe:(UISwipeGestureRecognizerEx*)gesture
{
    if (gesture.viewCon.navigationController.viewControllers.count > 1) {
        [gesture.viewCon.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark bindのConを取得する
- (id)_getCon_from_RestrationId:(NSString*)restrationId
{

    id conArray = [self _getCon_from_RestrationId_do:self.view restrationId:restrationId];

    return conArray;
}

- (id)_getCon_from_RestrationId_do:(UIView*)view_t restrationId:(NSString*)restrationId
{

    if ([view_t.restorationIdentifier isEqual:restrationId]) {
        return view_t;
    }

    for (UIView* con in view_t.subviews) {
        if (con != nil && [con.restorationIdentifier isEqual:restrationId]) {
            return con;
            break;
        }
        if (con != nil && [con isKindOfClass:[UIView class]] && [con subviews] > 0) {
            id result = [self _getCon_from_RestrationId_do:con restrationId:restrationId];
            if (result != nil) {
                return result;
            }
        }
    }

    return nil;
}

#pragma mark Conを取得する
- (NSMutableArray*)_getAllCon
{

    NSMutableArray* newArray = [NSMutableArray new];
    [self _getAllCon_do:self.view newArray:newArray];

    return newArray;
}

- (NSMutableArray*)_getAllCon_do:(UIView*)view_t newArray:(NSMutableArray*)newArray
{

    for (id con in view_t.subviews) {

        if ([con isKindOfClass:[UIControl class]]) {
            [newArray addObject:con];
        }

        if ([con isKindOfClass:[UIView class]]) {
            [self _getAllCon_do:con newArray:newArray];
            continue;
        }
    }

    return newArray;
}

- (NSMutableArray*)_getAllBind_do:(UIView*)view_t newArray:(NSMutableArray*)newArray
{

    for (id con in view_t.subviews) {

        if ([con respondsToSelector:@selector(_setBind:)]) {
            [newArray addObject:con];
            continue;
        }
        if ([con isKindOfClass:[UIView class]]) {
            [self _getAllBind_do:con newArray:newArray];
        }
    }

    return newArray;
}

#pragma mark すべてのbindConにデーターをセットする
- (void)_setAllBind:(id)dic
{
    [self _setAllBind_do:self.view dic:dic];
}

- (void)_setAllBind_do:(UIView*)view_t dic:(id)dic
{

    for (id con in view_t.subviews) {
        if ([con respondsToSelector:@selector(_setBind:)]) {
            [con performSelector:@selector(_setBind:) withObject:dic];
            continue;
        }
        if ([con isKindOfClass:[UIView class]]) {
            [self _setAllBind_do:con dic:dic];
        }
    }
}

@end
