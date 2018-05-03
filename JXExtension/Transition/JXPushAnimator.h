//
//  JXPushAnimator.h
//  JXExtension
//
//  Created by Jeason on 2017/9/2.
//  Copyright © 2017年 Jeason.Lee. All rights reserved.
//

#import "JXTransitionAnimator.h"

/**
 推出方式
 */
typedef NS_ENUM(NSInteger, JXPushAnimatorMode) {
    JXPushAnimatorModeRight = 0, //右->左
    JXPushAnimatorModeLeft,      //左->右
    JXPushAnimatorModeTop,       //上->下
    JXPushAnimatorModeBottom,    //下->上
};

@interface JXPushAnimator : JXTransitionAnimator

//推出方式
@property (nonatomic, assign) JXPushAnimatorMode animatorMode;
//偏移量, 范围:-1至1, 默认:-0.3
@property (nonatomic, assign) CGFloat offset;

@end
