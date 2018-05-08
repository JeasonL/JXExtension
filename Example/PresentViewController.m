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

@property (strong, nonatomic) JXInteractiveTransition *interactive;

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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 40);
    [button setTitle:self.title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [self.interactive addPanGestureForViewController:self];
}

- (void)present {
    [self presentWithDirection:JXAnimatorDirectionLeft];
}

- (void)presentWithDirection:(JXAnimatorDirection)direction {
    UINavigationController *nav = [DismissViewController navigationController];
    JXPushAnimator *pushAnimator = [[JXPushAnimator alloc] init];
    pushAnimator.animatorMode = direction;
    pushAnimator.toInteractive = self.interactive;
    pushAnimator.backInteractive = ({
        JXInteractiveTransition *backInteractive = [[JXInteractiveTransition alloc] initWithType:JXInteractiveTypeDismiss];
        [backInteractive addPanGestureForViewController:nav];
        backInteractive;
    });
    [self jx_presentViewController:nav withAnimator:pushAnimator completion:nil];
}

- (JXInteractiveTransition *)interactive {
    if (!_interactive) {
        _interactive = [[JXInteractiveTransition alloc] initWithType:JXInteractiveTypePresent];
        typeof(self)weakSelf = self;
        [_interactive setPresentConfigBlock:^(JXAnimatorDirection direction) {
            [weakSelf presentWithDirection:direction];
        }];
    }
    return _interactive;
}

@end
