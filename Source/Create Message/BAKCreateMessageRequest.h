//
//  BAKCreateMessageRequest.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/28/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKRequestTemplate.h"
#import "BAKRemoteConfiguration.h"

@class BAKDraft;

@interface BAKCreateMessageRequest : NSObject <BAKRequestTemplate>

- (instancetype)initWithThreadID:(NSString *)threadID draft:(BAKDraft *)draft configuration:(BAKRemoteConfiguration *)configuration;
;

@property (nonatomic, readonly) NSString *threadID;
@property (nonatomic, readonly) BAKDraft *draft;
@property (readonly) BAKRemoteConfiguration *configuration;

@end
