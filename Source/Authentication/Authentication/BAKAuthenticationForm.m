//
//  BAKAuthenticationForm.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 1/20/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKAuthenticationForm.h"
#import "BAKLoadingView.h"
#import "BAKFormField.h"
#import "BAKFormGroup.h"
#import "BAKAuthenticationButton.h"
#import "BAKColor.h"
#import "BAKAuthenticationFormLayout.h"

@interface BAKAuthenticationForm ()

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) BAKFormGroup *formGroup;
@property (nonatomic) BAKFormField *emailFormField;
@property (nonatomic) BAKFormField *passwordFormField;
@property (nonatomic) UIButton *actionButton;
@property (nonatomic) UIButton *forgotPasswordButton;
@property (nonatomic) BAKLoadingView *loadingView;

@end

@implementation BAKAuthenticationForm

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.alwaysBounceVertical = YES;
        scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        scrollView.backgroundColor = [BAKColor grayBackgroundColor];
        [self addSubview:scrollView];
        
        self.scrollView = scrollView;
    }
    return _scrollView;
}

- (BAKFormGroup *)formGroup {
    if (!_formGroup) {
        BAKFormGroup *formGroup = [[BAKFormGroup alloc] init];
        [formGroup addFormField:self.emailFormField];
        [formGroup addFormField:self.passwordFormField];
        [self.scrollView addSubview:formGroup];
        self.formGroup = formGroup;
    }
    return _formGroup;
}

- (BAKFormField *)emailFormField {
    if (!_emailFormField) {
        BAKFormField *emailFormField = [[BAKFormField alloc] init];
        emailFormField.labelText = @"Email";
        emailFormField.labelWidth = 70;
        UITextField *textField = [emailFormField setTextFieldAsContentView];
        textField.keyboardType = UIKeyboardTypeEmailAddress;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.emailFormField = emailFormField;
    }
    return _emailFormField;
}

- (UITextField *)emailField {
    return (UITextField *)self.emailFormField.contentView;
}

- (BAKFormField *)passwordFormField {
    if (!_passwordFormField) {
        BAKFormField *passwordFormField = [[BAKFormField alloc] init];
        passwordFormField.labelText = @"Password";
        passwordFormField.labelWidth = 70;
        UITextField *textField = [passwordFormField setTextFieldAsContentView];
        textField.secureTextEntry = YES;
        passwordFormField.shouldShowSeparator = NO;
        self.passwordFormField = passwordFormField;
    }
    return _passwordFormField;
}

- (UITextField *)passwordField {
    return (UITextField *)self.passwordFormField.contentView;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        UIButton *actionButton = [BAKAuthenticationButton buttonWithType:UIButtonTypeSystem];
        [self.scrollView addSubview:actionButton];
        
        self.actionButton = actionButton;
    }
    return _actionButton;
}

- (UIButton *)forgotPasswordButton {
    if (!_forgotPasswordButton) {
        UIButton *forgotPasswordButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [forgotPasswordButton setTitle:@"Forgot Password?" forState:UIControlStateNormal];
        forgotPasswordButton.titleLabel.font = [UIFont systemFontOfSize:12];
        forgotPasswordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        forgotPasswordButton.clipsToBounds = YES;
        [self.scrollView addSubview:forgotPasswordButton];
        self.forgotPasswordButton = forgotPasswordButton;
    }
    return _forgotPasswordButton;
}

- (BAKLoadingView *)loadingView {
    if (!_loadingView) {
        BAKLoadingView *loadingView = [[BAKLoadingView alloc] init];
        loadingView.hidden = YES;
        [self addSubview:loadingView];
        self.loadingView = loadingView;
    }
    return _loadingView;
}

- (void)showLoadingView {
    self.loadingView.hidden = NO;
    [self.loadingView startAnimating];
}

- (void)hideLoadingView {
    self.loadingView.hidden = YES;
    [self.loadingView stopAnimating];
}

- (UILabel *)loadingViewLabel {
    return self.loadingView.label;
}

- (void)setLayoutInsets:(UIEdgeInsets)layoutInsets {
    if (!UIEdgeInsetsEqualToEdgeInsets(_layoutInsets, layoutInsets)) {
        _layoutInsets = layoutInsets;
        [self setNeedsLayout];
    }
}

- (void)setKeyboardHeight:(CGFloat)keyboardHeight {
    _keyboardHeight = keyboardHeight;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIEdgeInsets layoutInsets = self.layoutInsets;
    layoutInsets.bottom = MAX(layoutInsets.bottom, self.keyboardHeight);
    
    BAKAuthenticationFormLayout *layout = [[BAKAuthenticationFormLayout alloc] initWithWorkingRect:self.bounds layoutInsets:layoutInsets forgotPasswordHidden:self.forgotPasswordButton.hidden];
    
    self.scrollView.frame = layout.scrollViewRect;
    self.formGroup.frame = layout.formGroupRect;
    self.actionButton.frame = layout.actionButtonRect;
    self.forgotPasswordButton.frame = layout.forgotPasswordRect;
    self.loadingView.frame = layout.loadingRect;
}

@end
