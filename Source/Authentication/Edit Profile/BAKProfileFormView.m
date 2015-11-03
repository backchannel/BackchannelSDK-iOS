//
//  BAKProfileFormView.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/21/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKProfileFormView.h"
#import "BAKFormGroup.h"
#import "BAKFormField.h"
#import "BAKGeometry.h"
#import "BAKProfileLayout.h"
#import "BAKColor.h"
#import "BAKLoadingView.h"
#import "BAKAuthenticationButton.h"
#import "BAKColor.h"

@interface BAKProfileFormView ()

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIButton *avatarButton;
@property (nonatomic) UIButton *avatarEditButton;
@property (nonatomic) BAKFormGroup *formGroup;
@property (nonatomic) BAKFormField *displayNameFormField;
@property (nonatomic) BAKFormField *bioFormField;
@property (nonatomic) UIButton *logoutButton;
@property (nonatomic) BAKLoadingView *loadingView;

@end

@implementation BAKProfileFormView

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [BAKColor grayBackgroundColor];
        scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        scrollView.alwaysBounceVertical = YES;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
    }
    return _scrollView;
}

- (UIButton *)avatarButton {
    if (!_avatarButton) {
        UIButton *avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        avatarButton.backgroundColor = [BAKColor imagePlaceholderColor];
        avatarButton.clipsToBounds = YES;
        avatarButton.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollView addSubview:avatarButton];
        self.avatarButton = avatarButton;
    }
    return _avatarButton;
}

- (UIButton *)avatarEditButton {
    if (!_avatarEditButton) {
        UIButton *avatarEditButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [avatarEditButton setTitle:@"edit" forState:UIControlStateNormal];
        avatarEditButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [self.scrollView addSubview:avatarEditButton];
        self.avatarEditButton = avatarEditButton;
    }
    return _avatarEditButton;
}

- (BAKFormGroup *)formGroup {
    if (!_formGroup) {
        BAKFormGroup *formGroup = [[BAKFormGroup alloc] init];
        [formGroup addFormField:self.displayNameFormField];
        [formGroup addFormField:self.bioFormField];
        [self.scrollView addSubview:formGroup];
        self.formGroup = formGroup;
    }
    return _formGroup;
}

- (BAKFormField *)displayNameFormField {
    if (!_displayNameFormField) {
        BAKFormField *displayNameFormField = [[BAKFormField alloc] init];
        displayNameFormField.labelText = @"Name";
        displayNameFormField.labelWidth = 50;
        UITextField *displayNameField = [displayNameFormField setTextFieldAsContentView];
        displayNameField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        displayNameField.returnKeyType = UIReturnKeyNext;
        self.displayNameFormField = displayNameFormField;
    }
    return _displayNameFormField;
}

- (UITextField *)displayNameField {
    return (UITextField *)self.displayNameFormField.contentView;
}

- (BAKFormField *)bioFormField {
    if (!_bioFormField) {
        BAKFormField *bioFormField = [[BAKFormField alloc] init];
        bioFormField.labelText = @"Bio";
        bioFormField.labelWidth = 50;
        UITextField *bioField = [bioFormField setTextFieldAsContentView];
        bioField.returnKeyType = UIReturnKeyDone;
        bioField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        bioFormField.shouldShowSeparator = NO;
        self.bioFormField = bioFormField;
    }
    return _bioFormField;
}

- (UITextField *)bioField {
    return (UITextField *)self.bioFormField.contentView;
}

- (UIButton *)logoutButton {
    if (!_logoutButton) {
        BAKAuthenticationButton *logoutButton = [BAKAuthenticationButton buttonWithType:UIButtonTypeSystem];
        [logoutButton setTitleColor:[BAKColor logoutColor] forState:UIControlStateNormal];
        [logoutButton setTitle:@"Sign Out" forState:UIControlStateNormal];
        logoutButton.hidden = YES;
        [self.scrollView addSubview:logoutButton];
        self.logoutButton = logoutButton;
    }
    return _logoutButton;
}

- (BAKLoadingView *)loadingView {
    if (!_loadingView) {
        BAKLoadingView *loadingView = [[BAKLoadingView alloc] init];
        loadingView.hidden = YES;
        loadingView.label.text = @"Saving...";
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

- (void)setLayoutInsets:(UIEdgeInsets)layoutInsets {
    _layoutInsets = layoutInsets;
    self.scrollView.contentInset = self.layoutInsets;
    self.scrollView.scrollIndicatorInsets = self.layoutInsets;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    BAKProfileLayout *layout = [[BAKProfileLayout alloc] initWithWorkingRect:self.bounds];
    
    self.scrollView.frame = layout.scrollViewRect;
    self.scrollView.contentSize = layout.contentSize;
    self.avatarButton.frame = layout.avatarRect;
    self.avatarButton.layer.cornerRadius = layout.avatarCornerRadius;
    self.avatarEditButton.frame = layout.avatarEditRect;
    self.formGroup.frame = layout.formRect;
    self.logoutButton.frame = layout.logoutRect;
    self.loadingView.frame = layout.loadingRect;
}

@end
