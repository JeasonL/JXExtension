//
//  ParentViewController.m
//  JXExtension
//
//  Created by Jeason on 1/8/2018.
//  Copyright © 2018年 Jeason.Lee. All rights reserved.
//

#import "ParentViewController.h"
#import "ChildViewController.h"

@interface ParentViewController ()

@property (nonatomic, strong) ChildViewController *oneViewController;
@property (nonatomic, strong) ChildViewController *twoViewController;
@property (nonatomic, strong) ChildViewController *threeViewController;

@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;

@end

@implementation ParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"父视图";

    [self addChildViewController:self.oneViewController];
    [self addChildViewController:self.twoViewController];
    [self addChildViewController:self.threeViewController];
    [self.view addSubview:self.oneViewController.view];
    self.currentViewController = self.oneViewController;
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"One" style:UIBarButtonItemStylePlain target:self action:@selector(oneAction:)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"Two" style:UIBarButtonItemStylePlain target:self action:@selector(twoAction:)];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithTitle:@"Three" style:UIBarButtonItemStylePlain target:self action:@selector(threeAction:)];
    self.navigationItem.leftBarButtonItems = @[item1, item2, item3];
}

- (void)transitionFromOldViewController:(UIViewController *)oldViewController toNewViewController:(UIViewController *)newViewController {
    if (self.currentViewController == newViewController) {
        return;
    }
    [newViewController.view setFrame:CGRectMake(0, 0, self.view.jx_width, self.view.jx_height)];
    [self addChildViewController:newViewController];
    [self transitionFromViewController:oldViewController toViewController:newViewController duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newViewController didMoveToParentViewController:self];
            [oldViewController willMoveToParentViewController:nil];
            [oldViewController removeFromParentViewController];
            self.currentViewController = newViewController;
        }else{
            self.currentViewController = oldViewController;
        }
    }];
}

- (void)oneAction:(id)sender {
    [self transitionFromOldViewController:self.currentViewController toNewViewController:self.oneViewController];
}

- (void)twoAction:(id)sender {
    [self transitionFromOldViewController:self.currentViewController toNewViewController:self.twoViewController];}

- (void)threeAction:(id)sender {
    [self transitionFromOldViewController:self.currentViewController toNewViewController:self.threeViewController];
}

#pragma mark - Property Method

- (NSArray<UIViewController *> *)viewControllers {
    return @[self.oneViewController, self.twoViewController, self.threeViewController];
}

- (ChildViewController *)oneViewController {
    if (!_oneViewController) {
        _oneViewController = [[ChildViewController alloc] init];
        _oneViewController.view.backgroundColor = [UIColor purpleColor];
        _oneViewController.title = @"One";
    }
    return _oneViewController;
}

- (ChildViewController *)twoViewController {
    if (!_twoViewController) {
        _twoViewController = [[ChildViewController alloc] init];
        _twoViewController.view.backgroundColor = [UIColor orangeColor];
        _twoViewController.title = @"Two";
    }
    return _twoViewController;
}

- (ChildViewController *)threeViewController {
    if (!_threeViewController) {
        _threeViewController = [[ChildViewController alloc] init];
        _threeViewController.view.backgroundColor = [UIColor yellowColor];
        _threeViewController.title = @"Three";
    }
    return _threeViewController;
}

@end
