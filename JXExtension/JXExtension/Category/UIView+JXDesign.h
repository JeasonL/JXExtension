//
//  UIView+JXDesign.h
//  JXExtension
//
//  Created by Jeason on 2017/7/14.
//  Copyright © 2017年 Jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDVersion/SDiOSVersion.h>

@interface UIView (JXDesign)

@property (nonatomic) CGFloat design_x;
@property (nonatomic) CGFloat design_y;

@property (nonatomic) CGFloat design_width;
@property (nonatomic) CGFloat design_height;

@property (nonatomic) CGFloat design_centerX;
@property (nonatomic) CGFloat design_centerY;

@property (nonatomic) CGFloat design_top;
@property (nonatomic) CGFloat design_bottom;
@property (nonatomic) CGFloat design_right;
@property (nonatomic) CGFloat design_left;

@property (nonatomic) CGPoint design_origin;
@property (nonatomic) CGSize design_size;

+ (CGFloat)designVaule:(CGFloat)vaule;
+ (CGFloat)designVaule:(CGFloat)vaule deviceSize:(DeviceSize)deviceSize;

//design_x
- (void)setDesign_x:(CGFloat)design_x deviceSize:(DeviceSize)deviceSize;
- (CGFloat)design_xWithDeviceSize:(DeviceSize)deviceSize;

//design_y
- (void)setDesign_y:(CGFloat)design_y deviceSize:(DeviceSize)deviceSize;
- (CGFloat)design_yWithDeviceSize:(DeviceSize)deviceSize;

//design_width
- (void)setDesign_width:(CGFloat)design_width deviceSize:(DeviceSize)deviceSize;
- (CGFloat)design_widthWithDeviceSize:(DeviceSize)deviceSize;

//design_height
- (void)setDesign_height:(CGFloat)design_height deviceSize:(DeviceSize)deviceSize;
- (CGFloat)design_heightWithDeviceSize:(DeviceSize)deviceSize;

//design_centerX
- (void)setDesign_centerX:(CGFloat)design_centerX deviceSize:(DeviceSize)deviceSize;
- (CGFloat)design_centerXWithDeviceSize:(DeviceSize)deviceSize;

//design_centerY
- (void)setDesign_centerY:(CGFloat)design_centerY deviceSize:(DeviceSize)deviceSize;
- (CGFloat)design_centerYWithDeviceSize:(DeviceSize)deviceSize;

//design_top
- (void)setDesign_top:(CGFloat)design_top deviceSize:(DeviceSize)deviceSize;
- (CGFloat)design_topWithDeviceSize:(DeviceSize)deviceSize;

//design_bottom
- (void)setDesign_bottom:(CGFloat)design_bottom deviceSize:(DeviceSize)deviceSize;
- (CGFloat)design_bottomWithDeviceSize:(DeviceSize)deviceSize;

//design_right
- (void)design_right:(CGFloat)design_right deviceSize:(DeviceSize)deviceSize;
- (CGFloat)design_rightWithDeviceSize:(DeviceSize)deviceSize;

//design_left
- (void)setDesign_left:(CGFloat)design_left deviceSize:(DeviceSize)deviceSize;
- (CGFloat)design_leftWithDeviceSize:(DeviceSize)deviceSize;

//design_origin
- (void)setDesign_origin:(CGPoint)design_origin deviceSize:(DeviceSize)deviceSize;
- (CGPoint)design_originWithDeviceSize:(DeviceSize)deviceSize;

//design_size
- (void)setDesign_size:(CGSize)design_size deviceSize:(DeviceSize)deviceSize;
- (CGSize)design_sizeWithDeviceSize:(DeviceSize)deviceSize;

@end
