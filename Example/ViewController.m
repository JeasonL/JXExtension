//
//  ViewController.m
//  JXExtension
//
//  Created by Jeason on 2017/8/5.
//  Copyright © 2017年 Jeason.Lee. All rights reserved.
//

#import "ViewController.h"
#import "PresentViewController.h"
#import "TableViewController.h"
#import "JXPushAnimator.h"
#import "JXInteractiveTransition.h"
#import "JXBordersView.h"

@interface ViewController () <JXKeyInputTextFieldDelegate, UIAlertViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet JXBordersView *bordersView;
@property (weak, nonatomic) IBOutlet JXTextField *textField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;
@property (weak, nonatomic) IBOutlet JXTextView *textView;

@end

@implementation ViewController

+ (UINavigationController *)navigationController {
    ViewController *viewController = [UIStoryboard storyboardWithName:@"Main" bundle:nil].instantiateInitialViewController;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    return navigationController;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bordersView.roundedCorners = JXRoundedCornerTopLeft | JXRoundedCornerTopRight;
    self.bordersView.borderSides = JXBorderSidesBottom;
    
    self.textField.placeholderFont = [UIFont systemFontOfSize:18.0];
    self.textField.placeholderColor = [UIColor greenColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.textField.placeholder = @"请输入!!";
    });
    
    __weak typeof(self) weakSelf = self;
    [self.textView setChangeBlcok:^(NSString *text, CGFloat height) {
        weakSelf.textViewHeight.constant = height;
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)modalAction:(id)sender {
   UINavigationController *nav = [PresentViewController navigationController];
    [self presentViewController:nav animated:YES completion:nil];
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

- (IBAction)stopScrollAction:(id)sender {
    TableViewController *viewController = [[TableViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - JXKeyInputTextFieldDelegate

- (void)textFieldDidDeleteBackward:(UITextField *)textField {
    NSLog(@"text:%@", textField.text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
//    [textView jx_limitTextWithMaxLength:50];
}

@end
