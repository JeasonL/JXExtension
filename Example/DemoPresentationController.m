//
//  DemoPresentationController.m
//  JXExtension
//
//  Created by Jeason on 2018/5/8.
//  Copyright © 2018年 Jeason.Lee. All rights reserved.
//

#import "DemoPresentationController.h"

@interface DemoPresentationController ()

@property (nonatomic, strong) UIView *transtioningView;

@end

@implementation DemoPresentationController

//即将出现调用
- (void)presentationTransitionWillBegin{
    //添加半透明背景 View 到视图中
    UIView *transtioningView = [[UIView alloc] init];
    transtioningView.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:0.5];
    self.transtioningView = transtioningView;
    self.transtioningView.frame = self.containerView.bounds;
    self.transtioningView.alpha = 0.0;
    
    [self.containerView addSubview:self.transtioningView];
    
    //一旦要自定义动画，必须自己手动添加控制器
    //设置尺寸(在动画中注意调整尺寸)
    self.presentedView.frame = CGRectInset(self.containerView.bounds, 40, 60);
    // 添加到containerView 上
    [self.containerView addSubview:self.presentedView];
    
    // 与过渡效果一起执行背景 View 的淡入效果
    [self.presentingViewController.transitionCoordinator animateAlongsideTransitionInView:self.transtioningView animation:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.transtioningView.alpha = 1.0;
        self.transtioningView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

//出现调用
- (void)presentationTransitionDidEnd:(BOOL)completed{
    // 如果呈现没有完成，那就移除背景 View
    if (!completed){
        [self.transtioningView removeFromSuperview];
    }
}

//即将销毁调用
- (void)dismissalTransitionWillBegin{
    // 与过渡效果一起执行背景 View 的淡入效果
    [self.presentingViewController.transitionCoordinator animateAlongsideTransitionInView:self.transtioningView animation:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.transtioningView.alpha = 0.0;
        self.transtioningView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

//销毁调用
- (void)dismissalTransitionDidEnd:(BOOL)completed{
    if (completed) {
        //一旦要自定义动画，必须自己手动移除控制器
        [self.presentedView removeFromSuperview];
        [self.transtioningView removeFromSuperview];
    }
}

@end
