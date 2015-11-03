//
//  BAKLogoutRequest.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 10/13/15.
//  Copyright © 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAKRequestTemplate.h"
#import "BAKRemoteConfiguration.h"

@interface BAKLogoutRequest : NSObject <BAKRequestTemplate>

- (instancetype)initWithConfiguration:(BAKRemoteConfiguration *)configuration;

@property (readonly) BAKRemoteConfiguration *configuration;

@end

