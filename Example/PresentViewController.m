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
@property (strong, nonatomic) DemoPresentationController *presentationController;

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
    
    typeof(self)weakSelf = self;
    [self jx_registerToInteractiveTransitionWithDirection:JXAnimatorDirectionAll minPersent:0.05 transitonBlock:^(JXInteractiveDirection *direction) {
        [weakSelf presentWithDirection:direction.toDirection];
    }];
}

- (void)presentWithDirection:(JXAnimatorDirection)direction {
    UINavigationController *nav = [DismissViewController navigationController];
    JXPushAnimator *pushAnimator = [[JXPushAnimator alloc] init];
    [pushAnimator setPresentationControllerBlock:^UIPresentationController *(UIViewController *presented, UIViewController *presenting) {
        return [[DemoPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    }];
    pushAnimator.animatorMode = direction;
    [self jx_presentViewController:nav animator:pushAnimator completion:nil];
}

- (void)present {
    [self presentWithDirection:JXAnimatorDirectionLeft];
}

@end
