//
//  BAKCreateThreadRequest.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/26/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKCreateThreadRequest.h"
#import "BAKAttachment.h"
#import "BAKDraft.h"
#import "BAKThread.h"

@implementation BAKCreateThreadRequest

- (instancetype)initWithChannelID:(NSString *)channelID draft:(BAKDraft *)draft configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _channelID = channelID;
    _draft = draft;
    _configuration = configuration;

    return self;
}

- (NSString *)method {
    return @"POST";
}

- (NSString *)path {
    return @"api/v1/threads";
}

- (NSDictionary *)parameters {
    return @{
             @"thread": self.threadParameters,
             };
}

- (NSDictionary *)threadParameters {
    return @{
             @"channelID": self.channelID,
             @"subject": self.draft.subject,
             @"message": self.messageParameters,
             };
}

- (NSDictionary *)messageParameters {
    return @{
             @"body": self.draft.body,
             @"attachmentIDs": self.draft.attachmentIDs,
             };
}

- (void)finalizeWithResponse:(id<BAKResponse>)response {
    if (!response.error) {
        response.result = [[BAKThread alloc] initWithDictionary:response.result[@"thread"]];
    }
}

@end
