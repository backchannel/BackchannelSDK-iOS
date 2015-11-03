//
//  BAKCurrentSessionRequest.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/11/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAKRequestTemplate.h"
#import "BAKRemoteConfiguration.h"

@interface BAKCurrentSessionRequest : NSObject <BAKRequestTemplate>

- (instancetype)initWithConfiguration:(BAKRemoteConfiguration *)configuration;

@property (readonly) BAKRemoteConfiguration *configuration;

@end
