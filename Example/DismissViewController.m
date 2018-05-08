//
//  DismissViewController.m
//  JXExtension
//
//  Created by Jeason on 2018/5/7.
//  Copyright © 2018年 Jeason.Lee. All rights reserved.
//

#import "DismissViewController.h"

@interface DismissViewController ()

@end

@implementation DismissViewController

+ (UINavigationController *)navigationController {
    DismissViewController *viewController = [[DismissViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    return navigationController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Dismiss";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 40);
    [button setTitle:self.title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
