//
//  BAKCreateMessageRequest.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/28/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKCreateMessageRequest.h"
#import "BAKDraft.h"
#import "BAKRemoteConfiguration.h"
#import "BAKMessageMetadata.h"

@implementation BAKCreateMessageRequest

- (instancetype)initWithThreadID:(NSString *)threadID draft:(BAKDraft *)draft configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _threadID = threadID;
    _draft = draft;
    _configuration = configuration;
    
    return self;
}

- (NSString *)method {
    return @"POST";
}

- (NSString *)path {
    return @"api/v1/messages";
}

- (NSDictionary *)parameters {
    return @{
             @"threadID": self.threadID,
             @"body": self.draft.body,
             @"attachmentIDs": self.draft.attachmentIDs,
             @"metadata": [[BAKMessageMetadata new] metadataDictionary],
             };
}

@end
