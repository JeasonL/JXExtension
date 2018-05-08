//
//  JXInteractiveTransition.h
//  JXExtension
//
//  Created by Jeason on 2018/5/3.
//  Copyright © 2018年 Jeason.Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXTransitionConstant.h"

//手势控制哪种转场
typedef NS_ENUM(NSUInteger, JXInteractiveType) {
    JXInteractiveTypePresent = 0,
    JXInteractiveTypeDismiss,
};

typedef void(^JXInteractiveGestureDirectionBlock)(JXAnimatorDirection direction);

@interface JXInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign, readonly) BOOL isInteractive; //记录是否开始手势
@property (nonatomic, assign) CGFloat minPersent; //转场需要的最小百分比, 默认0.3
@property (nonatomic, copy) JXInteractiveGestureDirectionBlock presentConfigBlock;

- (instancetype)initWithType:(JXInteractiveType)type;
- (void)addPanGestureForViewController:(UIViewController *)viewController;

@end
