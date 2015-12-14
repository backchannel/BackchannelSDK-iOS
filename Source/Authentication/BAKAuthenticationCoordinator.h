//
//  BAKAuthenticationController.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/17/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

extern NSString *BAKAuthenticationCoordinatorDidLogUserIn;

@class BAKAuthenticationCoordinator, BAKSession, BAKRemoteConfiguration;

@protocol BAKAuthenticationDelegate <NSObject>

- (void)coordinatorDidAuthenticate:(BAKAuthenticationCoordinator *)coordinator;
- (void)coordinatorDidRequestDismissal:(BAKAuthenticationCoordinator *)coordinator;

@end

@interface BAKAuthenticationCoordinator : NSObject

- (instancetype)initWithNavigationViewController:(UINavigationController *)navigationController configuration:(BAKRemoteConfiguration *)configuration;

@property (readonly) BAKRemoteConfiguration *configuration;

@property (nonatomic, readonly) UINavigationController *navigationController;

@property (nonatomic, weak) id<BAKAuthenticationDelegate> delegate;

- (void)start;

@end
