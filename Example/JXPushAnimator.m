//
//  JXPushAnimator.m
//  JXExtension
//
//  Created by Jeason on 2017/9/2.
//  Copyright © 2017年 Jeason.Lee. All rights reserved.
//

#import "JXPushAnimator.h"

@implementation JXPushAnimator

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)jx_setToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //转场的容器图，动画完成之后会消失
    UIView *containerView = transitionContext.containerView;
    UIView *fromView;
    UIView *toView;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }else{
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    //对应关系
    BOOL isPresent = (toViewController.presentingViewController == fromViewController);
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    if (isPresent) {
        fromView.frame = fromFrame;
        toView.frame = CGRectOffset(toFrame, toFrame.size.width, 0);
        [containerView addSubview:toView];
    }
    NSTimeInterval transitionDuration = self.toDuration;
    [UIView animateWithDuration:transitionDuration animations:^{
        if (isPresent) {
            toView.frame = toFrame;
            fromView.frame = CGRectOffset(fromFrame, fromFrame.size.width * 0.3 * -1, 0);
        }
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        wasCancelled ? [toView removeFromSuperview] : nil;
        [transitionContext completeTransition:!wasCancelled];
    }];
}

- (void)jx_setBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //转场的容器图，动画完成之后会消失
    UIView *containerView = transitionContext.containerView;
    UIView *fromView;
    UIView *toView;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }else{
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    //对应关系
    BOOL isDismiss = (fromViewController.presentingViewController == toViewController);
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    if (isDismiss) {
        fromView.frame = fromFrame;
        toView.frame = CGRectOffset(toFrame, toFrame.size.width * 0.3 * -1, 0);
        [containerView insertSubview:toView belowSubview:fromView];
    }
    NSTimeInterval transitionDuration = self.backDuration;
    [UIView animateWithDuration:transitionDuration animations:^{
        if (isDismiss) {
            toView.frame = toFrame;
            fromView.frame = CGRectOffset(fromFrame, fromFrame.size.width, 0);
        }
    } completion:^(BOOL finished) {
        BOOL wasCancel = [transitionContext transitionWasCancelled];
        if (wasCancel) {
            [toView removeFromSuperview];
        }
        [transitionContext completeTransition:!wasCancel];
    }];
}

@end
