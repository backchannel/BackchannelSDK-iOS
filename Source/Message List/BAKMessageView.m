//
//  BAKMessageView.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/10/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKMessageView.h"
#import "BAKMessageLayout.h"
#import "BAKColor.h"

@interface BAKMessageView ()

@property (nonatomic) UIImageView *avatarImageView;
@property (nonatomic) UILabel *authorLabel;
@property (nonatomic) UILabel *timeStampLabel;
@property (nonatomic) UITextView *messageBodyTextView;

@end

@implementation BAKMessageView

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        UIImageView *avatarImageView = [[UIImageView alloc] init];
        avatarImageView.backgroundColor = [BAKColor imagePlaceholderColor];
        avatarImageView.clipsToBounds = YES;
		avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:avatarImageView];
        
        self.avatarImageView = avatarImageView;
    }
    return _avatarImageView;
}

- (UILabel *)authorLabel {
    if (!_authorLabel) {
        UILabel *authorLabel = [[UILabel alloc] init];
        authorLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        [self addSubview:authorLabel];
        
        self.authorLabel = authorLabel;
    }
    return _authorLabel;
}

- (UILabel *)timeStampLabel {
    if (!_timeStampLabel) {
        UILabel *timeStampLabel = [[UILabel alloc] init];
        timeStampLabel.textAlignment = NSTextAlignmentRight;
        timeStampLabel.textColor = [UIColor lightGrayColor];
        timeStampLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        [self addSubview:timeStampLabel];
        
        self.timeStampLabel = timeStampLabel;
    }
    return _timeStampLabel;
}

- (UITextView *)messageBodyTextView {
    if (!_messageBodyTextView) {
        UITextView *messageBodyTextView = [[UITextView alloc] init];
        messageBodyTextView.textContainerInset = UIEdgeInsetsZero;
        messageBodyTextView.dataDetectorTypes = UIDataDetectorTypeLink;
        messageBodyTextView.textContainer.lineFragmentPadding = 0;
        messageBodyTextView.editable = NO;
        messageBodyTextView.scrollEnabled = NO;
        [self addSubview:messageBodyTextView];
        
        self.messageBodyTextView = messageBodyTextView;
    }
    return _messageBodyTextView;
}

- (void)setAttachmentsView:(UIView *)attachmentsView {
    [self.attachmentsView removeFromSuperview];
    _attachmentsView = attachmentsView;
    [self addSubview:_attachmentsView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    BAKMessageLayout *layout = [[BAKMessageLayout alloc] initWithWorkingRect:self.bounds showAttachments:self.shouldShowAttachments];
    
    self.avatarImageView.frame = layout.avatarRect;
    self.avatarImageView.layer.cornerRadius = layout.avatarRadius;
    self.authorLabel.frame = layout.authorRect;
    self.timeStampLabel.frame = layout.timeStampRect;
    self.messageBodyTextView.frame = layout.messageBodyRect;
    self.attachmentsView.frame = layout.attachmentsRect;
}

@end
