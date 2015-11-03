//
//  BAKAuthenticationData.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BAKAuthenticationType) {
    BAKAuthenticationTypeSignIn,
    BAKAuthenticationTypeCreateAccount,
};


@interface BAKAuthenticationData : NSObject

+ (instancetype)signInData;
+ (instancetype)createAccountData;

@property (nonatomic, readonly) BAKAuthenticationType authenticationType;
@property (nonatomic, readonly) NSString *actionButtonTitle;
@property (nonatomic, readonly) NSString *loadingString;
@property (nonatomic, readonly) BOOL showForgotPassword;

@end
