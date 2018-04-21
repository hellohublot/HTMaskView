//
//  HTMaskView.m
//  HTMaskView
//
//  Created by hublot on 2018/3/27.
//

#import "HTMaskView.h"

@interface HTMaskView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) CGAffineTransform ifhiddenTransform;

@property (nonatomic, copy) HTMaskComplete backgroundTouchInside;

@end

@implementation HTMaskView

- (instancetype)initWithContentView:(UIView *)contentView {
	if (self = [super init]) {
		[self addSubview:contentView];
		self.contentView = contentView;
		self.translatesAutoresizingMaskIntoConstraints = false;
		self.contentView.translatesAutoresizingMaskIntoConstraints = false;
		self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
	}
	return self;
}

- (void)presentMaskViewAnimated:(BOOL)animated ifhiddenTransform:(CGAffineTransform)ifhiddenTransform complete:(HTMaskComplete)complete backgroundTouchInside:(HTMaskComplete)backgroundTouchInside {
	[self removeFromSuperview];
	for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
		[self removeGestureRecognizer:gesture];
	}
	
	self.ifhiddenTransform = ifhiddenTransform;
	UIView *superView = [UIApplication sharedApplication].keyWindow;
	[superView addSubview:self];
	[self addSubview:self.contentView];
	[NSLayoutConstraint activateConstraints:@[
		[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1 constant:0],
		[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
		[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1 constant:0],
		[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]
	]];
	
	UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewActionGesture:)];
	gesture.delegate = self;
	[self addGestureRecognizer:gesture];
	gesture.enabled = backgroundTouchInside != nil;
	self.backgroundTouchInside = backgroundTouchInside;
	
	[self switchContentViewAnimated:animated tohidden:false complete:complete];
}

- (void)dismissWithAnimated:(BOOL)animated complete:(HTMaskComplete)complete {
	HTMaskComplete recomplete = ^(HTMaskView *maskView) {
		[self removeFromSuperview];
		if (complete) {
			complete(maskView);
		}
	};
	[self switchContentViewAnimated:animated tohidden:true complete:recomplete];
}

- (BOOL)shouldReceiveUserInterface:(UIView *)view {
	if (view == self) {
		return true;
	}
	return false;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	return [self shouldReceiveUserInterface:touch.view];
}

- (void)maskViewActionGesture:(UITapGestureRecognizer *)gesture {
	if (self.backgroundTouchInside) {
		self.backgroundTouchInside(self);
	}
}

- (void)switchContentViewToHidden:(BOOL)tohidden {
	if (tohidden) {
		self.contentView.transform = self.ifhiddenTransform;
		self.alpha = 0;
	} else {
		self.contentView.transform = CGAffineTransformIdentity;
		self.alpha = 1;
	}
}

- (void)switchContentViewAnimated:(BOOL)animated tohidden:(BOOL)tohidden complete:(HTMaskComplete)complete {
	[self switchContentViewToHidden:!tohidden];
	[UIView animateWithDuration:animated ? 0.25 : 0 animations:^{
		[self switchContentViewToHidden:tohidden];
	} completion:^(BOOL finished) {
		if (complete) {
			complete(self);
		}
	}];
}

@end
