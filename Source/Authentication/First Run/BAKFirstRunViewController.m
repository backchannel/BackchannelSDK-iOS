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

- (instancetype)initWithEmailButtonShowing:(BOOL)emailButtonShowing {
    self = [super init];
    if (!self) return nil;
    
    _emailButtonShowing = emailButtonShowing;
    
    return self;
}

- (BAKFirstRunView *)firstRunView {
    return self.view;
}

- (void)loadView {
    self.view = [[BAKFirstRunView alloc] initWithEmailButtonShowing:self.emailButtonShowing];
    self.title = @"Backchannel";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.firstRunView.createAccountButton addTarget:self action:@selector(informDelegateOfAccountCreation:) forControlEvents:UIControlEventTouchUpInside];
    [self.firstRunView.signInButton addTarget:self action:@selector(informDelegateOfSignIn:) forControlEvents:UIControlEventTouchUpInside];
    [self.firstRunView.postViaEmailButton addTarget:self action:@selector(informDelegateOfPostViaEmail:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)informDelegateOfPostViaEmail:(id)sender {
    if ([self.delegate respondsToSelector:@selector(firstRunViewControllerDidTapPostViaEmail:)]) {
        [self.delegate firstRunViewControllerDidTapPostViaEmail:self];
    }
}

@end
