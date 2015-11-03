//
//  BAKUpdateProfileRequest.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/22/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKUpdateProfileRequest.h"
#import "BAKProfile.h"
#import "BAKUser.h"

@implementation BAKUpdateProfileRequest

- (instancetype)initWithUserID:(NSString *)userID profile:(BAKProfile *)profile configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _userID = userID;
    _profile = profile;
    _configuration = configuration;
    
    return self;
}

- (NSString *)method {
    return @"PATCH";
}

- (NSString *)path {
    return [NSString stringWithFormat:@"api/v1/users/%@", self.userID];
}

- (NSDictionary *)parameters {
    return @{
             @"bio": self.profile.bio,
             @"displayName": self.profile.displayName,
             @"avatarAttachmentID": self.profile.avatarAttachmentID,
             };
}

- (void)finalizeWithResponse:(id<BAKResponse>)response {
    if (!response.error) {
        response.result = [[BAKUser alloc] initWithDictionary:response.result[@"user"]];
    }
}

@end
