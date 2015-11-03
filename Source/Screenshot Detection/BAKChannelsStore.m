//
//  BAKChannelsStore.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/13/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKChannelsStore.h"
#import <UIKit/UIKit.h>
#import "BAKCache.h"
#import "BAKSendableRequest.h"
#import "BAKChannelsRequest.h"

NSString *BAKChannelsStoreUpdatedNotification = @"BAKChannelsStoreUpdatedNotification";

@interface BAKChannelsStore ()

@property (nonatomic) BAKCache *cache;

@end

@implementation BAKChannelsStore

- (instancetype)initWithConfiguration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _configuration = configuration;
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    NSString *cacheName = [NSString stringWithFormat:@"io.backchannel.channelsForPicker.%@", bundleIdentifier];
    _cache = [[BAKCache alloc] initWithName:cacheName];
    _channels = (NSArray *)[self.cache fetchObject];
    
    return self;
}

- (void)setChannels:(NSArray *)channels {
    _channels = channels;
    [self.cache saveObject:self.channels];
    [[NSNotificationCenter defaultCenter] postNotificationName:BAKChannelsStoreUpdatedNotification object:self];
}

- (void)updateFromAPI {
    BAKChannelsRequest *channelsRequest = [[BAKChannelsRequest alloc] initWithConfiguration:self.configuration];
    BAKSendableRequest *sendableRequest = [[BAKSendableRequest alloc] initWithRequestTemplate:channelsRequest];
    [sendableRequest sendRequestWithSuccessBlock:^(id result) {
        self.channels = result;
    } failureBlock:nil];
}

@end
