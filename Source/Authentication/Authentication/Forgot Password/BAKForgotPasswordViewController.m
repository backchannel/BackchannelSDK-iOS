//
//  BAKForgotPasswordViewController.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKForgotPasswordViewController.h"

@implementation BAKForgotPasswordViewController

@dynamic view;

- (instancetype)initWithEmail:(NSString *)email {
    self = [super init];
    if (!self) return nil;
    
    _email = email;
    
    return self;
}

- (void)loadView {
    self.view = [BAKForgotPasswordView new];
}

- (BAKForgotPasswordView *)forgotPasswordView {
    return self.view;
}

- (void)viewDidLoad {
    self.forgotPasswordView.emailField.text = self.email;
    self.title = @"Forgot Password";
    [self.forgotPasswordView.resetButton addTarget:self action:@selector(informDelegateOfPasswordReset:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)informDelegateOfPasswordReset:(id)sender {
    if ([self.delegate respondsToSelector:@selector(forgotPasswordViewController:didTapResetWithEmail:)]) {
        NSString *email = self.forgotPasswordView.emailField.text ?: @"";
        [self.delegate forgotPasswordViewController:self didTapResetWithEmail:email];
    }
}

@end
