//
//  BAKAuthViewController.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 1/9/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAKFirstRunView.h"

@class BAKFirstRunViewController;

@protocol BAKFirstRunViewControllerDelegate <NSObject>

- (void)firstRunViewControllerDidTapCreateAccount:(BAKFirstRunViewController *)firstRunViewController;
- (void)firstRunViewControllerDidTapSignIn:(BAKFirstRunViewController *)firstRunViewController;
- (void)firstRunViewControllerDidTapPostViaEmail:(BAKFirstRunViewController *)firstRunViewController;

@end

@interface BAKFirstRunViewController : UIViewController

- (instancetype)initWithEmailButtonShowing:(BOOL)emailButtonShowing;

@property (nonatomic) BAKFirstRunView *view;
@property (readonly) BAKFirstRunView *firstRunView;

@property (nonatomic) BOOL emailButtonShowing;

@property (nonatomic, weak) id<BAKFirstRunViewControllerDelegate> delegate;

@end
