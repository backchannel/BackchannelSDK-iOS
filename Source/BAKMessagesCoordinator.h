//
//  BAKMessagesCoordinator.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/25/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@class BAKMessagesCoordinator, BAKRemoteConfiguration;

@protocol BAKMessageCoordinatorDelegate <NSObject>

- (void)messageCoordinatorRequestsDismissal:(BAKMessagesCoordinator *)messagesCoordinator;

@end

@interface BAKMessagesCoordinator : NSObject

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController configuration:(BAKRemoteConfiguration *)configuration;

@property (nonatomic, readonly) UINavigationController *navigationController;
@property (readonly) BAKRemoteConfiguration *configuration;

- (void)start;

@property (nonatomic, weak) id<BAKMessageCoordinatorDelegate> delegate;

@end
