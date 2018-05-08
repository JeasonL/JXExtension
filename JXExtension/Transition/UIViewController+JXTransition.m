//
//  UIViewController+JXTransition.m
//  JXExtension
//
//  Created by Jeason on 2017/9/2.
//  Copyright © 2017年 Jeason.Lee. All rights reserved.
//

#import "UIViewController+JXTransition.h"
#import "JXInteractiveTransition.h"

@implementation UIViewController (JXTransition)

- (void)jx_presentViewController:(UIViewController *)viewController withAnimator:(JXTransitionAnimator *)animator completion:(void (^)(void))completion {
    if (!viewController) return;
    if (!animator) animator = [[JXTransitionAnimator alloc] init];
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    viewController.transitioningDelegate = animator;
    [self presentViewController:viewController animated:YES completion:completion];
}

@end
