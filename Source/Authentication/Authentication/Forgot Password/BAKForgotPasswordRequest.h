//
//  BAKForgotPasswordRequest.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAKRequestTemplate.h"
#import "BAKRemoteConfiguration.h"

@interface BAKForgotPasswordRequest : NSObject <BAKRequestTemplate>

- (instancetype)initWithEmail:(NSString *)email configuration:(BAKRemoteConfiguration *)configuration;

@property (nonatomic, readonly) NSString *email;
@property (readonly) BAKRemoteConfiguration *configuration;


@end
