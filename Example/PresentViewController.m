//
//  PresentViewController.m
//  JXExtension
//
//  Created by Jeason on 2018/5/5.
//  Copyright © 2018年 Jeason.Lee. All rights reserved.
//

#import "PresentViewController.h"
#import "DismissViewController.h"
#import "JXPushAnimator.h"
#import "JXInteractiveTransition.h"

@interface PresentViewController ()

@property (strong, nonatomic) JXInteractiveTransition *leftInteractive;

@end

@implementation PresentViewController

+ (UINavigationController *)navigationController {
    PresentViewController *viewController = [[PresentViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    return navigationController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Present";
    self.view.backgroundColor = [UIColor orangeColor];
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(100, 100, 100, 40);
//    [button setTitle:self.title forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    

    [self.leftInteractive addPanGestureForViewController:self];
}

- (JXInteractiveTransition *)leftInteractive {
    if (!_leftInteractive) {
        _leftInteractive = [[JXInteractiveTransition alloc] initWithType:JXInteractiveTypePresent direction:JXAnimatorDirectionRight];
        typeof(self)weakSelf = self;
        [_leftInteractive setDirectionBlock:^(JXAnimatorDirection direction) {
            [weakSelf presentWithDirection:direction];
        }];
    }
    return _leftInteractive;
}

- (void)presentWithDirection:(JXAnimatorDirection)direction {
    UINavigationController *nav = [DismissViewController navigationController];
    JXPushAnimator *pushAnimator = [[JXPushAnimator alloc] init];
    pushAnimator.animatorMode = direction;
    JXAnimatorDirection flipDirection;
    if (direction == JXAnimatorDirectionLeft) {
        flipDirection = JXAnimatorDirectionRight;
    } else if (direction == JXAnimatorDirectionRight) {
        flipDirection = JXAnimatorDirectionLeft;
    } else if (direction == JXAnimatorDirectionTop) {
        flipDirection = JXAnimatorDirectionBottom;
    } else {
        flipDirection = JXAnimatorDirectionTop;
    }
    pushAnimator.interactive = [[JXInteractiveTransition alloc] initWithType:JXInteractiveTypeDismiss direction:flipDirection];
    pushAnimator.toInteractive = self.leftInteractive;
    [self jx_presentViewController:nav withAnimator:pushAnimator completion:nil];
}

@end
