//
//  BAKCurrentUserStore.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/11/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BAKUser, BAKRemoteConfiguration, BAKCurrentUserStore;

@protocol BAKCurrentUserStoreDelegate <NSObject>

- (void)currentUserStoreFailedToValidateAuthToken:(BAKCurrentUserStore *)currentUserStore;

@end

@interface BAKCurrentUserStore : NSObject

- (instancetype)initWithConfiguration:(BAKRemoteConfiguration *)configuration;

@property (nonatomic, readonly) BAKRemoteConfiguration *configuration;

@property (nonatomic) BAKUser *currentUser;

@property (nonatomic, weak) id<BAKCurrentUserStoreDelegate> delegate;

- (void)updateFromAPI;

@end
