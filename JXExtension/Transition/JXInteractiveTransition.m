//
//  JXInteractiveTransition.m
//  JXExtension
//
//  Created by Jeason on 2018/5/3.
//  Copyright © 2018年 Jeason.Lee. All rights reserved.
//

#import "JXInteractiveTransition.h"

@interface JXInteractiveTransition ()

@property (nonatomic, assign, readwrite) BOOL isInteractive;
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, assign) JXInteractiveGestureDirection direction;
@property (nonatomic, assign) JXInteractiveType type;

@end

@implementation JXInteractiveTransition

//- (instancetype)initWithViewController:(UIViewController *)viewController {
//    if (self = [super init]) {
//        _isInteractive = NO;
//        _viewController = viewController;
//        UIPanGestureRecognizer *panGestureRecognizer =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
//        [viewController.view addGestureRecognizer:panGestureRecognizer];
//    }
//    return self;
//}

- (instancetype)initWithType:(JXInteractiveType)type direction:(JXInteractiveGestureDirection)direction {
    self = [super init];
    if (self) {
        _direction = direction;
        _type = type;
    }
    return self;
}

- (void)addPanGestureForViewController:(UIViewController *)viewController {
    if (self.direction == JXInteractiveGestureDirectionNone) {
        return;
    }
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    self.viewController = viewController;
    [viewController.view addGestureRecognizer:pan];
}

- (void)panGestureAction:(UIPanGestureRecognizer *)panGesture {
    CGFloat persent = 0;
    switch (self.direction) {
        case JXInteractiveGestureDirectionLeft:{
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        } break;
        case JXInteractiveGestureDirectionRight:{
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        } break;
        case JXInteractiveGestureDirectionTop:{
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        } break;
        case JXInteractiveGestureDirectionBottom:{
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        } break;
        default: break;
    }
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            //手势开始的时候标记手势状态，并开始相应的事件
            self.isInteractive = YES;
            switch (self.type) {
                case JXInteractiveTypePresent:{
                    self.presentConfigBlock ? self.presentConfigBlock() : nil;
                } break;
                case JXInteractiveTypeDismiss:{
                    [self.viewController dismissViewControllerAnimated:YES completion:nil];
                } break;
                case JXInteractiveTypePush:{
                    self.pushConfigBlock ? self.pushConfigBlock() : nil;
                } break;
                case JXInteractiveTypePop: {
                    [self.viewController.navigationController popViewControllerAnimated:YES];
                } break;
            }
        } break;
        case UIGestureRecognizerStateChanged:{
            //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
            [self updateInteractiveTransition:persent];
        } break;
        case UIGestureRecognizerStateEnded:{
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            self.isInteractive = NO;
            if (persent > 0.3) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
        } break;
        default: break;
    }
    //    CGFloat progress = [recognizer translationInView:self.viewController.view].x / (self.viewController.view.bounds.size.width * 1.0);
    //    progress = MIN(1.0, MAX(0.0, progress));
    //    self.isInteractive = YES;
    //    if (recognizer.state == UIGestureRecognizerStateBegan) {
    //        [self.viewController dismissViewControllerAnimated:YES completion:nil];
    //    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
    //        [self updateInteractiveTransition:progress];
    //    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
    //        if (progress > 0.3) {
    //            [self finishInteractiveTransition];
    //        } else {
    //            [self cancelInteractiveTransition];
    //        }
    //        self.isInteractive = NO;
    //    }
    //}

}

@end
