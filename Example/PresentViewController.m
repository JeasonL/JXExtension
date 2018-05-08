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
#import "DemoPresentationController.h"

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
    [self presentWithDirection:[JXInteractiveDirection directionWithTo:JXAnimatorDirectionTop back:JXAnimatorDirectionBottom]];
}

- (void)presentWithDirection:(JXInteractiveDirection *)direction {
    UINavigationController *nav = [DismissViewController navigationController];
    JXPushAnimator *pushAnimator = [[JXPushAnimator alloc] init];
    [pushAnimator setPresentationControllerBlock:^UIPresentationController *(UIViewController *presented, UIViewController *presenting) {
        return [[DemoPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    }];
    pushAnimator.animatorMode = direction.toDirection;
    pushAnimator.toInteractive = self.interactive;
    pushAnimator.backInteractive = ({
        JXInteractiveTransition *backInteractive = [[JXInteractiveTransition alloc] initWithType:JXInteractiveTypeDismiss];
        [backInteractive addPanGestureForViewController:nav];
        backInteractive.direction = direction.backDirection;
        backInteractive.timerEable = YES;
        backInteractive;
    });
    [self jx_presentViewController:nav animator:pushAnimator completion:nil];
}

- (JXInteractiveTransition *)interactive {
    if (!_interactive) {
        _interactive = [[JXInteractiveTransition alloc] initWithType:JXInteractiveTypePresent];
        typeof(self)weakSelf = self;
        [_interactive setPresentConfigBlock:^(JXInteractiveDirection *direction) {
            [weakSelf presentWithDirection:direction];
        }];
        _interactive.direction = JXAnimatorDirectionAll;
        _interactive.timerEable = YES;
    }
    return _interactive;
}

@end
