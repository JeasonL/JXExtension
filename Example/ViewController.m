//
//  ViewController.m
//  JXExtension
//
//  Created by Jeason on 2017/8/5.
//  Copyright © 2017年 Jeason.Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)selectedButtonAction:(UIButton *)sender {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
