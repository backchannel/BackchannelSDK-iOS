//
//  BAKLogoutRequest.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 10/13/15.
//  Copyright © 2015 Backchannel. All rights reserved.
//

#import "BAKLogoutRequest.h"

@implementation BAKLogoutRequest

- (instancetype)initWithConfiguration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _configuration = configuration;
    
    return self;
}

- (NSString *)method {
    return @"POST";
}

- (NSString *)path {
    return @"api/v1/users/logout";
}

@end
