//
//  BAKForgotPasswordView.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKForgotPasswordView.h"
#import "BAKFormField.h"
#import "BAKFormGroup.h"
#import "BAKAuthenticationButton.h"
#import "BAKColor.h"
#import "BAKGeometry.h"

@interface BAKForgotPasswordView ()

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIButton *resetButton;
@property (nonatomic) BAKFormGroup *formGroup;
@property (nonatomic) BAKFormField *emailFormField;

@end

@implementation BAKForgotPasswordView

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.alwaysBounceVertical = YES;
        scrollView.backgroundColor = [BAKColor grayBackgroundColor];
        [self addSubview:scrollView];
        
        self.scrollView = scrollView;
    }
    return _scrollView;
}

- (UIButton *)resetButton {
    if (!_resetButton) {
        UIButton *resetButton = [BAKAuthenticationButton buttonWithType:UIButtonTypeSystem];
        [resetButton setTitle:@"Send Reset Email" forState:UIControlStateNormal];
        self.resetButton = resetButton;
        [self.scrollView addSubview:resetButton];
    }
    return _resetButton;
}

- (BAKFormGroup *)formGroup {
    if (!_formGroup) {
        BAKFormGroup *formGroup = [[BAKFormGroup alloc] init];
        [formGroup addFormField:self.emailFormField];
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
        emailFormField.shouldShowSeparator = NO;
        self.emailFormField = emailFormField;
    }
    return _emailFormField;
}

- (UITextField *)emailField {
    return (UITextField *)self.emailFormField.contentView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect workingRect = self.bounds;
    
    CGRect scrollViewRect = CGRectZero, formRect = CGRectZero, resetRect = CGRectZero;
    
    scrollViewRect = workingRect;
    
    workingRect = BAKRectTrim(workingRect, 20, CGRectMinYEdge);
    CGRectDivide(workingRect, &formRect, &workingRect, 44, CGRectMinYEdge);

    workingRect = BAKRectTrim(workingRect, 40, CGRectMinYEdge);
    CGRectDivide(workingRect, &resetRect, &workingRect, 44, CGRectMinYEdge);

    self.scrollView.frame = scrollViewRect;
    self.formGroup.frame = formRect;
    self.resetButton.frame = resetRect;
}


@end
