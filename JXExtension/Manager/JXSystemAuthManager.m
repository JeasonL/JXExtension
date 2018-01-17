//
//  JXSystemAuthManager.m
//  JXExtension
//
//  Created by Jeason on 2017/9/5.
//  Copyright © 2017年 Jeason.Lee. All rights reserved.
//

#import "JXSystemAuthManager.h"
#import <AddressBook/AddressBook.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <CoreLocation/CLLocationManager.h>
#import <EventKit/EventKit.h>

@implementation JXSystemAuthManager

+ (void)jx_judgeAddressBookAuthStatusWithSuccess:(void(^)(void))success
                                         failure:(void(^)(void))failure {
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        success ? success() : nil;
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied) {
        failure ? failure() : nil;
    } else {
        ABAddressBookRef addressBookRef = ABAddressBookCreate();
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            if (granted) {
                success ? success() : nil;
            } else {
                failure ? failure() : nil;
            }
        });
        CFRelease(addressBookRef);
    }
}

+ (void)jx_judgeCameraAuthStatusWithSuccess:(void(^)(void))success
                                    failure:(void(^)(void))failure {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusAuthorized) {
        success ? success() : nil;
    } else if (status == AVAuthorizationStatusDenied) {
        failure ? failure() : nil;
    } else {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                success ? success() : nil;
            } else {
                failure ? failure() : nil;
            }
        }];
    }
}

+ (void)jx_judgeAlbumAuthStatusWithSuccess:(void(^)(void))success
                                   failure:(void(^)(void))failure {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusAuthorized){
        success ? success() : nil;
    } else if (status == PHAuthorizationStatusDenied) {
        failure ? failure() : nil;
    }else {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
            if (status == PHAuthorizationStatusAuthorized){
                success ? success() : nil;
            } else {
                failure ? failure() : nil;
            }
        }];
    }
}

+ (void)jx_judgeMicrophoneAuthStatusWithSuccess:(void(^)(void))success
                                        failure:(void(^)(void))failure {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (status == AVAuthorizationStatusAuthorized) {
        success ? success() : nil;
    } else if (status == AVAuthorizationStatusDenied) {
        failure ? failure() : nil;
    } else {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            if (granted) {
                success ? success() : nil;
            } else {
                failure ? failure() : nil;
            }
        }];
    }
}

+ (void)jx_judgeLocationAuthStatusWithSuccess:(void(^)(void))success
                                      failure:(void(^)(void))failure {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        success ? success() : nil;
    } else if (status == kCLAuthorizationStatusDenied) {
        failure ? failure() : nil;
    } else {
        failure ? failure() : nil;
    }
}

+ (void)jx_judgeReminderAuthStatusWithSuccess:(void(^)(void))success
                                      failure:(void(^)(void))failure {
    [JXSystemAuthManager jx_judgeEvnetAuthStatusWithEntityType:EKEntityTypeReminder success:success failure:failure];
}

+ (void)jx_judgeCalendarAuthStatusWithSuccess:(void(^)(void))success
                                      failure:(void(^)(void))failure {
    [JXSystemAuthManager jx_judgeEvnetAuthStatusWithEntityType:EKEntityTypeEvent success:success failure:failure];
}

+ (void)jx_openApplicationSetting {
    NSURL *settringUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:settringUrl];
}

#pragma mark - Private Method

+ (void)jx_judgeEvnetAuthStatusWithEntityType:(EKEntityType)entityType
                                      success:(void(^)(void))success
                                      failure:(void(^)(void))failure {
    EKAuthorizationStatus status = [EKEventStore  authorizationStatusForEntityType:entityType];
    if (status == EKAuthorizationStatusAuthorized) {
        success ? success() : nil;
    } else if (status == EKAuthorizationStatusDenied) {
        failure ? failure() : nil;
    } else {
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        [eventStore requestAccessToEntityType:entityType completion:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                success ? success() : nil;
            } else {
                failure ? failure() : nil;
            }
        }];
    }
}

@end
