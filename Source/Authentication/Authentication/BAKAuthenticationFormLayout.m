//
//  BAKAuthenticationFormLayout.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/28/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKAuthenticationFormLayout.h"
#import "BAKGeometry.h"

@implementation BAKAuthenticationFormLayout

- (instancetype)initWithWorkingRect:(CGRect)workingRect layoutInsets:(UIEdgeInsets)layoutInsets forgotPasswordHidden:(BOOL)forgotPasswordHidden {
    self = [super init];
    if (!self) return nil;
    
    _forgotPasswordHidden = forgotPasswordHidden;
    
    _scrollViewRect = workingRect;
    
    workingRect = BAKRectTrim(workingRect, layoutInsets.bottom, CGRectMaxYEdge);
    workingRect = BAKRectTrim(workingRect, layoutInsets.top, CGRectMaxYEdge);
    
    CGRect formGroupRect = CGRectZero, actionButtonRect = CGRectZero, forgotPasswordRect = CGRectZero, loadingRect = CGRectZero;
    
    loadingRect = workingRect;
    workingRect = CGRectInset(workingRect, -1, 0);
    
    workingRect = BAKRectTrim(workingRect, self.topPadding, CGRectMinYEdge);
    
    CGRectDivide(workingRect, &formGroupRect, &workingRect, self.formGroupHeight, CGRectMinYEdge);
    
    CGFloat combinedHeight = self.actionButtonHeight + self.forgotPasswordHeight;
    
    workingRect = BAKRectInsetToSize(workingRect, CGSizeMake(workingRect.size.width, combinedHeight));
    
    CGRectDivide(workingRect, &actionButtonRect, &forgotPasswordRect, self.actionButtonHeight, CGRectMinYEdge);
    
    forgotPasswordRect = CGRectInset(forgotPasswordRect, self.forgotPasswordHorizontalInset, 0);
    
    _formGroupRect = formGroupRect;
    _actionButtonRect = actionButtonRect;
    _forgotPasswordRect = forgotPasswordRect;
    _loadingRect = loadingRect;
    
    return self;
}

- (CGFloat)topPadding {
    return 16;
}

- (CGFloat)formGroupHeight {
    return 88;
}

- (CGFloat)forgotPasswordHeight {
   return self.forgotPasswordHidden ? 0 : 24;
}

- (CGFloat)actionButtonHeight {
    return 46;
}

- (CGFloat)forgotPasswordHorizontalInset {
    return 10;
}

@end
