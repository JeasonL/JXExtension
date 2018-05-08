//
//  JXInteractiveTransition.m
//  JXExtension
//
//  Created by Jeason on 2018/5/3.
//  Copyright © 2018年 Jeason.Lee. All rights reserved.
//

#import "JXInteractiveTransition.h"

@implementation JXInteractiveDirection

+ (JXInteractiveDirection *)directionWithTo:(JXAnimatorDirection)to back:(JXAnimatorDirection)back {
    JXInteractiveDirection *direction = [[JXInteractiveDirection alloc] init];
    direction.toDirection = to;
    direction.backDirection = back;
    return direction;
}

@end

@interface JXInteractiveTransition ()

@property (nonatomic, assign, readwrite) BOOL isInteractive;
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, assign) JXInteractiveType type;

@end

@implementation JXInteractiveTransition

- (instancetype)initWithType:(JXInteractiveType)type {
    self = [super init];
    if (self) {
        _type = type;
        _minPersent = 0.3;
    }
    return self;
}

- (void)addPanGestureForViewController:(UIViewController *)viewController {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    self.viewController = viewController;
    [viewController.view addGestureRecognizer:pan];
}

- (void)panGestureAction:(UIPanGestureRecognizer *)panGesture {
    CGFloat persent = 0;
    JXAnimatorDirection toDirection;
    JXAnimatorDirection backDirection;
    CGPoint translation = [panGesture translationInView:panGesture.view];
    CGSize viewSize = panGesture.view.frame.size;
    CGFloat absX = fabs(translation.x);
    CGFloat absY = fabs(translation.y);
    if (MAX(absX, absY) < 20) { // 设置滑动有效距离
        [self cancelInteractiveTransition];
        return;
    }
    if (absX > absY) { //水平方向
        if (translation.x < 0) { //向左滑动
            toDirection = JXAnimatorDirectionLeft;
            backDirection = JXAnimatorDirectionRight;
            persent = -translation.x / viewSize.width;
        } else { //向右滑动
            toDirection = JXAnimatorDirectionRight;
            backDirection = JXAnimatorDirectionLeft;
            persent = translation.x / viewSize.width;
        }
    } else { //垂直方向
        if (translation.y < 0) { //向上滑动
            toDirection = JXAnimatorDirectionTop;
            backDirection = JXAnimatorDirectionBottom;
            persent = -translation.y / viewSize.width;
        } else { //向下滑动
            toDirection = JXAnimatorDirectionBottom;
            backDirection = JXAnimatorDirectionTop;
            persent = translation.y / viewSize.width;
        }
    }
    if (!(self.direction & toDirection) || (toDirection & JXAnimatorDirectionNone)) {
        return;
    }
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
        } break;
        case UIGestureRecognizerStateChanged:{
            //手势开始的时候标记手势状态，并开始相应的事件
            if (!self.isInteractive) {
                self.isInteractive = YES;
                switch (self.type) {
                    case JXInteractiveTypePresent:{
                        self.presentConfigBlock ? self.presentConfigBlock([JXInteractiveDirection directionWithTo:toDirection back:backDirection]) : nil;
                    } break;
                    case JXInteractiveTypeDismiss:{
                        [self.viewController dismissViewControllerAnimated:YES completion:nil];
                    } break;
                }
            }
            //手势过程中，通过updateInteractiveTransition设置返回过程进行的百分比
            [self updateInteractiveTransition:persent];
        } break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:{
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            self.isInteractive = NO;
            if (persent > self.minPersent) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
        } break;
        default: break;
    }
}

@end
