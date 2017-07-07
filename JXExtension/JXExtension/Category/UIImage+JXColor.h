//
//  UIImage+JXColor.h
//  JXCommonExtension
//
//  Created by Jeason on 2017/6/15.
//  Copyright © 2017年 JeasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JXColor)

+ (UIImage *)jx_imageWithColor:(UIColor *)color;
- (UIColor *)jx_colorAtPixel:(CGPoint)point;
//返回该图片是否有透明度通道
- (BOOL)jx_hasAlphaChannel;

@end
