//
//  BAKUpdateProfileRequest.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/22/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKRequestTemplate.h"
#import "BAKRemoteConfiguration.h"

@class BAKProfile;

@interface BAKUpdateProfileRequest : NSObject <BAKRequestTemplate>

- (instancetype)initWithUserID:(NSString *)userID profile:(BAKProfile *)profile configuration:(BAKRemoteConfiguration *)configuration;

@property (nonatomic, readonly) NSString *userID;
@property (nonatomic, readonly) BAKProfile *profile;
@property (readonly) BAKRemoteConfiguration *configuration;

@end
