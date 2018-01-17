//
//  JXSystemAuthManager.h
//  JXExtension
//
//  Created by Jeason on 2017/9/5.
//  Copyright © 2017年 Jeason.Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXSystemAuthManager : NSObject

/**
 判断通讯录权限
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)jx_judgeAddressBookAuthStatusWithSuccess:(void(^)(void))success
                                         failure:(void(^)(void))failure;

/**
 判断相机权限
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)jx_judgeCameraAuthStatusWithSuccess:(void(^)(void))success
                                    failure:(void(^)(void))failure;

/**
 判断相册权限
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)jx_judgeAlbumAuthStatusWithSuccess:(void(^)(void))success
                                   failure:(void(^)(void))failure;

/**
 判断麦克风权限
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)jx_judgeMicrophoneAuthStatusWithSuccess:(void(^)(void))success
                                        failure:(void(^)(void))failure;

/**
 判断定位权限
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)jx_judgeLocationAuthStatusWithSuccess:(void(^)(void))success
                                      failure:(void(^)(void))failure;

/**
 判断提醒事项权限
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)jx_judgeReminderAuthStatusWithSuccess:(void(^)(void))success
                                      failure:(void(^)(void))failure;

/**
 判断日历权限
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)jx_judgeCalendarAuthStatusWithSuccess:(void(^)(void))success
                                      failure:(void(^)(void))failure;

/**
 打开系统应用设置
 */
+ (void)jx_openApplicationSetting;

@end
