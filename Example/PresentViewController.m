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

@property (strong, nonatomic) JXInteractiveTransition *toInteractive;

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
    
    self.toInteractive = [[JXInteractiveTransition alloc] initWithType:JXInteractiveTypePresent direction:JXInteractiveGestureDirectionRight];
    typeof(self)weakSelf = self;
    [self.toInteractive setPresentConfigBlock:^{
        [weakSelf present];
    }];
    [self.toInteractive addPanGestureForViewController:self];
}

- (void)present {
    UINavigationController *nav = [DismissViewController navigationController];
    JXPushAnimator *pushAnimator = [[JXPushAnimator alloc] init];
    pushAnimator.animatorMode = JXPushAnimatorModeLeft;
    pushAnimator.interactive = [[JXInteractiveTransition alloc] initWithType:JXInteractiveTypeDismiss direction:JXInteractiveGestureDirectionLeft];
    [self jx_presentViewController:nav withAnimator:pushAnimator completion:nil];
}

@end
