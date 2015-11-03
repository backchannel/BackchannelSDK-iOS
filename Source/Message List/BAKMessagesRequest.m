//
//  BAKMessageRequest.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/25/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKMessagesRequest.h"
#import "BAKMessage.h"
#import "BAKMappedArray.h"

@implementation BAKMessagesRequest

- (instancetype)initWithThreadID:(NSString *)threadID configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _threadID = threadID;
    _configuration = configuration;

    return self;
}

- (NSString *)path {
    return @"api/v1/messages";
}

- (NSDictionary *)parameters {
    return @{
             @"threadID": self.threadID,
             };
}

- (void)finalizeWithResponse:(id<BAKResponse>)response {
    response.result = [[BAKMappedArray alloc] initWithArray:response.result[@"messages"] transformationBlock:^id(id object) {
        return [[BAKMessage alloc] initWithDictionary:object];
    }];
}

@end
