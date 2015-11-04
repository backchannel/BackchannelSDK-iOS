//
//  BAKForgotPasswordRequest.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKForgotPasswordRequest.h"

@implementation BAKForgotPasswordRequest

- (instancetype)initWithEmail:(NSString *)email configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _email = email;
    _configuration = configuration;
    
    return self;
}

- (NSString *)method {
    return @"POST";
}

- (NSString *)path {
    return @"api/v1/users/reset_password";
}

- (NSDictionary *)parameters {
    return @{
             @"email": self.email,
             };
}

- (void)finalizeWithResponse:(id<BAKResponse>)response {
    
}

@end
