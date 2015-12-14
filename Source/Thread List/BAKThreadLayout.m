//
//  BAKThreadLayout.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/2/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKThreadLayout.h"
#import "BAKGeometry.h"

@import UIKit;

@implementation BAKThreadLayout

- (instancetype)initWithWorkingRect:(CGRect)workingRect chevronSize:(CGSize)chevronSize messageHeight:(CGFloat)messageHeight {
    
    self = [super init];
    if (!self) return nil;
    
    CGRect metadataRect = CGRectZero, avatarRect = CGRectZero, subjectRect = CGRectZero, chevronRect = CGRectZero, authorRect = CGRectZero, timeStampRect = CGRectZero, messagePreviewRect = CGRectZero;
    
    workingRect = BAKRectTrim(workingRect, self.rightPadding, CGRectMaxXEdge);
	workingRect = BAKRectTrim(workingRect, self.leftPadding, CGRectMinXEdge);
	workingRect = BAKRectTrim(workingRect, self.bottomPadding, CGRectMaxYEdge);
	workingRect = BAKRectTrim(workingRect, self.topPadding, CGRectMinYEdge);
	
    CGRectDivide(workingRect, &metadataRect, &workingRect, self.metadataHeight, CGRectMinYEdge);
    CGRectDivide(metadataRect, &avatarRect, &metadataRect, self.avatarWidth, CGRectMinXEdge);
    avatarRect = CGRectInset(avatarRect, self.avatarPadding, self.avatarPadding);
    CGRectDivide(metadataRect, &subjectRect, &authorRect, metadataRect.size.height/2, CGRectMinYEdge);
    CGRectDivide(subjectRect, &chevronRect, &subjectRect, chevronSize.width, CGRectMaxXEdge);
	subjectRect = CGRectOffset(subjectRect, 2, 2);
	chevronRect.size = chevronSize;
    chevronRect = CGRectOffset(chevronRect, 0, self.chevronTopPadding);
    CGRectDivide(authorRect, &timeStampRect, &authorRect, self.timestampWidth, CGRectMaxXEdge);
	timeStampRect = CGRectOffset(timeStampRect, 0, 1);
	authorRect = CGRectOffset(authorRect, 2, -1);
	
    messagePreviewRect = BAKRectTrim(workingRect, self.messagePreviewLeftPadding, CGRectMinXEdge);
    messagePreviewRect.size.height = MIN(messageHeight, workingRect.size.height);
	messagePreviewRect = CGRectOffset(messagePreviewRect, 0, -2);
	
    _avatarRect = avatarRect;
    _avatarCornerRadius = avatarRect.size.height/2;
    _subjectRect = subjectRect;
    _chevronRect = chevronRect;
    _authorRect = authorRect;
    _timeStampRect = timeStampRect;
    _messagePreviewRect = messagePreviewRect;
    
    return self;
}


- (CGFloat)leftPadding {
	return 3;
}

- (CGFloat)rightPadding {
    return 9;
}

- (CGFloat)topPadding {
	return 3.5;
}

- (CGFloat)bottomPadding {
	return 7;
}

- (CGFloat)metadataHeight {
    return 44;
}

- (CGFloat)avatarWidth {
    return 44;
}

- (CGFloat)avatarPadding {
    return 6;
}

- (CGFloat)timestampWidth {
    return 70;
}

- (CGFloat)messagePreviewLeftPadding {
    return 47;
}

- (CGFloat)chevronTopPadding {
    return 8;
}

- (CGFloat)chevronLeftPadding {
    return 7;
}

- (CGFloat)totalHorizontalPaddingForMessageBodyLabel {
    return self.leftPadding + self.rightPadding + self.messagePreviewLeftPadding;
}

@end
