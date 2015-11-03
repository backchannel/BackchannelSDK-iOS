//
//  BAKCurrentSessionRequest.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/11/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKCurrentSessionRequest.h"
#import "BAKRemoteConfiguration.h"
#import "BAKUser.h"

@implementation BAKCurrentSessionRequest

- (instancetype)initWithConfiguration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _configuration = configuration;
    
    return self;
}

- (NSString *)method {
    return @"GET";
}

- (NSString *)path {
    return @"api/v1/users/session";
}

- (void)finalizeWithResponse:(id<BAKResponse>)response {
    if (!response.error) {
        NSDictionary *userDictionary = [response.result valueForKeyPath:@"session.user"];
        response.result = [[BAKUser alloc] initWithDictionary:userDictionary];
    }
}

@end
