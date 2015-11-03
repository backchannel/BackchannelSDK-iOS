//
//  BAKAuthenticationViewController.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 1/9/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKAuthenticationViewController.h"
#import "BAKAuthenticationData.h"

@interface BAKAuthenticationViewController () <UITextFieldDelegate>

@end

@implementation BAKAuthenticationViewController

@dynamic view;

- (instancetype)initWithAuthenticationData:(BAKAuthenticationData *)data {
    self = [super init];
    if (!self) return nil;
    
    _data = data;
    
    return self;
}

- (void)loadView {
    self.view = [[BAKAuthenticationForm alloc] init];
}

- (BAKAuthenticationForm *)authenticationForm {
    return self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.authenticationForm.emailField.delegate = self;
    self.authenticationForm.passwordField.delegate = self;
    [self.authenticationForm.actionButton addTarget:self action:@selector(actionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.authenticationForm.forgotPasswordButton addTarget:self action:@selector(forgotPasswordButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.authenticationForm.actionButton setTitle:self.data.actionButtonTitle forState:UIControlStateNormal];
    self.authenticationForm.loadingViewLabel.text = self.data.loadingString;
    self.authenticationForm.forgotPasswordButton.hidden = !self.data.showForgotPassword;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.data.actionButtonTitle style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self updateLayoutInsets];
}

- (void)showKeyboard {
    [self.authenticationForm.emailField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField; {
    if (textField == self.authenticationForm.emailField) {
        [self.authenticationForm.passwordField becomeFirstResponder];
    }
    if (textField == self.authenticationForm.passwordField) {
        [self actionButtonTapped:self];
    }
    return NO;
}

- (void)updateLayoutInsets {
    self.authenticationForm.layoutInsets = UIEdgeInsetsMake([self.topLayoutGuide length], 0, [self.bottomLayoutGuide length], 0);
}

- (void)keyboardWillAppear:(NSNotification *)note {
    CGRect keyboardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.authenticationForm.keyboardHeight = keyboardRect.size.height;
}

- (void)keyboardWillDisappear:(NSNotification *)note {

}

- (void)actionButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(authenticationViewController:didTapActionButtonWithEmail:password:)]) {
        NSString *email = self.authenticationForm.emailField.text ?: @"";
        NSString *password = self.authenticationForm.passwordField.text ?: @"";
        [self.delegate authenticationViewController:self didTapActionButtonWithEmail:email password:password];
    }
}

- (void)forgotPasswordButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(authenticationViewController:didTapForgotPasswordButtonWithEmail:)]) {
        NSString *email = self.authenticationForm.emailField.text ?: @"";
        [self.delegate authenticationViewController:self didTapForgotPasswordButtonWithEmail:email];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
