//
//  BAKDeleteMessageRequest.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 10/25/15.
//  Copyright © 2015 Backchannel. All rights reserved.
//

#import "BAKRequestTemplate.h"
#import "BAKRemoteConfiguration.h"

@interface BAKDeleteMessageRequest : NSObject <BAKRequestTemplate>

- (instancetype)initWithMessageID:(NSString *)messageID configuration:(BAKRemoteConfiguration *)configuration;

@property (nonatomic, readonly) NSString *messageID;
@property (readonly) BAKRemoteConfiguration *configuration;

@end
