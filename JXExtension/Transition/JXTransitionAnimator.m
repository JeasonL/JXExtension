//
//  JXTransitionAnimator.m
//  JXExtension
//
//  Created by Jeason on 2017/9/2.
//  Copyright © 2017年 Jeason.Lee. All rights reserved.
//

#import "JXTransitionAnimator.h"
#import "JXTransitionObject.h"
#import "JXInteractiveTransition.h"

@interface JXTransitionAnimator ()

@property (nonatomic, strong) JXTransitionObject *toTransition;
@property (nonatomic, strong) JXTransitionObject *backTransition;

@end

@implementation JXTransitionAnimator

- (instancetype)init {
    self = [super init];
    if (self) {
        _toDuration = 0.3;
        _backDuration = 0.3;
    }
    return self;
}

- (void)jx_setToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    //子类重写
}

- (void)jx_setBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    //子类重写
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.toTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.backTransition;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.interactive.isInteractive ? self.interactive : nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

#pragma mark - Property Method

- (JXTransitionObject *)toTransition {
    if (!_toTransition) {
        _toTransition = [[JXTransitionObject alloc] initWithDuration:_toDuration animationBlock:^(id<UIViewControllerContextTransitioning> transitionContext) {
            [self jx_setToAnimation:transitionContext];
        }];
    }
    return _toTransition;
}

- (JXTransitionObject *)backTransition {
    if (!_backTransition) {
        _backTransition = [[JXTransitionObject alloc] initWithDuration:_backDuration animationBlock:^(id<UIViewControllerContextTransitioning> transitionContext) {
            [self jx_setBackAnimation:transitionContext];
        }];
    }
    return _backTransition;
}

//- (JXInteractiveTransition *)backInteractive {
//    if (!_backInteractive) {
//        _backInteractive = [[JXInteractiveTransition alloc] initWithType:JXInteractiveTypeDismiss direction:JXInteractiveGestureDirectionLeft];
//        [_backInteractive addPanGestureForViewController:self.targetViewController];
//    }
//    return _backInteractive;
//}
//
//- (void)setTargetViewController:(UIViewController *)targetViewController {
//    _targetViewController = targetViewController;
//    [self backInteractive];
//}

@end
