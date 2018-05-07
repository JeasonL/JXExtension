//
//  PresentViewController.m
//  JXExtension
//
//  Created by Jeason on 2018/5/5.
//  Copyright © 2018年 Jeason.Lee. All rights reserved.
//

#import "PresentViewController.h"

@interface PresentViewController ()

@end

@implementation PresentViewController

+ (UINavigationController *)navigationController {
    PresentViewController *viewController = [[PresentViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    (navigationController.viewControllers.firstObject).view.backgroundColor = [UIColor orangeColor];
    return navigationController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Present";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
