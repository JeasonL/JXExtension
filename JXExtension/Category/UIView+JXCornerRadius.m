//
//  UIView+JXCornerRadius.m
//  JXExtension
//
//  Created by JeasonLee on 2020/4/24.
//  Copyright © 2020 Jeason.Lee. All rights reserved.
//

#import "UIView+JXCornerRadius.h"

@implementation UIView (JXCornerRadius)

- (void)jx_cornerRadiusWithRoundingCorners:(UIRectCorner)corners radius:(CGFloat)radius {
     [self jx_cornerRadiusWithRoundingCorners:corners radius:radius borderColor:nil borderWidth:0];
}

- (void)jx_cornerRadiusWithRoundingCorners:(UIRectCorner)corners radius:(CGFloat)radius borderColor:(nullable UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
     [self jx_cornerRadiusWithRoundingCorners:corners radius:radius borderColor:borderColor borderWidth:borderWidth backgroundColor:nil];
}

- (void)jx_cornerRadiusWithRoundingCorners:(UIRectCorner)corners radius:(CGFloat)radius borderColor:(nullable UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(nullable UIColor *)backgroundColor {
    [self.superview layoutIfNeeded];
    CGSize cornerRadii = CGSizeMake(radius, radius);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.fillColor = backgroundColor ? backgroundColor.CGColor : [UIColor clearColor].CGColor;
    maskLayer.strokeColor = borderColor ? borderColor.CGColor : [UIColor clearColor].CGColor;
    maskLayer.lineWidth = borderWidth;
    maskLayer.path = maskPath.CGPath;
    [self.layer addSublayer:maskLayer];
}

@end
