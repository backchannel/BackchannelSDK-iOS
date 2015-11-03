//
//  BAKAuthenticationViewController.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 1/9/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAKAuthenticationForm.h"

@class  BAKAuthenticationViewController, BAKAuthenticationData;

@protocol BAKAuthenticationViewControllerDelegate <NSObject>

- (void)authenticationViewController:(BAKAuthenticationViewController *)authenticationViewController didTapActionButtonWithEmail:(NSString *)email password:(NSString *)password;
- (void)authenticationViewController:(BAKAuthenticationViewController *)authenticationViewController didTapForgotPasswordButtonWithEmail:(NSString *)email;

@end


@interface BAKAuthenticationViewController : UIViewController

- (instancetype)initWithAuthenticationData:(BAKAuthenticationData *)data;

@property (nonatomic, readonly) BAKAuthenticationData *data;

@property (nonatomic, weak) id<BAKAuthenticationViewControllerDelegate> delegate;

@property (nonatomic) BAKAuthenticationForm *view;
@property (readonly) BAKAuthenticationForm *authenticationForm;

- (void)showKeyboard;

@end
