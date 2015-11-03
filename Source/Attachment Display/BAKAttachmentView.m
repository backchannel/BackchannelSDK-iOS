//
//  BAKAttachmentView.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/28/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKAttachmentView.h"
#import "BAKGeometry.h"

@interface BAKAttachmentView () <UIScrollViewDelegate>

@property (nonatomic, readwrite) UIScrollView *scrollView;
@property (nonatomic, readwrite) UIImageView *attachmentImageView;
@property (nonatomic, readwrite) UIButton *removeButton;

@end

@implementation BAKAttachmentView

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.delegate = self;
        scrollView.bouncesZoom = YES;
        scrollView.minimumZoomScale = 1;
        scrollView.maximumZoomScale = 2;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
    }
    return _scrollView;
}

- (UIImageView *)attachmentImageView {
    if (!_attachmentImageView) {
        UIImageView *attachmentImageView = [[UIImageView alloc] init];
        attachmentImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:attachmentImageView];
        self.attachmentImageView = attachmentImageView;
    }
    return _attachmentImageView;
}

- (UIButton *)removeButton {
    if (!_removeButton) {
        UIButton *removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [removeButton setTitle:@"Remove" forState:UIControlStateNormal];
        removeButton.backgroundColor = [UIColor blackColor];
        removeButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [removeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        removeButton.layer.borderColor = [UIColor whiteColor].CGColor;
        removeButton.layer.borderWidth = 1;
        removeButton.hidden = YES;
        [self addSubview:removeButton];
        self.removeButton = removeButton;
    }
    return _removeButton;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.attachmentImageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect workingRect = self.bounds;
    
    CGRect scrollViewRect = CGRectZero;
    
    workingRect = BAKRectTrim(workingRect, self.layoutInsets.top, CGRectMinYEdge);
    workingRect = BAKRectTrim(workingRect, self.layoutInsets.bottom, CGRectMaxYEdge);
    
    scrollViewRect = workingRect;
    
    self.scrollView.frame = scrollViewRect;
    self.attachmentImageView.frame = self.scrollView.bounds;
    
    CGRect removeRect = self.bounds;
    removeRect = BAKRectInsetToSize(removeRect, CGSizeMake(100, 30));
    removeRect = CGRectOffset(removeRect, 0, 200);
    self.removeButton.frame = removeRect;
    self.removeButton.layer.cornerRadius = removeRect.size.height/2;
}

@end
