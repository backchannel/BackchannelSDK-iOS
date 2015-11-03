//
//  BAKEditProfileCoordinator.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/7/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@class BAKUser, BAKEditProfileCoordinator, BAKRemoteConfiguration, BAKCurrentUserStore;

@protocol BAKEditProfileDelegate <NSObject>

- (void)editProfileCoordinator:(BAKEditProfileCoordinator *)editProfileCoordinator didUpdateUser:(BAKUser *)user;
- (void)editProfileCoordinatorDidCancel:(BAKEditProfileCoordinator *)editProfileCoordinator;
- (void)editProfileCoordinatorRequestLogOut:(BAKEditProfileCoordinator *)editProfileCoordinator;

@end


@interface BAKEditProfileCoordinator : NSObject

- (instancetype)initWithViewController:(UIViewController *)viewController currentUserStore:(BAKCurrentUserStore *)currentUserStore configuration:(BAKRemoteConfiguration *)configuration;

@property (readonly) BAKRemoteConfiguration *configuration;
@property (readonly) BAKCurrentUserStore *currentUserStore;
@property (nonatomic, readonly) UIViewController *viewController;
@property (nonatomic, weak) id<BAKEditProfileDelegate> delegate;

- (void)start;

@end
