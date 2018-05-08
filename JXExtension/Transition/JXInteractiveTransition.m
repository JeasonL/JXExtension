//
//  JXInteractiveTransition.m
//  JXExtension
//
//  Created by Jeason on 2018/5/3.
//  Copyright © 2018年 Jeason.Lee. All rights reserved.
//

#import "JXInteractiveTransition.h"

static const CGFloat JXInteractiveTransitionMinPercent = 0.3;

typedef struct {
    unsigned int willBegin :      1;
    unsigned int isUpdating :     1;
    unsigned int willBeginTimer : 1;
    unsigned int willEnd :        1;
} JXDelegateFlag;

@interface JXInteractiveTransition ()

@property (nonatomic, assign, readwrite) BOOL isInteractive;
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, assign) JXInteractiveType type;
@property (nonatomic, assign) JXDelegateFlag delegateFlag;
@property (nonatomic, assign) CGFloat percent;
@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, assign) CGFloat timeDis;

@end

@implementation JXInteractiveTransition

- (instancetype)initWithType:(JXInteractiveType)type {
    self = [super init];
    if (self) {
        _type = type;
        _minPersent = JXInteractiveTransitionMinPercent;
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
            persent = -translation.y / viewSize.height;
        } else { //向下滑动
            toDirection = JXAnimatorDirectionBottom;
            backDirection = JXAnimatorDirectionTop;
            persent = translation.y / viewSize.height;
        }
    }
    if (!(self.direction & toDirection) || (toDirection & JXAnimatorDirectionNone)) {
        return;
    }
    self.percent = persent;
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            if (_delegateFlag.willBegin) {
                [self.delegate jx_interactiveTransitionWillBegin:self];
            }
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
            [self _jx_updatingWithPercent:persent];
        } break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:{
            //判断是否需要timer
            if (!_timerEable) {
                _percent >= self.minPersent ? [self _jx_finish] : [self _jx_cancle];
                return;
            }
            //判断此时是否已经转场完成，大于1或者小于0
            BOOL canEnd = [self _jx_canEndInteractiveTransitionWithPercent:persent];
            if (canEnd) return;
            //开启timer
            [self _jx_setEndAnimationTimerWithPercent:persent];
            break;
        } break;
        default: break;
    }
}

#pragma mark - Private Method

- (BOOL)_jx_canEndInteractiveTransitionWithPercent:(CGFloat)percent {
    BOOL can = NO;
    if (percent >= 1) {
        [self _jx_finish];
        can = YES;
    }
    if (percent <= 0) {
        [self _jx_cancle];
        can = YES;
    }
    return can;
}

- (void)_jx_updatingWithPercent:(CGFloat)percent {
    [self updateInteractiveTransition:percent];
    if (_delegateFlag.isUpdating) {
        [_delegate jx_interactiveTransition:self isUpdating:_percent];
    }
}

- (void)_jx_finish {
    if (_delegateFlag.willEnd) {
        [_delegate jx_interactiveTransition:self willEndWithSuccessFlag:YES percent:_percent];
    }
    [self finishInteractiveTransition];
    _percent = 0.0;
    _isInteractive = NO;
}

- (void)_jx_cancle {
    if (_delegateFlag.willEnd) {
        [_delegate jx_interactiveTransition:self willEndWithSuccessFlag:NO percent:_percent];
    }
    [self cancelInteractiveTransition];
    _percent = 0.0;
    _isInteractive = NO;
}

//设置开启timer
- (void)_jx_setEndAnimationTimerWithPercent:(CGFloat)percent {
    _percent = percent;
    //根据失败还是成功设置刷新间隔
    if (percent > _minPersent) {
        _timeDis = (1 - percent) / ((1 - percent) * 60);
    }else{
        _timeDis = percent / (percent * 60);
    }
    if (_delegateFlag.willBeginTimer) {
        [_delegate jx_interactiveTransitionWillBeginTimerAnimation:self];
    }
    //开启timer
    [self _jx_startTimer];
}

- (void)_jx_startTimer {
    if (_timer) {
        return;
    }
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(_jx_timerEvent)];
    [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)_jx_stopTimer {
    if (!_timer) {
        return;
    }
    [_timer invalidate];
    _timer = nil;
}

//timer事件
- (void)_jx_timerEvent {
    if (_percent > _minPersent) {
        _percent += _timeDis;
    }else{
        _percent -= _timeDis;
    }
    //通过timer不断刷新转场进度
    [self _jx_updatingWithPercent:_percent];
    BOOL canEnd = [self _jx_canEndInteractiveTransitionWithPercent:_percent];
    if (canEnd) {
        [self _jx_stopTimer];
    }
}

#pragma mark - Property Method

- (void)setDelegate:(id<JXInteractiveTransitionDelegate>)delegate{
    _delegate = delegate;
    _delegateFlag.willBegin = delegate && [delegate respondsToSelector:@selector(jx_interactiveTransitionWillBegin:)];
    _delegateFlag.isUpdating = delegate && [delegate respondsToSelector:@selector(jx_interactiveTransition:isUpdating:)];
    _delegateFlag.willBeginTimer = delegate && [delegate respondsToSelector:@selector(jx_interactiveTransitionWillBeginTimerAnimation:)];
    _delegateFlag.willEnd = delegate && [delegate respondsToSelector:@selector(jx_interactiveTransition:willEndWithSuccessFlag:percent:)];
}

@end
