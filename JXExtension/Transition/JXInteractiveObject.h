//
//  JXInteractiveObject.h
//  JXExtension
//
//  Created by Jeason on 2018/5/3.
//  Copyright © 2018年 Jeason.Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JXTransitionAnimationConfig)(id<UIViewControllerContextTransitioning> transitionContext);

@interface JXInteractiveObject : UIPercentDrivenInteractiveTransition

- (instancetype)initWithAnimationBlock:(void(^)(id<UIViewControllerContextTransitioning> transitionContext))config;

@end
