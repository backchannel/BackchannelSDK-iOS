//
//  BAKNewAttachmentCell.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/6/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKAttachmentButtonCell.h"
#import "BAKColor.h"

@interface BAKAttachmentButtonCell ()

@property (nonatomic) UIImageView *plusImage;

@end

@implementation BAKAttachmentButtonCell

- (UIImageView *)plusImage {
    if (!_plusImage) {
        UIImage *image = [[UIImage imageNamed:@"attachment-add"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *plusImage = [[UIImageView alloc] initWithImage:image];
        plusImage.tintColor = [BAKColor primaryTintColor];
        [self.contentView addSubview:plusImage];
        self.plusImage = plusImage;
    }
    return _plusImage;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.plusImage.frame = self.bounds;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self configureImageViewAlpha];
}

- (void)configureImageViewAlpha {
    self.plusImage.alpha = self.highlighted ? 0.5 : 1;
}

@end
