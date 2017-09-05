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

@implementation JXSystemAuthManager

+ (void)jx_judgeAddressBookAuthStatusWithSuccess:(void(^)())success failure:(void(^)())failure {
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        success ? success() : nil;
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied) {
        failure ? failure() : nil;
    } else {
        ABAddressBookRef addressBookRef = ABAddressBookCreate();
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success ? success() : nil;
                });
            }
        });
        CFRelease(addressBookRef);
    }
}

+ (void)jx_judgeCameraAuthStatusWithSuccess:(void(^)())success failure:(void(^)())failure {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusAuthorized) {
        success ? success() : nil;
    } else if (status == AVAuthorizationStatusDenied) {
        failure ? failure() : nil;
    } else {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success ? success() : nil;
                });
            }
        }];
    }
}

+ (void)jx_judgeAlbumAuthStatusWithSuccess:(void (^)())success failure:(void (^)())failure {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusAuthorized){
        success ? success() : nil;
    } else if (status == PHAuthorizationStatusDenied) {
        failure ? failure() : nil;
    }else {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
            if (status == PHAuthorizationStatusAuthorized){
                dispatch_async(dispatch_get_main_queue(), ^{
                    success ? success() : nil;
                });
            }
        }];
    }
}

+ (void)jx_judgeMicrophoneAuthStatusWithSuccess:(void (^)())success failure:(void (^)())failure {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (status == AVAuthorizationStatusAuthorized) {
        success ? success() : nil;
    } else if (status == AVAuthorizationStatusDenied) {
        failure ? failure() : nil;
    } else {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success ? success() : nil;
                });
            }
        }];
    }
}

+ (void)jx_judgeLocationAuthStatusWithSuccess:(void (^)())success failure:(void (^)())failure {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        success ? success() : nil;
    } else if (status == kCLAuthorizationStatusDenied) {
        failure ? failure() : nil;
    } else {
        failure ? failure() : nil;
    }
}

+ (void)jx_openApplicationSetting {
    NSURL *settringUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:settringUrl];
}

@end
