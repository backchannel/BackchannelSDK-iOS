//
//  BAKCreateThreadRequest.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/26/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKRequestTemplate.h"
#import "BAKRemoteConfiguration.h"

@class BAKDraft;

@interface BAKCreateThreadRequest : NSObject <BAKRequestTemplate>

- (instancetype)initWithChannelID:(NSString *)channelID draft:(BAKDraft *)draft configuration:(BAKRemoteConfiguration *)configuration;

@property (nonatomic, readonly) NSString *channelID;
@property (nonatomic, readonly) BAKDraft *draft;
@property (readonly) BAKRemoteConfiguration *configuration;

@end
