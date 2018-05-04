//
//  JXInteractiveObject.h
//  JXExtension
//
//  Created by Jeason on 2018/5/3.
//  Copyright © 2018年 Jeason.Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXInteractiveObject : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign, readonly) BOOL isInteractive;

- (instancetype)initWithViewController:(UIViewController *)viewController;

@end
