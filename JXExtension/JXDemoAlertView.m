//
//  JXDemoAlertView.m
//  JXExtension
//
//  Created by Jeason on 2017/8/2.
//  Copyright © 2017年 Jeason. All rights reserved.
//

#import "JXDemoAlertView.h"
#import "JXAlertContainerView.h"

static const CGFloat kGlobalAnimationDuration = 0.25;

@interface JXDemoAlertView ()

@property (weak, nonatomic) IBOutlet JXAlertContainerView *containerView;

@end

@implementation JXDemoAlertView

- (instancetype)init {
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
    if (self) {
        [self setFrame:[UIScreen mainScreen].bounds];
    }
    return self;
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:kGlobalAnimationDuration animations:^{
        self.layer.opacity = 1.0;
    } completion:^(BOOL finished) {

    }];
    [self.containerView popToShow];
}

- (void)dismiss {
    [UIView animateWithDuration:kGlobalAnimationDuration animations:^{
        self.layer.opacity = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    [self.containerView popToDismiss];
}

- (IBAction)dismissAction:(id)sender {
    [self dismiss];
}

@end
