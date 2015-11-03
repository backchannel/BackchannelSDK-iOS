//
//  BAKThreadCell.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/28/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKThreadCell.h"
#import "BAKGeometry.h"
#import "BAKThreadLayout.h"
#import "BAKColor.h"
#import "BAKColor.h"

@interface BAKThreadCell ()

@property (nonatomic) UIImageView *avatarImageView;
@property (nonatomic) UILabel *subjectLabel;
@property (nonatomic) UIImageView *chevronImageView;
@property (nonatomic) UILabel *authorLabel;
@property (nonatomic) UILabel *timeStampLabel;
@property (nonatomic) UILabel *messagePreviewLabel;

@end

@implementation BAKThreadCell

+ (CGFloat)heightForCell {
    return 115;
}

+ (CGFloat)totalHorizontalPaddingForMessageBodyLabel {
    return 44;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        UIImageView *avatarImageView = [[UIImageView alloc] init];
        avatarImageView.backgroundColor = [BAKColor imagePlaceholderColor];
        avatarImageView.clipsToBounds = YES;
        avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:avatarImageView];
        
        self.avatarImageView = avatarImageView;
    }
    return _avatarImageView;
}

- (UILabel *)subjectLabel {
    if (!_subjectLabel) {
        UILabel *subjectLabel = [[UILabel alloc] init];
		subjectLabel.textColor = [UIColor blackColor];
        subjectLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:subjectLabel];
        
        self.subjectLabel = subjectLabel;
    }
    return _subjectLabel;
}

- (UIImageView *)chevronImageView {
    if (!_chevronImageView) {
        UIImageView *chevronImageView = [[UIImageView alloc] init];
        chevronImageView.image = [[UIImage imageNamed:@"lilchevron"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        chevronImageView.tintColor = [BAKColor primaryTintColor];
        [self.contentView addSubview:chevronImageView];
        self.chevronImageView = chevronImageView;
    }
    return _chevronImageView;
}

- (UILabel *)authorLabel {
    if (!_authorLabel) {
        UILabel *authorLabel = [[UILabel alloc] init];
        authorLabel.textColor = [UIColor lightGrayColor];
        authorLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:authorLabel];
        
        self.authorLabel = authorLabel;
    }
    return _authorLabel;
}

- (UILabel *)timeStampLabel {
    if (!_timeStampLabel) {
        UILabel *timeStampLabel = [[UILabel alloc] init];
        timeStampLabel.textAlignment = NSTextAlignmentRight;
        timeStampLabel.textColor = [UIColor lightGrayColor];
        timeStampLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:timeStampLabel];
        
        self.timeStampLabel = timeStampLabel;
    }
    return _timeStampLabel;
}

- (UILabel *)messagePreviewLabel {
    if (!_messagePreviewLabel) {
        UILabel *messagePreviewLabel = [[UILabel alloc] init];
        messagePreviewLabel.numberOfLines = 3;
        messagePreviewLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:messagePreviewLabel];
        
        self.messagePreviewLabel = messagePreviewLabel;
    }
    return _messagePreviewLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    BAKThreadLayout *layout = [[BAKThreadLayout alloc] initWithWorkingRect:self.contentView.bounds chevronSize:self.chevronImageView.image.size messageHeight:self.messageBodySize.height];
    
    self.avatarImageView.frame = layout.avatarRect;
    self.avatarImageView.layer.cornerRadius = layout.avatarCornerRadius;
    self.subjectLabel.frame = layout.subjectRect;
    self.chevronImageView.frame = layout.chevronRect;
    self.authorLabel.frame = layout.authorRect;
    self.timeStampLabel.frame = layout.timeStampRect;
    self.messagePreviewLabel.frame = layout.messagePreviewRect;
}

@end
