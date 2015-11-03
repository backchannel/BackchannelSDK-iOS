//
//  BAKAuthenticationForm.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 1/20/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAKLoadableView.h"

@interface BAKAuthenticationForm : UIView <BAKLoadableView>

@property (nonatomic, readonly) UIScrollView *scrollView;

@property (readonly) UITextField *emailField;
@property (readonly) UITextField *passwordField;

@property (nonatomic, readonly) UIButton *actionButton;

@property (nonatomic, readonly) UIButton *forgotPasswordButton;

@property (nonatomic) CGFloat keyboardHeight;
@property (nonatomic) UIEdgeInsets layoutInsets;

- (void)showLoadingView;
- (void)hideLoadingView;

@property (readonly) UILabel *loadingViewLabel;


@end
