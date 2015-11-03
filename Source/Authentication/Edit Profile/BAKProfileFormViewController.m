//
//  BAKProfileFormViewController.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/21/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKProfileFormViewController.h"
#import "BAKProfile.h"

@interface BAKProfileFormViewController () <UITextFieldDelegate>

@property (nonatomic) BAKProfile *profile;
@property (nonatomic) CGFloat currentKeyboardHeight;

@end

@implementation BAKProfileFormViewController

@dynamic view;

- (void)loadView {
    self.view = [[BAKProfileFormView alloc] init];
}

- (BAKProfileFormView *)profileForm {
    return self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.profile = [BAKProfile new];
    
    [self.profileForm.avatarButton addTarget:self action:@selector(informDelegateOfAvatarButtonTap) forControlEvents:UIControlEventTouchUpInside];
    [self.profileForm.avatarEditButton addTarget:self action:@selector(informDelegateOfAvatarButtonTap) forControlEvents:UIControlEventTouchUpInside];
    
    self.profileForm.displayNameField.delegate = self;
    self.profileForm.bioField.delegate = self;
    
    self.currentKeyboardHeight = 0;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppeared:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDisappeared:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)updateLayoutInsets {
    CGFloat bottomLayoutInset = MAX(self.currentKeyboardHeight, [self.bottomLayoutGuide length]);
    self.profileForm.layoutInsets = UIEdgeInsetsMake([self.topLayoutGuide length], 0, bottomLayoutInset, 0);
}

- (void)keyboardAppeared:(NSNotification *)note {
    CGRect keyboardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.currentKeyboardHeight = keyboardRect.size.height;
    [self updateLayoutInsets];
}

- (void)keyboardDisappeared:(NSNotification *)note {
    self.currentKeyboardHeight = 0;
    [self updateLayoutInsets];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.profileForm.displayNameField) {
        [self.profileForm.bioField becomeFirstResponder];
    }
    if (textField == self.profileForm.bioField) {
        [self.profileForm.bioField resignFirstResponder];
    }
    return NO;
}

- (void)informDelegateOfAvatarButtonTap {
    if ([self.delegate respondsToSelector:@selector(profileViewControllerDidTapAvatarButton:)]) {
        [self.delegate profileViewControllerDidTapAvatarButton:self];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self updateLayoutInsets];
}

- (void)updateAvatarButtonWithImage:(UIImage *)image {
    [self.profileForm.avatarButton setImage:image forState:UIControlStateNormal];
}

- (void)updateDisplayName:(NSString *)displayName {
    self.profileForm.displayNameField.text = displayName;
}

- (BAKProfile *)profile {
    _profile.displayName = self.profileForm.displayNameField.text;
    _profile.bio = self.profileForm.bioField.text;
    return _profile;
}

@end
