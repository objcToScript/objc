
#import "UIView.h"

@implementation UIView (ex)

//viewA->viewB
//viewAの座標をviewB上の座標へ変換する
- (CGPoint)_convetView_Point:(UIView*)targetView
{
    CGPoint targetPoint = [self convertPoint:self.frame.origin toView:targetView];
    return targetPoint;
}
//viewAのRectをviewB上のRectへ変換する
- (CGRect)_convetView_Rect:(UIView*)targetView
{
    CGRect targetRect = [self convertRect:self.frame toView:targetView];
    return targetRect;
}

- (void)_getView_from_RestrationIdOnly:(NSMutableArray*)array isRootViewInsert:(BOOL)isRootViewInsert
{

    [self _getView_from_RestrationIdOnly_do:array view_t:self isRootViewInsert:isRootViewInsert];

}

- (void)_getView_from_RestrationIdOnly_do:(NSMutableArray*)array view_t:(UIView*)view_t isRootViewInsert:(BOOL)isRootViewInsert
{

    if (isRootViewInsert == YES && view_t.restorationIdentifier != nil && ![view_t.restorationIdentifier isEqual:@""] && ![view_t.restorationIdentifier isEqual:@"(null)"]) {
        [array addObject:view_t];
    }

    for (UIView* con in view_t.subviews) {


        if (con != nil && con.restorationIdentifier != nil && ![con.restorationIdentifier isEqual:@""] &&
            ![con.restorationIdentifier isEqual:@"(null)"]) {
            [array addObject:con];
        }
        if (con != nil && [con isKindOfClass:[UIView class]] && [[con subviews] count] > 0) {
            [self _getView_from_RestrationIdOnly_do:array view_t:con isRootViewInsert:YES];
        }
    }

}

//回転時に利用する
//baseViewにtargetViewのプロパティをフェッチする
- (void)_fetchProperty_from_Rotation:(UIView*)targetView
{

    NSMutableArray* baseArray = [NSMutableArray new];
    NSMutableArray* targetArray = [NSMutableArray new];

    [self _getView_from_RestrationIdOnly:baseArray isRootViewInsert:YES];
    [targetView _getView_from_RestrationIdOnly:targetArray isRootViewInsert:YES];

    for (UIView* baseView1 in baseArray) {
        for (UIView* targetView1 in targetArray) {
            if ([baseView1.restorationIdentifier isEqual:targetView1.restorationIdentifier]) {
                [baseView1 _fetchProperty:targetView1];
                continue;
            }
        }
    }
}

- (void)_fetchProperty:(UIView*)targetView
{

    self.width = targetView.width;
    self.height = targetView.height;
    self.x = targetView.x;
    self.y = targetView.y;

    //self.contentMode = targetView.contentMode;
    self.autoresizingMask = targetView.autoresizingMask;

    if ([self isKindOfClass:UILabel.class] &&
        [targetView isKindOfClass:UILabel.class]) {
        ((UILabel*)self).textAlignment = ((UILabel*)targetView).textAlignment;
    }
}

- (void)_setAutoSizeWidthHeight
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)_setAutoSizeWidthHeightMargin
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
}

- (void)_setClick:(id)target selecterStr:(NSString*)selecterStr userInfo:(id)userInfo
{
    if (target != nil && selecterStr != nil) {
        [self _setClick:target selecter:NSSelectorFromString(selecterStr) userInfo:userInfo];
    }
}

- (void)_removeGestureAll
{
    for (UIGestureRecognizer* gesture in self.gestureRecognizers) {
        [self removeGestureRecognizer:gesture];
    }
}

- (void)_setClick:(id)target selecter:(SEL)selecter userInfo:(id)userInfo
{

    if (target != nil && [target respondsToSelector:selecter]) {

        UITapGestureRecognizerEx* tapGesture =
            [[UITapGestureRecognizerEx alloc] initWithTarget:target
                                                      action:selecter];
        self.userInteractionEnabled = YES;

        tapGesture.numberOfTapsRequired = 1;

        if (userInfo != nil) {
            tapGesture.userInfo = userInfo;
        }

        [self addGestureRecognizer:tapGesture];
    }
}

- (void)_addSubViews:(UIView*)insertView tag:(int)tag
{
    if ([self viewWithTag:tag] == nil) {
        [self addSubview:insertView];
    }
}

- (void)_deleteSubViews:(int)tag
{
    if ([self viewWithTag:tag] != nil) {
        [[self viewWithTag:tag] removeFromSuperview];
    }
}
- (void)_removeSubViews:(int)tag
{
    if ([self viewWithTag:tag] != nil) {
        [[self viewWithTag:tag] removeFromSuperview];
    }
}

- (void)_removeSubViews_from_view:(UIView*)targetView
{
    for (UIView* view1 in self.subviews) {
        if ([targetView isEqual:view1]) {
            [view1 removeFromSuperview];
            break;
        }
        if ([view1 isKindOfClass:UIView.class] &&
            [[view1 subviews] count] > 0) {
            [self _removeSubViews_do:targetView subViews:view1];
        }
    }
}

- (void)_removeSubViews_do:(UIView*)targetView subViews:(UIView*)subViews
{
    for (UIView* view1 in subViews.subviews) {
        if ([targetView isEqual:view1]) {
            [view1 removeFromSuperview];
            break;
        }
        if ([view1 isKindOfClass:UIView.class] &&
            [[view1 subviews] count] > 0) {
            [self _removeSubViews_do:targetView subViews:view1];
        }
    }
}

//一時停止
- (void)_pauseAnimations
{
    CFTimeInterval paused_time = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = paused_time;
}

//UIアニメーションを一時停止を解除する
- (void)_resumeAnimations
{
    CFTimeInterval paused_time = [self.layer timeOffset];
    self.layer.speed = 1.0f;
    self.layer.timeOffset = 0.0f;
    self.layer.beginTime = 0.0f;
    CFTimeInterval time_since_pause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - paused_time;
    self.layer.beginTime = time_since_pause;
}

#pragma mark bindのConを取得する
- (id)_getCon_from_RestrationId:(NSString*)restrationId
{

    id conArray = [self _getCon_from_RestrationId_do:self restrationId:restrationId];

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
        if (con != nil && [con isKindOfClass:[UIView class]] && [[con subviews] count] > 0) {
            id result = [self _getCon_from_RestrationId_do:con restrationId:restrationId];
            if (result != nil) {
                return result;
            }
        }
    }

    return nil;
}

- (void)_addBottomBar:(UIColor*)borderColor borderWidth:(int)borderWidth
{

    CALayer* border = [CALayer layer];
    border.borderColor = borderColor.CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height);
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
}

//本命はtableview
- (void)_mkBorderLine:(int)size hex:(NSString*)hex
{

    CGColorRef color = nil;

    if (hex != nil && ![hex isEqual:@""]) {
        color = [hex _getUIColorFromHex].CGColor;
    } else {
        color = [UIColor colorWithRed:160 / 255 green:160 / 255 blue:160 / 255 alpha:0.7].CGColor;
    }

    [[self layer] setBorderColor:color];
    [[self layer] setBorderWidth:size];
}

#pragma mark 真ん中の位置を取得する
- (CGRect)_getCenterFrameWithView:(UIView*)argView parent:(UIView*)argParentView
{
    CGFloat x;
    CGFloat y;
    CGFloat width;
    CGFloat height;

    CGFloat margin_x;
    CGFloat margin_y;

    width = argView.frame.size.width;
    height = argView.frame.size.height;

    margin_x = argParentView.frame.size.width - width;
    margin_y = argParentView.frame.size.height - height;

    x = margin_x / 2.0f;
    y = margin_y / 2.0f;

    return CGRectMake(x, y, width, height);
}

- (void)_setBorderLine:(CGFloat)kadomaru borderSize:(CGFloat)borderSize borderColor:(NSString*)borderColor
{

    if (borderColor == nil || [borderColor isEqual:@""]) {
        borderColor = @"cecece";
    }

    //layerView.center = uiView.center;
    //枠線
    self.layer.borderWidth = borderSize;
    //枠線の色
    self.layer.borderColor = [borderColor _getUIColorFromHex].CGColor;
    //角丸
    self.layer.cornerRadius = kadomaru;
}

#pragma mark シャドウを追加する
- (void)_mkShadou
{

    CALayer* caLayer = self.layer;
    caLayer.rasterizationScale = [[UIScreen mainScreen] scale];
    caLayer.shadowRadius = 3.7f;
    caLayer.shadowOpacity = 0.5f;
    caLayer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    caLayer.shouldRasterize = YES;
}

- (UIColor*)_getUIColorFromHex:(NSString*)hex
{
    return
        [UIColor
            colorWithRed:[self _getNumberFromHex:hex rangeFrom:0] / 255.0
                   green:[self _getNumberFromHex:hex rangeFrom:2] / 255.0
                    blue:[self _getNumberFromHex:hex rangeFrom:4] / 255.0
                   alpha:1.0f];
}

- (unsigned int)_getNumberFromHex:(NSString*)hex rangeFrom:(int)from
{
    NSString* hexString = [hex substringWithRange:NSMakeRange(from, 2)];
    NSScanner* hexScanner = [NSScanner scannerWithString:hexString];
    unsigned int intColor;
    [hexScanner scanHexInt:&intColor];
    return intColor;
}

- (void)_addTBorderWithColor:(NSString*)hex
                 borderWidth:(CGFloat)borderWidth
                       isTop:(BOOL)isTop
                    isBottom:(BOOL)isBottom
                      isLeft:(BOOL)isLeft
                     isRight:(BOOL)isRight
{

    CGColorRef color = [self _getUIColorFromHex:hex].CGColor;

    if (isTop) {
        CALayer* border = [CALayer layer];
        border.backgroundColor = color;
        border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
        [self.layer addSublayer:border];
    }

    if (isBottom) {
        CALayer* border = [CALayer layer];
        border.backgroundColor = color;
        border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
        [self.layer addSublayer:border];
    }

    if (isLeft) {
        CALayer* border = [CALayer layer];
        border.backgroundColor = color;
        border.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
        [self.layer addSublayer:border];
    }
    if (isRight) {
        CALayer* border = [CALayer layer];
        border.backgroundColor = color;
        border.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
        [self.layer addSublayer:border];
    }
}

- (UIViewController*)_getViewController
{

    @try {

        UIResponder* responder = self;

        Class vcc = [UIViewController class];
        for (id test in [self subviews]) {
            responder = [test nextResponder];
            if ([responder isKindOfClass:vcc]) {
                return (UIViewController*)responder;
            }
        }

    } @catch (NSException* exception) {
        NSLog(@"  %@", exception.description);
        ////[exception _cracshReportReq:crashReportUrl appId:serverSideAppId];
    }

    return nil;
}

- (UISplitViewController*)_getSplitViewController
{

    @try {

        UIResponder* responder = self;

        for (id test in [self subviews]) {
            responder = [test nextResponder];
            if ([responder isKindOfClass:[UISplitViewController class]]) {
                return (UISplitViewController*)responder;
            }
        }

    } @catch (NSException* exception) {
        NSLog(@"  %@", exception.description);
        // //[exception _cracshReportReq:crashReportUrl appId:serverSideAppId];
    }

    return nil;
}

- (CGFloat)x
{
    return [self left];
}

- (void)setX:(CGFloat)x
{
    [self setLeft:x];
}

- (CGFloat)y
{
    return [self top];
}

- (void)setY:(CGFloat)y
{
    [self setTop:y];
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
