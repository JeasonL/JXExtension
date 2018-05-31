//
//  JXDirectionPanGestureRecognizer.h
//  JXExtension
//
//  Created by Jeason on 2018/5/30.
//  Copyright © 2018年 Jeason.Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface JXDirectionPanGestureRecognizer : UIPanGestureRecognizer

//手势滑动的方向
@property (nonatomic, assign) JXAnimatorDirection direction;

@end
