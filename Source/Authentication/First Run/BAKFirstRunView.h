//
//  BAKFirstRunView.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAKFirstRunView : UIView

- (instancetype)initWithEmailButtonShowing:(BOOL)emailButtonShowing;

@property (nonatomic, readonly) BOOL emailButtonShowing;

@property (nonatomic, readonly) UIButton *createAccountButton;
@property (nonatomic, readonly) UIButton *signInButton;
@property (nonatomic, readonly) UIButton *postViaEmailButton;

@end
