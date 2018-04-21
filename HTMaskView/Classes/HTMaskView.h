//
//  HTMaskView.h
//  HTMaskView
//
//  Created by hublot on 2018/3/27.
//

#import <UIKit/UIKit.h>

@class HTMaskView;
typedef void(^HTMaskComplete)(HTMaskView *);


@interface HTMaskView: UIView

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithContentView:(UIView *)contentView;

- (void)presentMaskViewAnimated:(BOOL)animated ifhiddenTransform:(CGAffineTransform)ifhiddenTransform complete:(HTMaskComplete)complete backgroundTouchInside:(HTMaskComplete)backgroundTouchInside;

- (void)dismissWithAnimated:(BOOL)animated complete:(HTMaskComplete)complete;

@end
