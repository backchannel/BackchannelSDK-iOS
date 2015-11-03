//
//  BAKAuthenticatingCreateMessageCoordinator.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 10/8/15.
//  Copyright © 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BAKRemoteConfiguration, BAKThread, BAKChannel;

@import UIKit;

@class BAKAuthenticatingCreateMessageCoordinator;

@protocol BAKAuthenticatingCreateMessageCoordinatorDelegate <NSObject>

- (void)createMessageCancelled:(BAKAuthenticatingCreateMessageCoordinator *)createMessage;
- (void)createMessageCompleted:(BAKAuthenticatingCreateMessageCoordinator *)createMessage;
- (void)createMessageCompleted:(BAKAuthenticatingCreateMessageCoordinator *)createMessage onNewThread:(BAKThread *)thread;

@end

@interface BAKAuthenticatingCreateMessageCoordinator : NSObject

- (instancetype)initForNewThreadInChannel:(BAKChannel *)channel viewController:(UIViewController *)viewController configuration:(BAKRemoteConfiguration *)configuration;

- (instancetype)initForExistingThread:(BAKThread *)thread viewController:(UIViewController *)viewController configuration:(BAKRemoteConfiguration *)configuration;

@property (nonatomic, readonly) UIViewController *viewController;
@property (nonatomic, readonly) BAKRemoteConfiguration *configuration;

@property (nonatomic, weak) id<BAKAuthenticatingCreateMessageCoordinatorDelegate> delegate;

- (void)start;

@end
