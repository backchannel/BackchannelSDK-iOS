//
//  BAKMessageFormLayout.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/4/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreGraphics;
@import UIKit;

@interface BAKMessageFormLayout : NSObject

- (instancetype)initWithWorkingRect:(CGRect)workingRect layoutInsets:(UIEdgeInsets) layoutInsets originalTextContainerInset:(UIEdgeInsets)originalTextContainerInset shouldShowAttachmentsField:(BOOL)shouldShowAttachmentsField shouldShowChannelPicker:(BOOL)shouldShowChannelPicker;

@property (nonatomic, readonly) BOOL shouldShowAttachmentsField;
@property (nonatomic, readonly) BOOL shouldShowChannelPicker;

@property (nonatomic, readonly) CGRect loadingRect;
@property (nonatomic, readonly) CGRect bodyRect;
@property (nonatomic, readonly) UIEdgeInsets bodyInset;
@property (nonatomic, readonly) CGRect subjectRect;
@property (nonatomic, readonly) CGRect attachmentsRect;
@property (nonatomic, readonly) CGRect channelsRect;

@end
