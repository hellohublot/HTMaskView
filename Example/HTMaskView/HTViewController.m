//
//  HTViewController.m
//  HTMaskView
//
//  Created by hellohublot on 03/27/2018.
//  Copyright (c) 2018 hellohublot. All rights reserved.
//

#import "HTViewController.h"
#import <HTMaskView/HTMaskView.h>

@interface HTViewController ()

@end

@implementation HTViewController

/*-------------------------------------/init /-----------------------------------*/

- (void)viewDidLoad {
	[super viewDidLoad];
	[self initializeDataSource];
	[self initializeUserInterface];
}

- (void)initializeDataSource {
	
}

- (void)initializeUserInterface {
	
}

/*-------------------------------------/ controller override /-----------------------------------*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
	button.backgroundColor = UIColor.orangeColor;
	[button setTitle:@"你好" forState:UIControlStateNormal];
	button.titleLabel.font = [UIFont systemFontOfSize:16];
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	HTMaskView *maskView = [[HTMaskView alloc] initWithContentView:button];
	[NSLayoutConstraint activateConstraints:@[
											  [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:maskView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0],
											  [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:maskView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0],
											  [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:200],
											  [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:60],
	]];
	CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.5);
	[maskView presentAllowBackgroundDismiss:true animated:true ifhiddenTransform:transform complete:nil];
}

/*-------------------------------------/ controller leave /-----------------------------------*/


@end
