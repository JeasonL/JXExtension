//
//  UIButton+JXCountDown.m
//  Example
//
//  Created by Jeason on 2017/8/5.
//  Copyright © 2017年 Jeason.Lee. All rights reserved.
//

#import "UIButton+JXCountDown.h"

@implementation UIButton (JXCountDown)

#pragma mark - Public Method

- (void)jx_normalTitleWithTitle:(NSString *)title startTime:(NSInteger)timeout {
    [self jx_normalTitleWithTitle:title startTime:timeout waitPrefix:@"" waitSuffix:@""];
}

- (void)jx_normalTitleWithTitle:(NSString *)title startTime:(NSInteger)timeout waitPrefix:(NSString *)waitPrefix waitSuffix:(NSString *)waitSuffix {
    [self jx_titleWithTitle:title startTime:timeout waitPrefix:waitPrefix waitSuffix:waitSuffix forState:UIControlStateNormal];
}

- (void)jx_selectedTitleWithTitle:(NSString *)title startTime:(NSInteger)timeout {
    [self jx_selectedTitleWithTitle:title startTime:timeout waitPrefix:@"" waitSuffix:@""];
}

- (void)jx_selectedTitleWithTitle:(NSString *)title startTime:(NSInteger)timeout waitPrefix:(NSString *)waitPrefix waitSuffix:(NSString *)waitSuffix {
    [self jx_titleWithTitle:title startTime:timeout waitPrefix:waitPrefix waitSuffix:waitSuffix forState:UIControlStateSelected];
}

#pragma mark - Private Method

- (void)jx_titleWithTitle:(NSString *)title startTime:(NSInteger)timeout waitPrefix:(NSString *)waitPrefix waitSuffix:(NSString *)waitSuffix forState:(UIControlState)state {
    __block NSInteger timeOut = timeout; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (timeOut <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.selected = NO;
                //设置界面的按钮显示
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        } else {
            int seconds = timeOut % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.selected = YES;
                //设置界面的按钮显示
                [self setTitle:[NSString stringWithFormat:@"%@%@%@", waitPrefix, strTime, waitSuffix] forState:state];
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

@end
