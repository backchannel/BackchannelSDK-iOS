//
//  BAKLoadingCell.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKLoadingCell.h"

@interface BAKLoadingCell ()

@property (nonatomic, strong, readwrite) UIActivityIndicatorView *activityIndicator;

@end

@implementation BAKLoadingCell

- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.contentView addSubview:_activityIndicator];
    }
    return _activityIndicator;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor clearColor];
    self.activityIndicator.center = self.contentView.center;
}


@end
