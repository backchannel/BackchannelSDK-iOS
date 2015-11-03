//
//  BAKRequest.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/21/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKRemoteConfiguration.h"
#import "BAKSession.h"

@implementation BAKRemoteConfiguration

- (instancetype)initWithAPIKey:(NSString *)APIKey {
    self = [super init];
    if (!self) return nil;
    
    _APIKey = APIKey;
    
    return self;
}

- (NSURL *)baseURL {
    return [NSURL URLWithString:@"https://backchannel.io/"];
}

- (NSDictionary *)baseHeaders {
    return @{
             @"Accept": @"application/json",
             @"Content-Type": @"application/json",
             @"X-Auth-Token": [BAKSession currentSession].authToken,
             @"X-API-Key": self.APIKey,
             };
}

@end
