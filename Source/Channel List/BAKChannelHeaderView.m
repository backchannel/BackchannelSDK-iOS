//
//  BAKChannelHeaderView.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/31/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKChannelHeaderView.h"
#import "BAKColor.h"
#import "BAKGeometry.h"

@interface BAKChannelHeaderView ()

@property (nonatomic) UIImageView *iconView;
@property (nonatomic) UILabel *nameLabel;

@end

@implementation BAKChannelHeaderView

- (UIImageView *)iconView {
    if (!_iconView) {
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:iconView];
        self.iconView = iconView;
    }
    return _iconView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
    }
    return _nameLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect workingRect = self.bounds;
    
    CGRect iconRect = CGRectZero, nameRect = CGRectZero;
    
    workingRect = CGRectInset(workingRect, 20, 20);
    CGRectDivide(workingRect, &iconRect, &nameRect, 80, CGRectMinYEdge);
    iconRect = CGRectInset(iconRect, 10, 10);
    
    CGFloat smallestDimension = MIN(iconRect.size.width, iconRect.size.height);
    iconRect = BAKRectInsetToSize(iconRect, CGSizeMake(smallestDimension, smallestDimension));
    
    self.iconView.frame = iconRect;
    self.nameLabel.frame = nameRect;
    
    CAShapeLayer *squircleLayer = [CAShapeLayer layer];
    CGRect rectangle = CGRectMake(0, 0, smallestDimension, smallestDimension);
    squircleLayer.path = [UIBezierPath bezierPathWithRoundedRect:rectangle cornerRadius:smallestDimension/4].CGPath;
    self.iconView.layer.mask = squircleLayer;
}

@end
