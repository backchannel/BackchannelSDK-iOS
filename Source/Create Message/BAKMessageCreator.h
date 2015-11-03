//
//  BAKMessageCreator.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/6/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *BAKChannelWasModifiedNotification;
extern NSString *BAKThreadWasModifiedNotification;

@class BAKChannel, BAKThread, BAKDraft, BAKRemoteConfiguration;

@protocol BAKCreator <NSObject>

@property (nonatomic, readonly) BAKChannel *channel;
@property (nonatomic, readonly) BAKThread *thread;
@property (readonly) BAKRemoteConfiguration *configuration;

- (void)createWithDraft:(BAKDraft *)draft successBlock:(void (^)(id product))successBlock failureBlock:(void (^)(NSError *error))failureBlock;

@end

@interface BAKMessageCreator : NSObject <BAKCreator>

- (instancetype)initWithThread:(BAKThread *)thread configuration:(BAKRemoteConfiguration *)configuration;
@property (nonatomic, readonly) BAKThread *thread;
@property (readonly) BAKRemoteConfiguration *configuration;

@end

@interface BAKThreadCreator : NSObject <BAKCreator>

- (instancetype)initWithChannel:(BAKChannel *)channel configuration:(BAKRemoteConfiguration *)configuration;
@property (nonatomic, readonly) BAKChannel *channel;
@property (readonly) BAKRemoteConfiguration *configuration;

@end