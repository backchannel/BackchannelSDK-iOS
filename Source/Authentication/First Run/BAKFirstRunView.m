//
//  BAKFirstRunView.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKFirstRunView.h"
#import "BAKFirstRunLayout.h"
#import "BAKAuthenticationButton.h"
#import "BAKColor.h"

@interface BAKFirstRunView ()

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIButton *createAccountButton;
@property (nonatomic) UIButton *signInButton;
@property (nonatomic) UIImageView *backchannelImageView;
@property (nonatomic) UILabel *descriptionLabel;

@end

@implementation BAKFirstRunView

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

- (UIImageView *)backchannelImageView {
    if (!_backchannelImageView) {
        UIImageView *backchannelImageView = [[UIImageView alloc] init];
        backchannelImageView.image = [UIImage imageNamed:@"logo"];
        backchannelImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:backchannelImageView];
        self.backchannelImageView = backchannelImageView;
    }
    return _backchannelImageView;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        UILabel *descriptionLabel = [[UILabel alloc] init];
        descriptionLabel.text = @"Sign in or create an account to join the conversation.";
        descriptionLabel.font = [UIFont systemFontOfSize:16];
        descriptionLabel.numberOfLines = 0;
        [self.scrollView addSubview:descriptionLabel];
        self.descriptionLabel = descriptionLabel;
    }
    return _descriptionLabel;
}

- (UIButton *)createAccountButton {
    if (!_createAccountButton) {
        UIButton *createAccountButton = [BAKAuthenticationButton buttonWithType:UIButtonTypeSystem];
        [createAccountButton setTitle:@"Create Account" forState:UIControlStateNormal];
        [self.scrollView addSubview:createAccountButton];
        self.createAccountButton = createAccountButton;
    }
    return _createAccountButton;
}

- (UIButton *)signInButton {
    if (!_signInButton) {
        UIButton *signInButton = [BAKAuthenticationButton buttonWithType:UIButtonTypeSystem];
        [signInButton setTitle:@"Sign In" forState:UIControlStateNormal];
        [self.scrollView addSubview:signInButton];
        self.signInButton = signInButton;
    }
    return _signInButton;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    BAKFirstRunLayout *layout = [[BAKFirstRunLayout alloc] initWithWorkingRect:self.bounds];
    
    self.scrollView.frame = layout.scrollRect;
    self.backchannelImageView.frame = layout.backchannelRect;
    self.descriptionLabel.frame = layout.descriptionRect;
    self.createAccountButton.frame = layout.createAccountRect;
    self.signInButton.frame = layout.signInRect;
}

@end
