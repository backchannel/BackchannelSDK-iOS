//
//  BAKAttachmentCell.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/5/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKAttachmentCell.h"

@interface BAKAttachmentCell ()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIActivityIndicatorView *activityIndicator;
@property (nonatomic) UIView *errorView;

@end

@implementation BAKAttachmentCell

- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        imageView.layer.borderWidth = 1.0f/[UIScreen mainScreen].scale;
        [self.contentView addSubview:imageView];
        
        self.imageView = imageView;
    }
    return _imageView;
}

- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.contentView addSubview:activityIndicator];
        activityIndicator.hidesWhenStopped = YES;
        [activityIndicator sizeToFit];
        self.activityIndicator = activityIndicator;
    }
    return _activityIndicator;
}

- (UIView *)errorView {
    if (!_errorView) {
        UILabel *errorView = [[UILabel alloc] init];
        errorView.text = @"!";
        errorView.font = [UIFont boldSystemFontOfSize:16.0f];
        errorView.textAlignment = NSTextAlignmentCenter;
        errorView.backgroundColor = [UIColor redColor];
        errorView.textColor = [UIColor whiteColor];
        errorView.clipsToBounds = YES;
        [self addSubview:errorView];
        self.errorView = errorView;
    }
    return _errorView;
}

- (void)updateWithImage:(UIImage *)image {
    self.imageView.layer.borderWidth = image ? 0 : 1.0f/[UIScreen mainScreen].scale;
    self.imageView.image = image;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    self.activityIndicator.center = self.imageView.center;
    self.errorView.frame = CGRectInset(self.bounds, 5, 5);
    self.errorView.layer.cornerRadius = self.errorView.frame.size.height/2;
}

- (void)fadeImageToOpaque {
    [UIView animateWithDuration:0.3 animations:^{
        self.imageTranslucent = NO;
    }];
}

- (void)setLoadingIndicatorAnimating:(BOOL)loadingIndicatorAnimating {
    if (loadingIndicatorAnimating) {
        [self.activityIndicator startAnimating];
    } else {
        [self.activityIndicator stopAnimating];
    }
}

- (BOOL)loadingIndicatorAnimating {
    return self.activityIndicator.isAnimating;
}

- (BOOL)errorViewVisible {
    return !self.errorView.hidden;
}

- (void)setErrorViewVisible:(BOOL)errorViewVisible {
    self.errorView.hidden = !errorViewVisible;
}

- (BOOL)imageTranslucent {
    return self.imageView.alpha < 0.75;
}

- (void)setImageTranslucent:(BOOL)imageTranslucent {
    self.imageView.alpha = imageTranslucent ? 0.5 : 1;
}

@end
