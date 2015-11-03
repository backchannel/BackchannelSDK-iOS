//
//  BAKMessageFormView.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/26/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAKLoadableView.h"

@interface BAKMessageFormView : UIView <BAKLoadableView>

- (void)setSubjectFieldAsDisabledWithText:(NSString *)text;

@property (nonatomic, readonly) UITextField *subjectField;
@property (nonatomic, readonly) UITextView *bodyField;
@property (nonatomic) UIView *attachmentsView;

@property (nonatomic, readonly) UIButton *paperclipButton;

@property (nonatomic) UITextField *channelField;

@property (nonatomic) UIEdgeInsets layoutInsets;
@property (nonatomic) BOOL shouldShowAttachmentsField;
@property (nonatomic) UIEdgeInsets originalTextContainerInset;

@property (nonatomic) BOOL shouldShowChannelPicker;

- (void)showLoadingView;
- (void)hideLoadingView;

@end
