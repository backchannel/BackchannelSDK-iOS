//
//  BAKCreateProfileCoordinator.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/22/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@class BAKUser, BAKCreateProfileCoordinator, BAKRemoteConfiguration;

@protocol BAKCreateProfileDelegate <NSObject>

- (void)createProfileCoordinator:(BAKCreateProfileCoordinator *)createProfileCoordinator didUpdateUser:(BAKUser *)user;
- (void)createProfileCoordinatorDidSkip:(BAKCreateProfileCoordinator *)createProfileCoordinator;

@end

@interface BAKCreateProfileCoordinator : NSObject

- (instancetype)initWithUser:(BAKUser *)user navigationController:(UINavigationController *)navigationController configuration:(BAKRemoteConfiguration *)configuration;

@property (readonly) BAKRemoteConfiguration *configuration;

@property (nonatomic, readonly) UINavigationController *navigationController;
@property (nonatomic, readonly) BAKUser *user;

@property (nonatomic, weak) id<BAKCreateProfileDelegate> delegate;

- (void)start;

@end
