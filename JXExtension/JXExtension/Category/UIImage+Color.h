//
//  UIImage+Color.h
//  JXCommonExtension
//
//  Created by Jeason on 2017/6/15.
//  Copyright © 2017年 JeasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color;
- (UIColor *)colorAtPixel:(CGPoint)point;
- (BOOL)hasAlphaChannel;    //返回该图片是否有透明度通道

@end
