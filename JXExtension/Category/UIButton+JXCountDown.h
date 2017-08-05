//
//  UIButton+JXCountDown.h
//  Example
//
//  Created by Jeason on 2017/8/5.
//  Copyright © 2017年 Jeason.Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (JXCountDown)

/**
 UIControlStateNormal状态下倒计时

 @param title 按钮title
 @param timeout 超时时间
 */
- (void)jx_normalTitleWithTitle:(NSString *)title startTime:(NSInteger)timeout;

/**
 UIControlStateNormal状态下倒计时
 
 @param title 按钮title
 @param timeout 超时时间
 @param complete 完成倒计时回调
 */
- (void)jx_normalTitleWithTitle:(NSString *)title startTime:(NSInteger)timeout complete:(void(^)())complete;

/**
 UIControlStateNormal状态下倒计时
 
 @param title 按钮title
 @param timeout 超时时间
 @param waitPrefix 倒计时前序
 @param waitSuffix 倒计时后序
 */
- (void)jx_normalTitleWithTitle:(NSString *)title startTime:(NSInteger)timeout waitPrefix:(NSString *)waitPrefix waitSuffix:(NSString *)waitSuffix;

/**
 UIControlStateNormal状态下倒计时
 
 @param title 按钮title
 @param timeout 超时时间
 @param waitPrefix 倒计时前序
 @param waitSuffix 倒计时后序
 @param complete 完成倒计时回调
 */
- (void)jx_normalTitleWithTitle:(NSString *)title startTime:(NSInteger)timeout waitPrefix:(NSString *)waitPrefix waitSuffix:(NSString *)waitSuffix complete:(void(^)())complete;

/**
 UIControlStateSelected状态下倒计时

 @param title 按钮title
 @param timeout 超时时间
 */
- (void)jx_selectedTitleWithTitle:(NSString *)title startTime:(NSInteger)timeout;

/**
 UIControlStateSelected状态下倒计时
 
 @param title 按钮title
 @param timeout 超时时间
 @param complete 完成倒计时回调
 */
- (void)jx_selectedTitleWithTitle:(NSString *)title startTime:(NSInteger)timeout complete:(void(^)())complete;

/**
 UIControlStateSelected状态下倒计时

 @param title 按钮title
 @param timeout 超时时间
 @param waitPrefix 倒计时前序
 @param waitSuffix 倒计时后序
 */
- (void)jx_selectedTitleWithTitle:(NSString *)title startTime:(NSInteger)timeout waitPrefix:(NSString *)waitPrefix waitSuffix:(NSString *)waitSuffix;

/**
 UIControlStateSelected状态下倒计时
 
 @param title 按钮title
 @param timeout 超时时间
 @param waitPrefix 倒计时前序
 @param waitSuffix 倒计时后序
 @param complete 完成倒计时回调
 */
- (void)jx_selectedTitleWithTitle:(NSString *)title startTime:(NSInteger)timeout waitPrefix:(NSString *)waitPrefix waitSuffix:(NSString *)waitSuffix complete:(void(^)())complete;

@end
