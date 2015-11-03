//
//  BAKChannelsStore.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/13/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKChannelsStore.h"
#import <Foundation/Foundation.h>

extern NSString *BAKChannelsStoreUpdatedNotification;

@class BAKRemoteConfiguration;

@interface BAKChannelsStore : NSObject

- (instancetype)initWithConfiguration:(BAKRemoteConfiguration *)configuration;

@property (nonatomic, readonly) BAKRemoteConfiguration *configuration;

@property (nonatomic) NSArray *channels;

- (void)updateFromAPI;

@end

