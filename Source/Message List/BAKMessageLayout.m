//
//  BAKMessageLayout.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKMessageLayout.h"
#import "BAKGeometry.h"

@implementation BAKMessageLayout

- (instancetype)initWithWorkingRect:(CGRect)workingRect showAttachments:(BOOL)showAttachments {
    self = [super init];
    if (!self) return nil;
    
    CGRect avatarRect = CGRectZero, authorRect = CGRectZero, timeStampRect = CGRectZero, messageBodyRect = CGRectZero, attachmentsRect = CGRectZero;
    
    workingRect = BAKRectTrim(workingRect, self.topPadding, CGRectMinYEdge);
    workingRect = BAKRectTrim(workingRect, self.rightPadding, CGRectMaxXEdge);
    workingRect = BAKRectTrim(workingRect, self.leftPadding, CGRectMinXEdge);
    workingRect = BAKRectTrim(workingRect, self.bottomPadding, CGRectMaxYEdge);
    
    CGRectDivide(workingRect, &authorRect, &workingRect, self.metadataHeight, CGRectMinYEdge);
    CGRectDivide(authorRect, &avatarRect, &authorRect, self.avatarWidth, CGRectMinXEdge);
    avatarRect = CGRectInset(avatarRect, self.avatarPadding, self.avatarPadding);
    CGRectDivide(authorRect, &timeStampRect, &authorRect, self.timestampWidth, CGRectMaxXEdge);
    
    if (showAttachments) {
        CGRectDivide(workingRect, &attachmentsRect, &workingRect, self.attachmentsHeight, CGRectMaxYEdge);
        attachmentsRect = BAKRectTrim(attachmentsRect, self.horizontalMessagePadding, CGRectMinXEdge);
        attachmentsRect = CGRectOffset(attachmentsRect, 0, 5);
    } else {
        attachmentsRect = CGRectMake(0, 0, 500, 100);
    }
    
    messageBodyRect = CGRectInset(workingRect, self.horizontalMessagePadding, 0);
    
    _avatarRect = avatarRect;
    _avatarRadius = avatarRect.size.height/2;
    _authorRect = authorRect;
    _timeStampRect = timeStampRect;
    _messageBodyRect = messageBodyRect;
    _attachmentsRect = attachmentsRect;
    
    return self;
}

- (CGFloat)heightWithTextSize:(CGSize)textSize hasAttachments:(BOOL)hasAttachments {
    return (self.metadataHeight
            + textSize.height
            + self.bottomPadding
            + 5
            + (hasAttachments ? self.attachmentsHeight : 0));
}

- (CGFloat)metadataHeight {
    return 44;
}

- (CGFloat)avatarWidth {
    return 44;
}

- (CGFloat)avatarPadding {
    return 8.5;
}


- (CGFloat)topPadding {
	return 2;
}

- (CGFloat)bottomPadding {
    return 14;
}

- (CGFloat)rightPadding {
    return 10;
}

- (CGFloat)leftPadding {
	return 8;
}

- (CGFloat)horizontalMessagePadding {
	return 13;
}

- (CGFloat)totalHorizontalMessagePadding {
    return self.horizontalMessagePadding * 2 + self.leftPadding + self.rightPadding;
}

- (CGFloat)timestampWidth {
	return 70;
}

- (CGFloat)attachmentsHeight {
	return 72;
}

@end
