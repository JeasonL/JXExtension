//
//  JXPushAnimator.m
//  JXExtension
//
//  Created by Jeason on 2017/9/2.
//  Copyright © 2017年 Jeason.Lee. All rights reserved.
//

#import "JXPushAnimator.h"

@interface JXPushAnimator ()

@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, assign) BOOL isInteracting;

@end

@implementation JXPushAnimator

- (instancetype)init {
    self = [super init];
    if (self) {
       _offset = -0.3;
    }
    return self;
}

/**
 类似push动画效果
 */
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
    CGFloat toX = 0, toY = 0, fromX = 0, fromY = 0;
    switch (self.animatorMode) {
        case JXPushAnimatorModeRight: {
            toX = toFrame.size.width;
            fromX = toX * self.offset;
        } break;
        case JXPushAnimatorModeLeft: {
            toX = -toFrame.size.width;
            fromX = toX * self.offset;
        } break;
        case JXPushAnimatorModeTop: {
            toY = -toFrame.size.height;
            fromY = toY * self.offset;
        } break;
        case JXPushAnimatorModeBottom: {
            toY = toFrame.size.height;
            fromY = toY * self.offset;
        } break;
    }
    if (isPresent) {
        fromView.frame = fromFrame;
        toView.frame = CGRectOffset(toFrame, toX, toY);
        [containerView addSubview:toView];
    }
    NSTimeInterval transitionDuration = self.toDuration;
    [UIView animateWithDuration:transitionDuration animations:^{
        if (isPresent) {
            toView.frame = toFrame;
            fromView.frame = CGRectOffset(fromFrame, fromX, fromY);
        }
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        wasCancelled ? [toView removeFromSuperview] : nil;
        [transitionContext completeTransition:!wasCancelled];
    }];
}

/**
 类似pop动画效果
 */
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
    CGFloat toX = 0, toY = 0, fromX = 0, fromY = 0;
    switch (self.animatorMode) {
        case JXPushAnimatorModeRight: {
            fromX = fromFrame.size.width;
            toX = fromX * self.offset;
        } break;
        case JXPushAnimatorModeLeft: {
            fromX = -fromFrame.size.width;
            toX = fromX * self.offset;
        } break;
        case JXPushAnimatorModeTop: {
            fromY = -fromFrame.size.height;
            toY = fromY * self.offset;
        } break;
        case JXPushAnimatorModeBottom: {
            fromY = fromFrame.size.height;
            toY = fromY * self.offset;
        } break;
        break;
    }
    if (isDismiss) {
        fromView.frame = fromFrame;
        toView.frame = CGRectOffset(toFrame, toX, toY);
        [containerView insertSubview:toView belowSubview:fromView];
    }
    NSTimeInterval transitionDuration = self.backDuration;
    [UIView animateWithDuration:transitionDuration animations:^{
        if (isDismiss) {
            toView.frame = toFrame;
            fromView.frame = CGRectOffset(fromFrame, fromX, fromY);
        }
    } completion:^(BOOL finished) {
        BOOL wasCancel = [transitionContext transitionWasCancelled];
        if (wasCancel) {
            [toView removeFromSuperview];
        }
        [transitionContext completeTransition:!wasCancel];
    }];
}



- (void)jx_setToInteractive:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(toPanAction:)];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [fromViewController.view addGestureRecognizer:panGesture];
    //    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.viewController = fromViewController;
}

- (void)jx_setBackInteractive:(id<UIViewControllerContextTransitioning>)transitionContext {
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(backPanAction:)];
//    //    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    [toViewController.view addGestureRecognizer:panGesture];
//    self.viewController = toViewController;
//    self.transitionContext = transitionContext;
}

- (void)toPanAction:(UIPanGestureRecognizer*)gesture {
    
}

- (void)backPanAction:(UIPanGestureRecognizer*)gesture {
    UIView *containerView = gesture.view;
    CGPoint translation = [gesture translationInView:containerView];
    CGFloat percent = translation.x / containerView.bounds.size.width;
    CGFloat velocityX = [gesture velocityInView:containerView].x;
    BOOL isFinished;
    if (velocityX <= 0) {
        isFinished = NO;
    } else if (velocityX > 100) {
        isFinished = YES;
    } else if (percent > 0.3) {
        isFinished = YES;
    } else {
        isFinished = NO;
    }
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.isInteracting = YES;
        [self.viewController dismissViewControllerAnimated:YES completion:nil];
    } else if (gesture.state == UIGestureRecognizerStateBegan) {
        if (self.isInteracting) {
            if (percent < 0) {
                percent = 0;
            }
            [self.transitionContext updateInteractiveTransition:percent];
        }
    } else if (gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateEnded) {
        if (self.isInteracting) {
            isFinished ? [self.transitionContext finishInteractiveTransition] : [self.transitionContext cancelInteractiveTransition];
            self.isInteracting = NO;
        }
    }
}

@end
