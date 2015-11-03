//
//  BAKScreenshotDetectionCoordinator.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/13/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@class BAKScreenshotDetectionCoordinator, BAKRemoteConfiguration;

@protocol BAKScreenshotDetectionDelegate <NSObject>

- (void)screenshotDetectionCoordinatorCompleted:(BAKScreenshotDetectionCoordinator *)coordinator;

@end

@interface BAKScreenshotDetectionCoordinator : NSObject

- (instancetype)initWithViewController:(UIViewController *)viewController configuration:(BAKRemoteConfiguration *)configuration;

@property (nonatomic, readonly) UIViewController *viewController;
@property (nonatomic, readonly) BAKRemoteConfiguration *configuration;

@property (nonatomic, weak) id<BAKScreenshotDetectionDelegate> delegate;

- (void)start;

@end
