//
//  BAKAuthenticationFormLayout.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/28/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface BAKAuthenticationFormLayout : NSObject

- (instancetype)initWithWorkingRect:(CGRect)workingRect layoutInsets:(UIEdgeInsets)layoutInsets forgotPasswordHidden:(BOOL)forgotPasswordHidden;

@property (nonatomic, readonly) BOOL forgotPasswordHidden;

@property (nonatomic, readonly) CGRect scrollViewRect;
@property (nonatomic, readonly) CGRect formGroupRect;
@property (nonatomic, readonly) CGRect actionButtonRect;
@property (nonatomic, readonly) CGRect forgotPasswordRect;
@property (nonatomic, readonly) CGRect loadingRect;

@end
