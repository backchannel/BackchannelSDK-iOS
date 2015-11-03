//
//  BAKChannelsRequest.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/24/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKChannelsRequest.h"
#import "BAKMappedArray.h"
#import "BAKChannel.h"

@implementation BAKChannelsRequest

- (instancetype)initWithConfiguration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _configuration = configuration;
    
    return self;
}

- (NSString *)path {
    return @"api/v1/channels";
}

- (void)finalizeWithResponse:(id<BAKResponse>)response {
    response.result = [[BAKMappedArray alloc] initWithArray:response.result[@"channels"] transformationBlock:^id(id object) {
        return [[BAKChannel alloc] initWithDictionary:object];
    }];
}

@end
