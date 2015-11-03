//
//  BAKChooseImageCoordinator.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/4/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@class BAKChooseImageCoordinator;

@protocol BAKImageChooserDelegate <NSObject>

- (void)imageChooser:(BAKChooseImageCoordinator *)imageChooser didChooseImage:(UIImage *)image data:(NSData *)data;
- (void)imageChooserDidCancel:(BAKChooseImageCoordinator *)imageChooser;

@end

@interface BAKChooseImageCoordinator : NSObject

- (instancetype)initWithViewController:(UIViewController *)viewController;

@property (nonatomic, readonly) UIViewController *viewController;

- (void)start;

@property (nonatomic, weak) id<BAKImageChooserDelegate> delegate;

@end
