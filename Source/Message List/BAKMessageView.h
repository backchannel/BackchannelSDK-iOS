//
//  BAKMessageView.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/10/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BAKAttachmentsView, BAKMessageLayout;

@interface BAKMessageView : UIView

@property (nonatomic, readonly) UIImageView *avatarImageView;
@property (nonatomic, readonly) UILabel *authorLabel;
@property (nonatomic, readonly) UILabel *timeStampLabel;
@property (nonatomic, readonly) UITextView *messageBodyTextView;
@property (nonatomic) UIView *attachmentsView;

@property (nonatomic) BOOL shouldShowAttachments;

@end
