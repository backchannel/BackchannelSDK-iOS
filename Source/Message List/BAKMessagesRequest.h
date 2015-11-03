//
//  BAKMessageRequest.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/25/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKRequestTemplate.h"
#import "BAKRemoteConfiguration.h"

@interface BAKMessagesRequest : NSObject <BAKRequestTemplate>

- (instancetype)initWithThreadID:(NSString *)threadID configuration:(BAKRemoteConfiguration *)configuration;

@property (nonatomic, readonly) NSString *threadID;
@property (readonly) BAKRemoteConfiguration *configuration;

@end
