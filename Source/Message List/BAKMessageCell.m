//
//  BAKMessageCell.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/29/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKMessageCell.h"

@implementation BAKMessageCell

- (void)setHostedView:(UIView *)hostedView {
    if (self.hostedView.superview == self.contentView) {
        [self.hostedView removeFromSuperview];
    }
    _hostedView = hostedView;
    [self.contentView addSubview:self.hostedView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.hostedView.frame = self.contentView.bounds;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.hostedView = nil;
}

@end
