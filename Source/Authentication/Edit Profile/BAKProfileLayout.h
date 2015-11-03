//
//  BAKProfileLayout.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface BAKProfileLayout : NSObject

- (instancetype)initWithWorkingRect:(CGRect)workingRect;

@property (nonatomic, readonly) CGRect scrollViewRect;
@property (nonatomic, readonly) CGSize contentSize;
@property (nonatomic, readonly) CGRect avatarRect;
@property (nonatomic, readonly) CGFloat avatarCornerRadius;
@property (nonatomic, readonly) CGRect avatarEditRect;
@property (nonatomic, readonly) CGRect formRect;
@property (nonatomic, readonly) CGRect logoutRect;
@property (nonatomic, readonly) CGRect loadingRect;

@end
