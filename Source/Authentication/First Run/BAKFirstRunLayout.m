//
//  BAKFirstRunLayout.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKFirstRunLayout.h"
#import "BAKGeometry.h"

@implementation BAKFirstRunLayout

- (instancetype)initWithWorkingRect:(CGRect)workingRect emailButtonShowing:(BOOL)emailButtonShowing {
    self = [super init];
    if (!self) return nil;
    
    CGRect scrollRect = CGRectZero, createAccountRect = CGRectZero, signInRect = CGRectZero, postViaEmailRect = CGRectZero, backchannelRect = CGRectZero, descriptionRect = CGRectZero;
    
    scrollRect = workingRect;
    
    workingRect = BAKRectTrim(workingRect, self.itemPadding, CGRectMinYEdge);
    CGRectDivide(workingRect, &backchannelRect, &workingRect, self.backchannelDimension, CGRectMinYEdge);
    backchannelRect = CGRectOffset(backchannelRect, 0, self.backchannelVerticalOffset);
    
    workingRect = BAKRectTrim(workingRect, self.itemPadding, CGRectMinYEdge);
    CGRectDivide(workingRect, &descriptionRect, &workingRect, self.descriptionHeight, CGRectMinYEdge);
    descriptionRect = CGRectInset(descriptionRect, self.leftAndRightDescriptionPadding, 0);
    
    CGRectDivide(workingRect, &createAccountRect, &workingRect, self.buttonHeight, CGRectMinYEdge);
    createAccountRect = CGRectInset(createAccountRect, -1, 0);
    
    workingRect = BAKRectTrim(workingRect, self.interButtonSpacing, CGRectMinYEdge);
    CGRectDivide(workingRect, &signInRect, &workingRect, self.buttonHeight, CGRectMinYEdge);
    signInRect = CGRectInset(signInRect, -1, 0);
    
    if (emailButtonShowing) {
        workingRect = BAKRectTrim(workingRect, self.interButtonSpacing, CGRectMinYEdge);
        CGRectDivide(workingRect, &postViaEmailRect, &workingRect, self.buttonHeight, CGRectMinYEdge);
        postViaEmailRect = CGRectInset(postViaEmailRect, -1, 0);
    }

    _scrollRect = scrollRect;
    _createAccountRect = createAccountRect;
    _signInRect = signInRect;
    _postViaEmailRect = postViaEmailRect;
    _backchannelRect = backchannelRect;
    _descriptionRect = descriptionRect;

    return self;
}

- (CGFloat)itemPadding {
    return 20;
}

- (CGFloat)backchannelDimension {
    return 76;
}

- (CGFloat)backchannelVerticalOffset {
    return 15;
}

- (CGFloat)descriptionHeight {
    return 100;
}

- (CGFloat)buttonHeight {
    return 44;
}

- (CGFloat)interButtonSpacing {
    return 22;
}

- (CGFloat)leftAndRightDescriptionPadding {
    return 20;
}

@end
