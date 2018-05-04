//
//  JXInteractiveObject.m
//  JXExtension
//
//  Created by Jeason on 2018/5/3.
//  Copyright © 2018年 Jeason.Lee. All rights reserved.
//

#import "JXInteractiveObject.h"

@interface JXInteractiveObject ()

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, assign, readwrite) BOOL isInteractive;

@end

@implementation JXInteractiveObject

- (instancetype)initWithViewController:(UIViewController *)viewController {
    if (self = [super init]) {
        _isInteractive = NO;
        _viewController = viewController;
        UIPanGestureRecognizer *panGestureRecognizer =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        [viewController.view addGestureRecognizer:panGestureRecognizer];
    }
    return self;
}

- (void)panGestureAction:(UIPanGestureRecognizer *)recognizer {
    CGFloat progress = [recognizer translationInView:self.viewController.view].x / (self.viewController.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    self.isInteractive = YES;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self.viewController dismissViewControllerAnimated:YES completion:nil];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        if (progress > 0.3) {
            [self finishInteractiveTransition];
        } else {
            [self cancelInteractiveTransition];
        }
        self.isInteractive = NO;
    }
}

@end
