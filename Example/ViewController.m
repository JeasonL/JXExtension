//
//  ViewController.m
//  JXExtension
//
//  Created by Jeason on 2017/8/5.
//  Copyright © 2017年 Jeason.Lee. All rights reserved.
//

#import "ViewController.h"
#import "JXPushAnimator.h"
#import "JXBordersView.h"

@interface ViewController () <JXKeyInputTextFieldDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet JXBordersView *bordersView;

@end

@implementation ViewController

+ (UINavigationController *)navigationController {
    ViewController *viewController = [UIStoryboard storyboardWithName:@"Main" bundle:nil].instantiateInitialViewController;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    return navigationController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [JXSystemAuthManager jx_judgeLocationAuthStatusWithSuccess:^{
//
//    } failure:^{
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"打开定位" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
//        [alertView show];
//    }];
    self.bordersView.roundedCorners = JXRoundedCornerTopLeft | JXRoundedCornerTopRight;
    self.bordersView.borderSides = JXBorderSidesBottom;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [JXSystemAuthManager jx_openApplicationSetting];
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)modalAction:(id)sender {
    UINavigationController *nav = [ViewController navigationController];
    [nav.navigationBar setBarTintColor:[UIColor redColor]];
    (nav.viewControllers.firstObject).view.backgroundColor = [UIColor orangeColor];
    JXPushAnimator *pushAnimator = [[JXPushAnimator alloc] init];
    pushAnimator.animatorMode = JXPushAnimatorModeLeft;
    [self jx_presentViewController:nav withAnimator:pushAnimator completion:nil];
}

- (IBAction)selectedButtonAction:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"BBBBBBBBBB" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"CCC" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [alert setTitleColor:[UIColor orangeColor]];
    [alert setTitleFont:[UIFont systemFontOfSize:20]];
    [alert setMessageFont:[UIFont boldSystemFontOfSize:15]];
    [alert setMessageColor:[UIColor greenColor]];
    [self presentViewController:alert animated:YES completion:nil];
    
    [sender jx_selectedTitleWithTitle:@"selected倒计时" startTime:10 canClick:YES progress:^(int seconds) {
        NSLog(@"sProgress:%@", @(seconds));
    } complete:^{
        NSLog(@"s结束");
    }];
//    [sender jx_selectedTitleWithTitle:@"selected倒计时" startTime:120];
    //    [sender jx_selectedTitleWithTitle:@"selected倒计时" startTime:10 complete:^{
    //        NSLog(@"s结束");
    //    }];
    //    [sender jx_selectedTitleWithTitle:@"selected倒计时" startTime:15 waitPrefix:@"selected前序" waitSuffix:@"后序"];
//        [sender jx_selectedTitleWithTitle:@"selected倒计时" startTime:1 waitPrefix:@"s前序" waitSuffix:@"后续" complete:^{
//            NSLog(@"s结束");
//        }];
}

- (IBAction)normalButtonAction:(UIButton *)sender {
    [sender jx_normalTitleWithTitle:@"normal倒计时" startTime:10 progress:^(int seconds) {
        NSLog(@"nProgress:%@", @(seconds));
    } complete:^{
        NSLog(@"n结束");
    }];
//    [sender jx_normalTitleWithTitle:@"normal倒计时" startTime:120];
//        [sender jx_normalTitleWithTitle:@"normal倒计时" startTime:10 complete:^{
//            NSLog(@"n结束");
//        }];
    //    [sender jx_normalTitleWithTitle:@"normal倒计时" startTime:15 waitPrefix:@"normal前序" waitSuffix:@"后序"];
    //    [sender jx_normalTitleWithTitle:@"normal倒计时" startTime:-10 waitPrefix:@"n前序" waitSuffix:@"后续" complete:^{
    //        NSLog(@"n结束");
    //    }];
}

#pragma mark - JXKeyInputTextFieldDelegate

- (void)textFieldDidDeleteBackward:(UITextField *)textField {
    NSLog(@"text:%@", textField.text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
