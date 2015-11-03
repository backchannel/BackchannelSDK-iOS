//
//  BAKAuthenticationData.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKAuthenticationData.h"

@interface BAKAuthenticationData ()

@property (nonatomic) BAKAuthenticationType authenticationType;
@property (nonatomic) NSString *actionButtonTitle;
@property (nonatomic) NSString *loadingString;
@property (nonatomic) BOOL showForgotPassword;

@end

@implementation BAKAuthenticationData

+ (instancetype)signInData {
    BAKAuthenticationData *authenticationData = [BAKAuthenticationData new];
    authenticationData.authenticationType = BAKAuthenticationTypeSignIn;
    authenticationData.actionButtonTitle = @"Sign In";
    authenticationData.loadingString = @"Signing in...";
    authenticationData.showForgotPassword = YES;
    return authenticationData;
}

+ (instancetype)createAccountData {
    BAKAuthenticationData *authenticationData = [BAKAuthenticationData new];
    authenticationData.authenticationType = BAKAuthenticationTypeCreateAccount;
    authenticationData.actionButtonTitle = @"Create Account";
    authenticationData.loadingString = @"Creating account...";
    authenticationData.showForgotPassword = NO;
    return authenticationData;
}


@end

