//
//  BAKProfileLayout.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKProfileLayout.h"
#import "BAKGeometry.h"

@implementation BAKProfileLayout

- (instancetype)initWithWorkingRect:(CGRect)workingRect {
    self = [super init];
    if (!self) return nil;
    
    CGRect avatarRect = CGRectZero, avatarEditRect = CGRectZero, formRect = CGRectZero, scrollViewRect = CGRectZero, logoutRect = CGRectZero, loadingRect = CGRectZero;
    
    scrollViewRect = workingRect;
    loadingRect = workingRect;
    
    workingRect = BAKRectTrim(workingRect, self.topPadding, CGRectMinYEdge);
    CGRectDivide(workingRect, &avatarRect, &workingRect, self.avatarDimension + self.editButtonHeight, CGRectMinYEdge);
    avatarRect = BAKRectInsetToSize(avatarRect, CGSizeMake(self.avatarDimension, avatarRect.size.height));
    
    CGRectDivide(avatarRect, &avatarRect, &avatarEditRect, self.avatarDimension, CGRectMinYEdge);
    
    workingRect = BAKRectTrim(workingRect, self.avatarToFormPadding, CGRectMinYEdge);
    CGRectDivide(workingRect, &formRect, &workingRect, self.formHeight, CGRectMinYEdge);
    
    formRect = CGRectInset(formRect, -1, 0);
    
    workingRect = BAKRectTrim(workingRect, self.formToLogoutPadding, CGRectMinYEdge);
    CGRectDivide(workingRect, &logoutRect, &workingRect, self.logOutHeight, CGRectMinYEdge);
    
    logoutRect = CGRectInset(logoutRect, -1, 0);
    
    CGSize contentSize = CGSizeMake(scrollViewRect.size.width,
                                    CGRectUnion(CGRectZero, logoutRect).size.height + self.logOutBottomPadding);

    _scrollViewRect = scrollViewRect;
    _contentSize = contentSize;
    _avatarRect = avatarRect;
    _avatarCornerRadius = avatarRect.size.width/2;
    _avatarEditRect = avatarEditRect;
    _formRect = formRect;
    _logoutRect = logoutRect;
    _loadingRect = loadingRect;
    
    return self;
}

- (CGFloat)topPadding {
    return 12;
}

- (CGFloat)avatarDimension {
    return 72;
}

- (CGFloat)editButtonHeight {
    return 15;
}

- (CGFloat)avatarToFormPadding {
    return 8;
}

- (CGFloat)formHeight {
    return 88;
}

- (CGFloat)formToLogoutPadding {
    return 96;
}

- (CGFloat)logOutHeight {
    return 44;
}

- (CGFloat)logOutBottomPadding {
    return 8;
}

@end
