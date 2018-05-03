//
//  JXInteractiveObject.m
//  JXExtension
//
//  Created by Jeason on 2018/5/3.
//  Copyright © 2018年 Jeason.Lee. All rights reserved.
//

#import "JXInteractiveObject.h"

@implementation JXInteractiveObject {
    JXTransitionAnimationConfig _config;
}

- (instancetype)initWithAnimationBlock:(JXTransitionAnimationConfig)config {
    self = [super init];
    if (self) {
        _config = config;
    }
    return self;
}

#pragma mark - UIViewControllerInteractiveTransitioning

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    _config ? _config(transitionContext) : nil;
}

@end
