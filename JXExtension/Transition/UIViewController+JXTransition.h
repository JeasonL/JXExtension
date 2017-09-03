//
//  UIViewController+JXTransition.h
//  JXExtension
//
//  Created by Jeason on 2017/9/2.
//  Copyright © 2017年 Jeason.Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXTransitionAnimator.h"

@interface UIViewController (JXTransition)

/**
 *  通过指定的转场animator来present控制器
 *
 *  @param viewController 被modal出的控制器
 *  @param animator       转场animator
 *  @param completion     完成后回调
 */
- (void)jx_presentViewController:(UIViewController *)viewController withAnimator:(JXTransitionAnimator *)animator completion:(void (^)(void))completion;

@end
