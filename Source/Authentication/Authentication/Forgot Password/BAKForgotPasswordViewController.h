//
//  BAKForgotPasswordViewController.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAKForgotPasswordView.h"

@class BAKForgotPasswordViewController;

@protocol BAKForgotPasswordViewControllerDelegate <NSObject>

- (void)forgotPasswordViewController:(BAKForgotPasswordViewController *)forgotPasswordViewController didTapResetWithEmail:(NSString *)email;

@end

@interface BAKForgotPasswordViewController : UIViewController

- (instancetype)initWithEmail:(NSString *)email;

@property (nonatomic, readonly) NSString *email;

@property (nonatomic, weak) id<BAKForgotPasswordViewControllerDelegate> delegate;

@property (nonatomic) BAKForgotPasswordView *view;

@end
