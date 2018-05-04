//
//  JXInteractiveTransition.h
//  JXExtension
//
//  Created by Jeason on 2018/5/3.
//  Copyright © 2018年 Jeason.Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JXInteractiveGestureConfigBlock)();

//手势的方向
typedef NS_ENUM(NSUInteger, JXInteractiveGestureDirection) {
    JXInteractiveGestureDirectionNone = 0,
    JXInteractiveGestureDirectionLeft,
    JXInteractiveGestureDirectionRight,
    JXInteractiveGestureDirectionTop,
    JXInteractiveGestureDirectionBottom
};

//手势控制哪种转场
typedef NS_ENUM(NSUInteger, JXInteractiveType) {
    JXInteractiveTypePresent = 0,
    JXInteractiveTypeDismiss,
    JXInteractiveTypePush,
    JXInteractiveTypePop,
};

@interface JXInteractiveTransition : UIPercentDrivenInteractiveTransition

/**记录是否开始手势，判断pop操作是手势触发还是返回键触发*/
@property (nonatomic, assign, readonly) BOOL isInteractive;
/**促发手势present的时候的config，config中初始化并present需要弹出的控制器*/
@property (nonatomic, copy) JXInteractiveGestureConfigBlock presentConfigBlock;
/**促发手势push的时候的config，config中初始化并push需要弹出的控制器*/
@property (nonatomic, copy) JXInteractiveGestureConfigBlock pushConfigBlock;

/**初始化*/
- (instancetype)initWithType:(JXInteractiveType)type direction:(JXInteractiveGestureDirection)direction;
/**给传入的控制器添加手势*/
- (void)addPanGestureForViewController:(UIViewController *)viewController;

@end
