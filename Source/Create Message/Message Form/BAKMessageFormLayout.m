//
//  BAKMessageFormLayout.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/4/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKMessageFormLayout.h"
#import "BAKGeometry.h"

@interface BAKMessageFormLayout ()

@end

@implementation BAKMessageFormLayout

- (instancetype)initWithWorkingRect:(CGRect)workingRect layoutInsets:(UIEdgeInsets)layoutInsets originalTextContainerInset:(UIEdgeInsets)originalTextContainerInset shouldShowAttachmentsField:(BOOL)shouldShowAttachmentsField shouldShowChannelPicker:(BOOL)shouldShowChannelPicker {
    self = [super init];
    if (!self) return nil;
    
    _shouldShowAttachmentsField = shouldShowAttachmentsField;
    _shouldShowChannelPicker = shouldShowChannelPicker;
    
    CGRect loadingRect = workingRect, subjectRect = CGRectZero, bodyRect = CGRectZero, attachmentsRect = CGRectZero, channelsRect = CGRectZero;
    
    loadingRect = workingRect;
    bodyRect = workingRect;
    
    CGRectDivide(workingRect, &subjectRect, &workingRect, self.subjectHeight, CGRectMinYEdge);
    subjectRect = BAKRectTrim(subjectRect, self.leftMargin, CGRectMinXEdge);
    
    CGRectDivide(workingRect, &attachmentsRect, &workingRect, self.attachmentsHeight, CGRectMinYEdge);
    attachmentsRect = BAKRectTrim(attachmentsRect, self.leftMargin, CGRectMinXEdge);
    
    CGRectDivide(workingRect, &channelsRect, &workingRect, self.channelsHeight, CGRectMinYEdge);
    channelsRect = BAKRectTrim(channelsRect, self.leftMargin, CGRectMinXEdge);

    workingRect = CGRectOffset(workingRect, 0, -layoutInsets.top);
    
    UIEdgeInsets bodyInset = originalTextContainerInset;
    bodyInset.top += CGRectGetMaxY(channelsRect);
    bodyInset.left += self.leftTextInset;

    _loadingRect = loadingRect;
    _bodyRect = bodyRect;
    _bodyInset = bodyInset;
    _subjectRect = subjectRect;
    _attachmentsRect = attachmentsRect;
    _channelsRect = channelsRect;
    
    return self;
}

- (CGFloat)leftMargin {
    return 15;
}

- (CGFloat)leftTextInset {
    return 10;
}

- (CGFloat)subjectHeight {
    return 44;
}

- (CGFloat)channelsHeight {
    return self.shouldShowChannelPicker ? 44 : 0;
}

- (CGFloat)attachmentsHeight {
    return self.shouldShowAttachmentsField ? 44 : 0;
}

@end
