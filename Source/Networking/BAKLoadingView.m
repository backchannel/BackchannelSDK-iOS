//
//  BAKLoadingView.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/6/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKLoadingView.h"
#import "BAKGeometry.h"

@interface BAKLoadingView ()

@property (nonatomic) UIActivityIndicatorView *activityIndicator;
@property (nonatomic) UIView *containerView;
@property (nonatomic) UILabel *label;

@end

@implementation BAKLoadingView

- (UIView *)containerView {
    if (!_containerView) {
        UIView *containerView = [[UIView alloc] init];
        containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
        containerView.layer.cornerRadius = 6.0f;
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}

- (UILabel *)label {
    if (!_label) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont boldSystemFontOfSize:14.0f];
        label.textColor = [UIColor colorWithWhite:1 alpha:0.9];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        self.label = label;
    }
    return _label;
}

- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self addSubview:activityIndicator];
        self.activityIndicator = activityIndicator;
    }
    return _activityIndicator;
}

- (void)startAnimating {
    return [self.activityIndicator startAnimating];
}

- (void)stopAnimating {
    return [self.activityIndicator stopAnimating];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self sendSubviewToBack:self.containerView];
    
    CGRect workingRect = self.bounds;
    
    CGRect containerRect = CGRectZero, activityIndicatorRect = CGRectZero, labelRect = CGRectZero, throwawayRect = CGRectZero;
    
    CGSize textSize = [self.label sizeThatFits:workingRect.size];
    
    CGFloat horizontalPadding = 10;
    CGFloat containerWidth = MAX(textSize.width, 100) + horizontalPadding*2;
    CGFloat containerHeight = 100 + textSize.height;
    
    CGSize containerSize = CGSizeMake(containerWidth, containerHeight);
    containerRect = BAKRectInsetToSize(workingRect, containerSize);
    CGRectDivide(containerRect, &labelRect, &throwawayRect, textSize.height, CGRectMaxYEdge);
    labelRect = CGRectOffset(labelRect, 0, -8);
    
    activityIndicatorRect = BAKRectInsetToSize(workingRect, CGSizeMake(60, 60));
    activityIndicatorRect = CGRectOffset(activityIndicatorRect, 0, -textSize.height/2);
    
    self.containerView.frame = containerRect;
    self.activityIndicator.frame = activityIndicatorRect;
    self.label.frame = labelRect;
}

@end
