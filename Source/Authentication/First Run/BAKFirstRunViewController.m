//
//  BAKAuthViewController.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 1/9/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKFirstRunViewController.h"
#import "BAKAuthenticationViewController.h"
#import "BAKGeometry.h"

@interface BAKFirstRunViewController ()

@end

@implementation BAKFirstRunViewController

@dynamic view;

- (BAKFirstRunView *)firstRunView {
    return self.view;
}

- (void)loadView {
    self.view = [BAKFirstRunView new];
    self.title = @"Backchannel";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.firstRunView.createAccountButton addTarget:self action:@selector(informDelegateOfAccountCreation:) forControlEvents:UIControlEventTouchUpInside];
    [self.firstRunView.signInButton addTarget:self action:@selector(informDelegateOfSignIn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)informDelegateOfAccountCreation:(id)sender {
    if ([self.delegate respondsToSelector:@selector(firstRunViewControllerDidTapCreateAccount:)]) {
        [self.delegate firstRunViewControllerDidTapCreateAccount:self];
    }
}

- (void)informDelegateOfSignIn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(firstRunViewControllerDidTapSignIn:)]) {
        [self.delegate firstRunViewControllerDidTapSignIn:self];
    }
}

@end
