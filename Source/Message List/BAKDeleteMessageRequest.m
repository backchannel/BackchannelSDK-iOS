//
//  BAKDeleteMessageRequest.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 10/25/15.
//  Copyright © 2015 Backchannel. All rights reserved.
//

#import "BAKDeleteMessageRequest.h"
#import "BAKMessage.h"

@implementation BAKDeleteMessageRequest

- (instancetype)initWithMessageID:(NSString *)messageID configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _messageID = messageID;
    _configuration = configuration;
    
    return self;
}

- (NSString *)method {
    return @"DELETE";
}

- (NSString *)path {
    return [NSString stringWithFormat:@"api/v1/messages/%@", self.messageID];
}

- (void)finalizeWithResponse:(id<BAKResponse>)response {
    response.result = [[BAKMessage alloc] initWithDictionary:response.result[@"message"]];
}

@end
