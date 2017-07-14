//
//  UIView+JXDesign.m
//  JXExtension
//
//  Created by Jeason on 2017/7/14.
//  Copyright © 2017年 Jeason. All rights reserved.
//

#import "UIView+JXDesign.h"
#import "UIView+JXFrame.h"

@implementation UIView (JXDesign)

+ (CGFloat)designVaule:(CGFloat)vaule {
    return [self scaleWithDeviceSize:self.defultDeviceSize];
}

+ (CGFloat)designVaule:(CGFloat)vaule deviceSize:(DeviceSize)deviceSize {
    CGFloat scale = [self scaleWithDeviceSize:deviceSize];
    return vaule * scale;
}

#pragma mark - design_x

- (void)setDesign_x:(CGFloat)design_x {
    self.design_x = [self setJx_value:design_x];
}

- (CGFloat)design_x {
    return [self getJx_value:self.jx_x];
}

- (void)setDesign_x:(CGFloat)design_x deviceSize:(DeviceSize)deviceSize {
    self.design_x = [self setJx_value:design_x deviceSize:deviceSize];
}

- (CGFloat)design_xWithDeviceSize:(DeviceSize)deviceSize {
    return [self getJx_value:self.jx_x deviceSize:deviceSize];
}

#pragma mark - design_y

- (void)setDesign_y:(CGFloat)design_y {
    self.design_y = [self setJx_value:design_y];
}

- (CGFloat)design_y {
    return [self getJx_value:self.jx_y];
}

- (void)setDesign_y:(CGFloat)design_y deviceSize:(DeviceSize)deviceSize {
    self.design_y = [self setJx_value:design_y deviceSize:deviceSize];
}

- (CGFloat)design_yWithDeviceSize:(DeviceSize)deviceSize {
    return [self getJx_value:self.jx_y deviceSize:deviceSize];
}

#pragma mark - design_width

- (void)setDesign_width:(CGFloat)design_width {
    self.design_width = [self setJx_value:design_width];
}

- (CGFloat)design_width {
    return [self getJx_value:self.jx_width];
}

- (void)setDesign_width:(CGFloat)design_width deviceSize:(DeviceSize)deviceSize {
    self.design_width = [self setJx_value:design_width deviceSize:deviceSize];
}

- (CGFloat)design_widthWithDeviceSize:(DeviceSize)deviceSize {
    return [self getJx_value:self.jx_width deviceSize:deviceSize];
}

#pragma mark - design_height

- (void)setDesign_height:(CGFloat)design_height {
    self.design_height = [self setJx_value:design_height];
}

- (CGFloat)design_height {
    return [self getJx_value:self.jx_height];
}

- (void)setDesign_height:(CGFloat)design_height deviceSize:(DeviceSize)deviceSize {
    self.design_height = [self setJx_value:design_height deviceSize:deviceSize];
}

- (CGFloat)design_heightWithDeviceSize:(DeviceSize)deviceSize {
    return [self getJx_value:self.jx_height deviceSize:deviceSize];
}

#pragma mark - design_centerX

- (void)setDesign_centerX:(CGFloat)design_centerX {
    self.design_centerX = [self setJx_value:design_centerX];
}

- (CGFloat)design_centerX {
    return [self getJx_value:self.jx_centerX];
}

- (void)setDesign_centerX:(CGFloat)design_centerX deviceSize:(DeviceSize)deviceSize {
    self.design_centerX = [self setJx_value:design_centerX deviceSize:deviceSize];
}

- (CGFloat)design_centerXWithDeviceSize:(DeviceSize)deviceSize {
    return [self getJx_value:self.jx_centerX deviceSize:deviceSize];
}

#pragma mark - design_centerY

- (void)setDesign_centerY:(CGFloat)design_centerY {
    self.design_centerY = [self setJx_value:design_centerY];
}

- (CGFloat)design_centerY {
    return [self getJx_value:self.jx_centerY];
}

- (void)setDesign_centerY:(CGFloat)design_centerY deviceSize:(DeviceSize)deviceSize {
    self.design_centerY = [self setJx_value:design_centerY deviceSize:deviceSize];
}

- (CGFloat)design_centerYWithDeviceSize:(DeviceSize)deviceSize {
    return [self getJx_value:self.jx_centerY deviceSize:deviceSize];
}

#pragma mark - design_top

- (void)setDesign_top:(CGFloat)design_top {
    self.design_top = [self setJx_value:design_top];
}

- (CGFloat)design_top {
    return [self getJx_value:self.jx_top];
}

- (void)setDesign_top:(CGFloat)design_top deviceSize:(DeviceSize)deviceSize {
    self.design_top = [self setJx_value:design_top deviceSize:deviceSize];
}

- (CGFloat)design_topWithDeviceSize:(DeviceSize)deviceSize {
    return [self getJx_value:self.jx_top deviceSize:deviceSize];
}

#pragma mark - design_bottom

- (void)setDesign_bottom:(CGFloat)design_bottom {
    self.design_bottom = [self setJx_value:design_bottom];
}

- (CGFloat)design_bottom {
    return [self getJx_value:self.jx_bottom];
}

- (void)setDesign_bottom:(CGFloat)design_bottom deviceSize:(DeviceSize)deviceSize {
    self.design_bottom = [self setJx_value:design_bottom deviceSize:deviceSize];
}

- (CGFloat)design_bottomWithDeviceSize:(DeviceSize)deviceSize {
    return [self getJx_value:self.jx_bottom deviceSize:deviceSize];
}

#pragma mark - design_right

- (void)setDesign_right:(CGFloat)design_right {
    self.design_right = [self setJx_value:design_right];
}

- (CGFloat)design_right {
    return [self getJx_value:self.jx_right];
}

- (void)design_right:(CGFloat)design_right deviceSize:(DeviceSize)deviceSize {
    self.design_right = [self setJx_value:design_right deviceSize:deviceSize];
}

- (CGFloat)design_rightWithDeviceSize:(DeviceSize)deviceSize {
    return [self getJx_value:self.jx_right deviceSize:deviceSize];
}

#pragma mark - design_left

- (void)setDesign_left:(CGFloat)design_left {
    self.design_left = [self setJx_value:design_left];
}

- (CGFloat)design_left {
    return [self getJx_value:self.jx_left];
}

- (void)setDesign_left:(CGFloat)design_left deviceSize:(DeviceSize)deviceSize {
    self.design_left = [self setJx_value:design_left deviceSize:deviceSize];
}

- (CGFloat)design_leftWithDeviceSize:(DeviceSize)deviceSize {
    return [self getJx_value:self.jx_left deviceSize:deviceSize];
}

#pragma mark - design_origin

- (void)setDesign_origin:(CGPoint)design_origin {
    design_origin.x = [self setJx_value:design_origin.x];
    design_origin.y = [self setJx_value:design_origin.y];
    self.design_origin = design_origin;
}

- (CGPoint)design_origin {
    CGPoint origin;
    origin.x = [self getJx_value:self.jx_origin.x];
    origin.y = [self getJx_value:self.jx_origin.y];
    return origin;
}

- (void)setDesign_origin:(CGPoint)design_origin deviceSize:(DeviceSize)deviceSize {
    design_origin.x = [self setJx_value:design_origin.x deviceSize:deviceSize];
    design_origin.y = [self setJx_value:design_origin.y deviceSize:deviceSize];
    self.design_origin = design_origin;
}

- (CGPoint)design_originWithDeviceSize:(DeviceSize)deviceSize {
    CGPoint origin;
    origin.x = [self getJx_value:self.jx_origin.x deviceSize:deviceSize];
    origin.y = [self getJx_value:self.jx_origin.y deviceSize:deviceSize];
    return origin;
}

#pragma mark - design_size

- (void)setDesign_size:(CGSize)design_size {
    design_size.width = [self setJx_value:design_size.width];
    design_size.height = [self setJx_value:design_size.height];
    self.design_size = design_size;
}

- (CGSize)design_size {
    CGSize size;
    size.width = [self getJx_value:self.jx_size.width];
    size.height = [self getJx_value:self.jx_size.height];
    return size;
}

- (void)setDesign_size:(CGSize)design_size deviceSize:(DeviceSize)deviceSize{
    design_size.width = [self setJx_value:design_size.width deviceSize:deviceSize];
    design_size.height = [self setJx_value:design_size.height deviceSize:deviceSize];
    self.design_size = design_size;
}

- (CGSize)design_sizeWithDeviceSize:(DeviceSize)deviceSize {
    CGSize size;
    size.width = [self getJx_value:self.jx_size.width deviceSize:deviceSize];
    size.height = [self getJx_value:self.jx_size.height deviceSize:deviceSize];
    return size;
}

#pragma mark - Private Method

- (CGFloat)setJx_value:(CGFloat)value {
    DeviceSize deviceSize = [UIView defultDeviceSize];
    return [self setJx_value:value deviceSize:deviceSize];
}

- (CGFloat)getJx_value:(CGFloat)value {
    DeviceSize deviceSize = [UIView defultDeviceSize];
    return [self getJx_value:value deviceSize:deviceSize];
}

- (CGFloat)setJx_value:(CGFloat)value deviceSize:(DeviceSize)deviceSize {
    CGFloat scale = [UIView scaleWithDeviceSize:deviceSize];
    return value * scale;
}

- (CGFloat)getJx_value:(CGFloat)value deviceSize:(DeviceSize)deviceSize {
    CGFloat scale = [UIView scaleWithDeviceSize:deviceSize];
    return value / scale;
}

+ (DeviceSize)defultDeviceSize {
    return Screen4Dot7inch;
}

+ (CGFloat)scaleWithDeviceSize:(DeviceSize)deviceSize {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat width;
    switch (deviceSize) {
        case Screen3Dot5inch: {
            width = 320.0;
            break;
        }
        case Screen4inch: {
            width = 320.0;
            break;
        }
        case Screen4Dot7inch: {
            width = 375.0;
            break;
        }
        case Screen5Dot5inch: {
            width = 414.0;
            break;
        }
        default: {
            width = 320.0;
            break;
        }
    }
    return screenWidth / width;
}

@end
