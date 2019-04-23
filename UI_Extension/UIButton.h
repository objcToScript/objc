
#import <UIKit/UIKit.h>

@interface UIButton (ex)

- (void)_imageWidthScale;

//@property (weak)  NSTextField *snImagePosition;

@property (nonatomic) CGFloat snImageTextSpacing;

@property (nonatomic ) UIEdgeInsets* snContentEdgeInsets;

/*

public var snImagePosition: ImagePosition = .left {
    didSet {
        self.setNeedsLayout()
    }
}
public var snImageTextSpacing: CGFloat = 0 {
    didSet {
        self.setNeedsLayout()
    }
}
public var snContentEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
    didSet {
        self.setNeedsLayout()
    }
}
 */




@end
