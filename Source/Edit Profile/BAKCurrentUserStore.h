//
//  BAKCurrentUserStore.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/11/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BAKUser, BAKRemoteConfiguration;

@interface BAKCurrentUserStore : NSObject

- (instancetype)initWithConfiguration:(BAKRemoteConfiguration *)configuration;

@property (nonatomic, readonly) BAKRemoteConfiguration *configuration;

@property (nonatomic) BAKUser *currentUser;

- (void)updateFromAPI;

@end
