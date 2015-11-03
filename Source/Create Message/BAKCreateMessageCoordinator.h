//
//  BAKCreateMessageCoordinator.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/28/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@protocol BAKCreator;

@class BAKThread, BAKChannel, BAKCreateMessageCoordinator, BAKRemoteConfiguration, BAKChannelsStore;

@protocol BAKCreateMessageDelegate <NSObject>

- (void)createMessageCancelled:(BAKCreateMessageCoordinator *)createMessage;
- (void)createMessageCompleted:(BAKCreateMessageCoordinator *)createMessage;
- (void)createMessageCompleted:(BAKCreateMessageCoordinator *)createMessage onNewThread:(BAKThread *)thread;

@end

@interface BAKCreateMessageCoordinator : NSObject

- (instancetype)initWithChannelsStore:(BAKChannelsStore *)channelStore navigationController:(UINavigationController *)navigationController configuration:(BAKRemoteConfiguration *)configuration;

- (instancetype)initForNewThreadInChannel:(BAKChannel *)channel navigationController:(UINavigationController *)navigationController configuration:(BAKRemoteConfiguration *)configuration;

- (instancetype)initForExistingThread:(BAKThread *)thread navigationController:(UINavigationController *)navigationController configuration:(BAKRemoteConfiguration *)configuration;

@property (nonatomic, readonly) UINavigationController *navigationController;
@property (readonly) BAKRemoteConfiguration *configuration;

- (void)attachImageWithData:(NSData *)data placeholderImage:(UIImage *)placeholderImage;

- (void)start;

@property (nonatomic, weak) id<BAKCreateMessageDelegate> delegate;

@end
