//
//  BAKChannelsRequest.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/24/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKRequestTemplate.h"
#import "BAKRemoteConfiguration.h"

@interface BAKChannelsRequest : NSObject <BAKRequestTemplate>

- (instancetype)initWithConfiguration:(BAKRemoteConfiguration *)configuration;

@property (readonly) BAKRemoteConfiguration *configuration;

@end
