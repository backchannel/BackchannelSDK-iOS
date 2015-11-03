//
//  BAKCreateAccountRequest.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/22/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKCreateAccountRequest.h"
#import "BAKSession.h"

@implementation BAKCreateAccountRequest

- (instancetype)initWithEmail:(NSString *)email password:(NSString *)password configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!email || !password) {
        self = nil;
    }
    if (!self) return nil;
    
    _email = email;
    _password = password;
    _configuration = configuration;

    return self;
}

- (NSString *)method {
    return @"POST";
}

- (NSString *)path {
    return @"api/v1/users/signup";
}

- (NSDictionary *)parameters {
    return @{
             @"email": self.email,
             @"password": self.password,
             };
}

- (void)finalizeWithResponse:(id<BAKResponse>)response {
    if (!response.error) {
        response.result = [BAKSession openSessionWithDictionary:response.result[@"session"]];
    }
}

@end
