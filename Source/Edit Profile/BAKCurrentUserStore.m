//
//  BAKCurrentUserStore.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/11/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKCurrentUserStore.h"
#import "BAKUser.h"
#import "BAKCache.h"
#import "BAKSendableRequest.h"
#import "BAKCurrentSessionRequest.h"
#import "BAKAttachment.h"

@interface BAKCurrentUserStore ()

@property (nonatomic) BAKCache *cache;

@end

@implementation BAKCurrentUserStore

- (instancetype)initWithConfiguration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _configuration = configuration;
    _cache = [[BAKCache alloc] initWithName:@"io.backchannel.currentUser"];
    _currentUser = (BAKUser *)[self.cache fetchObject];
    [self fetchAvatar];
    
    return self;
}

- (void)setCurrentUser:(BAKUser *)currentUser {
    _currentUser = currentUser;
    [self fetchAvatar];
    [self.cache saveObject:self.currentUser];
}

- (void)fetchAvatar {
    [self.currentUser.avatar fetchImageWithSuccessBlock:nil failureBlock:nil];
}

- (void)updateFromAPI {
    BAKCurrentSessionRequest *currentSessionRequest = [[BAKCurrentSessionRequest alloc] initWithConfiguration:self.configuration];
    BAKSendableRequest *sendableRequest = [[BAKSendableRequest alloc] initWithRequestTemplate:currentSessionRequest];
    [sendableRequest sendRequestWithSuccessBlock:^(BAKUser *result) {
        self.currentUser = result;
    } failureBlock:nil];
}

@end
