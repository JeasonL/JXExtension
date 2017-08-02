//
//  ViewController.m
//  JXExtension
//
//  Created by Jeason on 2017/6/23.
//  Copyright © 2017年 Jeason. All rights reserved.
//

#import "ViewController.h"
#import "JXExtension.h"
#import "JXDemoAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

- (IBAction)showAlertAction:(id)sender {
    JXDemoAlertView *view = [[JXDemoAlertView alloc] init];
    [view show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
