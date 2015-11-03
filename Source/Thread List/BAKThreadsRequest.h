//
//  BAKThreadRequest.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/25/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKRequestTemplate.h"
#import "BAKRemoteConfiguration.h"

@interface BAKThreadsRequest : NSObject <BAKRequestTemplate>

- (instancetype)initWithChannelID:(NSString *)channelID configuration:(BAKRemoteConfiguration *)configuration;

@property (nonatomic, readonly) NSString *channelID;

@property (readonly) BAKRemoteConfiguration *configuration;

@end
