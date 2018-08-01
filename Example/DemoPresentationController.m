//
//  DemoPresentationController.m
//  JXExtension
//
//  Created by Jeason on 2018/5/8.
//  Copyright © 2018年 Jeason.Lee. All rights reserved.
//

#import "DemoPresentationController.h"

@interface DemoPresentationController ()

@property (nonatomic, strong) UIVisualEffectView *effectView;

@end

@implementation DemoPresentationController

//即将出现调用
- (void)presentationTransitionWillBegin {
    //添加半透明背景 View 到视图中
    [self.containerView addSubview:self.effectView];
    //一旦要自定义动画，必须自己手动添加控制器
    //设置尺寸(在动画中注意调整尺寸)
    self.presentedView.frame = CGRectInset(self.containerView.bounds, 40, 60);
    // 添加到containerView 上
    [self.containerView addSubview:self.presentedView];
    
    // 与过渡效果一起执行背景 View 的淡入效果
    [self.presentingViewController.transitionCoordinator animateAlongsideTransitionInView:self.effectView animation:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.effectView.alpha = 0.85;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

//出现调用
- (void)presentationTransitionDidEnd:(BOOL)completed {
    // 如果呈现没有完成，那就移除背景 View
    if (!completed){
        [self.effectView removeFromSuperview];
    } else {
     
    }
}

//即将销毁调用
- (void)dismissalTransitionWillBegin {
    // 与过渡效果一起执行背景 View 的淡入效果
    [self.presentingViewController.transitionCoordinator animateAlongsideTransitionInView:self.effectView animation:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.effectView.alpha = 0.0;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

//销毁调用
- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        //一旦要自定义动画，必须自己手动移除控制器
        [self.effectView removeFromSuperview];
        [self.presentedView removeFromSuperview];
    }
}

#pragma mark - Property Method

- (UIVisualEffectView *)effectView {
    if (!_effectView) {
        UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *view = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        view.frame = self.containerView.bounds;
        view.alpha = 0.0;
        _effectView = view;
    }
    return _effectView;
}

@end
