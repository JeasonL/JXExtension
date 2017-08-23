//
//  ViewController.m
//  JXExtension
//
//  Created by Jeason on 2017/8/5.
//  Copyright © 2017年 Jeason.Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <JXKeyInputTextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    [sender jx_selectedTitleWithTitle:@"selected倒计时" startTime:120];
    //    [sender jx_selectedTitleWithTitle:@"selected倒计时" startTime:10 complete:^{
    //        NSLog(@"s结束");
    //    }];
    //    [sender jx_selectedTitleWithTitle:@"selected倒计时" startTime:15 waitPrefix:@"selected前序" waitSuffix:@"后序"];
    //    [sender jx_selectedTitleWithTitle:@"selected倒计时" startTime:1 waitPrefix:@"s前序" waitSuffix:@"后续" complete:^{
    //        NSLog(@"s结束");
    //    }];
}

- (IBAction)normalButtonAction:(UIButton *)sender {
    [sender jx_normalTitleWithTitle:@"normal倒计时" startTime:120];
    //    [sender jx_normalTitleWithTitle:@"normal倒计时" startTime:10 complete:^{
    //        NSLog(@"n结束");
    //    }];
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
