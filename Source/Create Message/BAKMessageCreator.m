//
//  BAKMessageCreator.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/6/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKMessageCreator.h"
#import "BAKCreateMessageRequest.h"
#import "BAKCreateThreadRequest.h"
#import "BAKSendableRequest.h"
#import "BAKThread.h"
#import "BAKChannel.h"

NSString *BAKChannelWasModifiedNotification = @"BAKChannelWasModifiedNotification";
NSString *BAKThreadWasModifiedNotification = @"BAKThreadWasModifiedNotification";

@implementation BAKMessageCreator

- (instancetype)initWithThread:(BAKThread *)thread configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _thread = thread;
    _configuration = configuration;
    
    return self;
}

- (BAKChannel *)channel  {
    return nil;
}

- (void)createWithDraft:(BAKDraft *)draft successBlock:(void (^)(id product))successBlock failureBlock:(void (^)(NSError *error))failureBlock {
    BAKCreateMessageRequest *createMessageRequest = [[BAKCreateMessageRequest alloc] initWithThreadID:self.thread.ID draft:draft configuration:self.configuration];
    BAKSendableRequest *sendableRequest = [[BAKSendableRequest alloc] initWithRequestTemplate:createMessageRequest];
    [sendableRequest sendRequestWithSuccessBlock:^(id result) {
        [[NSNotificationCenter defaultCenter] postNotificationName:BAKThreadWasModifiedNotification object:self.thread];
        if (successBlock) {
            successBlock(result);
        }
    } failureBlock:failureBlock];
}

@end


@implementation BAKThreadCreator

- (instancetype)initWithChannel:(BAKChannel *)channel configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _channel = channel;
    _configuration = configuration;

    return self;
}

- (BAKThread *)thread  {
    return nil;
}

- (void)createWithDraft:(BAKDraft *)draft successBlock:(void (^)(id product))successBlock failureBlock:(void (^)(NSError *error))failureBlock {
    BAKCreateThreadRequest *createMessageRequest = [[BAKCreateThreadRequest alloc] initWithChannelID:self.channel.ID draft:draft configuration:self.configuration];
    BAKSendableRequest *sendableRequest = [[BAKSendableRequest alloc] initWithRequestTemplate:createMessageRequest];
    [sendableRequest sendRequestWithSuccessBlock:^(id result) {
        [[NSNotificationCenter defaultCenter] postNotificationName:BAKChannelWasModifiedNotification object:self.channel];
        if (successBlock) {
            successBlock(result);
        }
    } failureBlock:failureBlock];
}

@end

