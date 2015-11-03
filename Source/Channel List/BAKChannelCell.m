//
//  BAKChannelCell.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/7/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKChannelCell.h"
#import "BAKChannelLayout.h"

@interface BAKChannelCell ()

@property (nonatomic) UIImageView *avatarImageView;
@property (nonatomic) UIImageView *chevronImageView;

@end

@implementation BAKChannelCell

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        UIImageView *avatarImageView = [[UIImageView alloc] init];
        avatarImageView.backgroundColor = [UIColor lightGrayColor];
        avatarImageView.clipsToBounds = YES;
        avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:avatarImageView];
        
        self.avatarImageView = avatarImageView;
    }
    return _avatarImageView;
}


- (UIImageView *)chevronImageView {
    if (!_chevronImageView) {
        UIImageView *chevronImageView = [[UIImageView alloc] init];
        chevronImageView.image = [[UIImage imageNamed:@"lilchevron"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        chevronImageView.tintColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        chevronImageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:chevronImageView];
        self.chevronImageView = chevronImageView;
    }
    return _chevronImageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    BAKChannelLayout *layout = [[BAKChannelLayout alloc] initWithWorkingRect:self.contentView.bounds];
    
    self.avatarImageView.frame = layout.imageRect;
    self.textLabel.frame = layout.textRect;
    self.chevronImageView.frame = layout.chevronRect;
    
    CGSize imageSize = layout.imageRect.size;
    CGFloat smallestDimension = MIN(imageSize.width, imageSize.height);
    CAShapeLayer *squircleLayer = [CAShapeLayer layer];
    CGRect rectangle = CGRectMake(0, 0, smallestDimension, smallestDimension);
    squircleLayer.path = [UIBezierPath bezierPathWithRoundedRect:rectangle cornerRadius:smallestDimension/4].CGPath;
    self.avatarImageView.layer.mask = squircleLayer;
}

@end
