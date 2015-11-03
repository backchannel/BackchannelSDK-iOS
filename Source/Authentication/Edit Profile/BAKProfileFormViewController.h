//
//  BAKProfileFormViewController.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/21/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAKProfileFormView.h"

@class BAKProfileFormViewController, BAKProfile;

@protocol BAKProfileFormViewControllerDelegate <NSObject>

- (void)profileViewControllerDidTapAvatarButton:(BAKProfileFormViewController *)profileViewController;

@end

@interface BAKProfileFormViewController : UIViewController

@property (nonatomic) BAKProfileFormView *view;

@property (readonly) BAKProfileFormView *profileForm;

@property (nonatomic, weak) id<BAKProfileFormViewControllerDelegate> delegate;

@property (nonatomic, readonly) BAKProfile *profile;

- (void)updateDisplayName:(NSString *)displayName;
- (void)updateAvatarButtonWithImage:(UIImage *)image;

@end
