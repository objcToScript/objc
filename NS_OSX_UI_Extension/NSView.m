
#import "NSView.h"

@implementation NSView(ex)


#pragma mark bindのConを取得する
-(id)_getCon_from_IdentifierId:(NSString*)identifierId{
    
    id conArray = [self _getCon_from_getCon_from_IdentifierId_do:self identifierId:identifierId];
    
    return conArray;
    
}

-(id)_getCon_from_getCon_from_IdentifierId_do:(NSView*)view_t identifierId:(NSString*)identifierId{
    
    for (NSView* con in view_t.subviews) {
        
        if(con != nil && [con.identifier isEqual:identifierId]){
            return con;
            break;
        }
        if(con != nil && [con isKindOfClass:[NSView class]] &&
           [[con subviews] count] > 0){
            id result = [self _getCon_from_getCon_from_IdentifierId_do:con identifierId:identifierId ];
            if(result != nil){
                return result;
                
            }
        }
    }
    
    return nil;
}


-(void)_addSubViews:(NSView*)insertView tag:(int)tag{
    if([self viewWithTag:tag] == nil){
        [self addSubview:insertView];
    }
}


-(void)_deleteSubViews:(int)tag{
    if([self viewWithTag:tag] != nil){
        [[self viewWithTag:tag] removeFromSuperview];
    }
}
-(void)_removeSubViews:(int)tag{
    if([self viewWithTag:tag] != nil){
        [[self viewWithTag:tag] removeFromSuperview];
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



-(void)_addBottomBar:(NSColor*)borderColor borderWidth:(int)borderWidth{
    
    CALayer *border = [CALayer layer];
    border.borderColor = borderColor.CGColor;
    //border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height);
    border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
    
}

//本命はtableview
-(void)_mkBorderLine:(int)size hex:(NSString*)hex{
    
    CGColorRef color = nil;

    if(hex != nil && ![hex isEqual:@""]){
        color = [hex _getNSColorFromHex].CGColor;
    }else{
        color = [NSColor colorWithRed:160 / 255 green:160 / 255 blue:160 / 255 alpha:0.7].CGColor;
    }
    
    [[self layer] setBorderColor:color];
    [[self layer] setBorderWidth:size];
    
}



#pragma mark 真ん中の位置を取得する
-(CGRect)_getCenterFrameWithView:(NSView*)argView parent:(NSView*)argParentView{
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


-(void)_setBorderLine:(CGFloat)kadomaru borderSize:(CGFloat)borderSize borderColor:(NSString*)borderColor{
    
    if(borderColor == nil || [borderColor isEqual:@""]){
     borderColor = @"cecece";
    }
    
    
    //layerView.center = uiView.center;
    //枠線
    self.layer.borderWidth = borderSize;
    //枠線の色
    self.layer.borderColor = [borderColor _getNSColorFromHex].CGColor;
    //角丸
    self.layer.cornerRadius = kadomaru;
    
}


#pragma mark シャドウを追加する
-(void)_mkShadou{
    
    CALayer *caLayer = self.layer;
    //caLayer.rasterizationScale = [[NSWindow mainScreen] scale];
    caLayer.shadowRadius = 3.7f;
    caLayer.shadowOpacity = 0.5f;
    caLayer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    caLayer.shouldRasterize = YES;
    
}




-(NSColor*)_getUIColorFromHex:(NSString*)hex{
    return
    [NSColor
     colorWithRed:[self _getNumberFromHex:hex rangeFrom:0]/255.0
     green:[self _getNumberFromHex:hex rangeFrom:2]/255.0
     blue:[self _getNumberFromHex:hex rangeFrom:4]/255.0
     alpha:1.0f];
}

-(unsigned int)_getNumberFromHex:(NSString*)hex rangeFrom:(int)from{
    NSString *hexString = [hex substringWithRange:NSMakeRange(from, 2)];
    NSScanner* hexScanner = [NSScanner scannerWithString:hexString];
    unsigned int intColor;
    [hexScanner scanHexInt:&intColor];
    return intColor;
}



-(void)_addTBorderWithColor:(NSString *)hex
                borderWidth:(CGFloat)borderWidth
                      isTop:(BOOL)isTop
                   isBottom:(BOOL)isBottom
                     isLeft:(BOOL)isLeft
                    isRight:(BOOL)isRight{
    
    CGColorRef color = [self _getUIColorFromHex:hex].CGColor;
    
    
    if(isTop){
        CALayer *border = [CALayer layer];
        border.backgroundColor = color;
        border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
        [self.layer addSublayer:border];
    }
    
    
    if(isBottom){
        CALayer *border = [CALayer layer];
        border.backgroundColor = color;
        border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
        [self.layer addSublayer:border];
    }
    
    if(isLeft){
        CALayer *border = [CALayer layer];
        border.backgroundColor = color;
        border.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
        [self.layer addSublayer:border];
    }
    if(isRight){
        CALayer *border = [CALayer layer];
        border.backgroundColor = color;
        border.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
        [self.layer addSublayer:border];
    }
    
}


- (NSViewController *)_getViewController {
    NSResponder *responder = self;
    while ((responder = responder.nextResponder) != nil)
        if ([responder isKindOfClass:[NSViewController class]])
            return (NSViewController*)responder;
    
    return (NSViewController *)responder;
}

- (NSViewController *)_getSplitViewController {
    NSResponder *responder = self;
    while ((responder = responder.nextResponder) != nil)
        if ([responder isKindOfClass:[NSSplitViewController class]])
            return (NSViewController*)responder;
    
    return (NSViewController *)responder;
}

- (NSSplitViewController *)_getSplitViewControllerX {
    
    @try {
        
        NSResponder *responder = self;
        
        for(id test in  [self  subviews]){
            responder = [test nextResponder];
            if ([responder isKindOfClass: [NSSplitViewController class]]){
                return (NSSplitViewController *)responder;
            }
        }
        
    }  @catch (NSException *exception) {
        NSLog(@"  %@",  exception.description  );
        // //
        
    }
    
    return nil;
}


- (CGFloat)x {
    return [self left];
}

- (void)setX:(CGFloat)x {
    [self setLeft:x];
}

- (CGFloat)y {
    return [self top];
}

- (void)setY:(CGFloat)y {
    [self setTop:y];
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)centerX {
    //return self.centerX;
    return [self left] + self.width/2;
}

- (void)setCenterX:(CGFloat)centerX {
    //self.center = CGPointMake(centerX, self.centerY);
}

- (CGFloat)centerY {
    //return self.centerY;
    return [self top] + self.height/2;
}

- (void)setCenterY:(CGFloat)centerY {
    //self.center = CGPointMake(self.centerX, centerY);
}


- (void) setCenter:(CGPoint)center                   { [[self layer] setPosition:center];               }
- (CGPoint) center                                   { return [[self layer] position];                  }





- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void) setAlpha:(CGFloat)alpha { [[self layer] setOpacity:alpha];                 }
- (CGFloat) alpha { return [[self layer] opacity];                   }


- (void)setViewForBaselineLayout:(NSView*)view{
    [self addSubview:view];
}

- (NSView*) viewForBaselineLayout {
    return self;
}







@end








