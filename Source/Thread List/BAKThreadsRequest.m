//
//  BAKThreadRequest.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/25/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKThreadsRequest.h"
#import "BAKThread.h"
#import "BAKMappedArray.h"

@implementation BAKThreadsRequest

- (instancetype)initWithChannelID:(NSString *)channelID configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _channelID = channelID;
    _configuration = configuration;

    return self;
}

- (NSString *)path {
    return @"api/v1/threads";
}

- (NSDictionary *)parameters {
    return @{
             @"channelID": self.channelID,
             };
}

- (void)finalizeWithResponse:(id<BAKResponse>)response {
    response.result = [[BAKMappedArray alloc] initWithArray:response.result[@"threads"] transformationBlock:^id(id object) {
        return [[BAKThread alloc] initWithDictionary:object];
    }];
}

@end
