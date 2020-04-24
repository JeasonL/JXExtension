//
//  UIView+JXCornerRadius.h
//  JXExtension
//
//  Created by JeasonLee on 2020/4/24.
//  Copyright © 2020 Jeason.Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JXCornerRadius)

- (void)jx_cornerRadiusWithRoundingCorners:(UIRectCorner)corners radius:(CGFloat)radius;
- (void)jx_cornerRadiusWithRoundingCorners:(UIRectCorner)corners radius:(CGFloat)radius borderColor:(nullable UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
- (void)jx_cornerRadiusWithRoundingCorners:(UIRectCorner)corners radius:(CGFloat)radius borderColor:(nullable UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(nullable UIColor *)backgroundColor;

@end

NS_ASSUME_NONNULL_END
