//
//  BAKProfileFormView.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/21/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAKProfileFormView : UIView

@property (nonatomic, readonly) UIButton *avatarButton;
@property (nonatomic, readonly) UIButton *avatarEditButton;
@property (readonly) UITextField *displayNameField;
@property (readonly) UITextField *bioField;
@property (nonatomic, readonly) UIButton *logoutButton;

@property (nonatomic) UIEdgeInsets layoutInsets;

- (void)showLoadingView;
- (void)hideLoadingView;

@end
