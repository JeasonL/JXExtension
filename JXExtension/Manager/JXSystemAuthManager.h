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
+ (void)jx_judgeAddressBookAuthStatusWithSuccess:(void(^)())success
                                         failure:(void(^)())failure;

/**
 判断相机权限
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)jx_judgeCameraAuthStatusWithSuccess:(void(^)())success
                                    failure:(void(^)())failure;

/**
 判断相册权限
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)jx_judgeAlbumAuthStatusWithSuccess:(void (^)())success
                                   failure:(void (^)())failure;

/**
 判断麦克风权限
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)jx_judgeMicrophoneAuthStatusWithSuccess:(void (^)())success
                                        failure:(void (^)())failure;

/**
 判断定位权限
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)jx_judgeLocationAuthStatusWithSuccess:(void (^)())success
                                      failure:(void (^)())failure;

/**
 打开系统应用设置
 */
+ (void)jx_openApplicationSetting;

@end
