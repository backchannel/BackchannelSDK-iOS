//
//  BAKGeometry.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/20/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKGeometry.h"

CGRect BAKRectTrim(CGRect rect, CGFloat amount, CGRectEdge edge) {
    CGRect trimmedRect;
    CGRectDivide(rect, &(CGRect){}, &trimmedRect, amount, edge);
    return trimmedRect;
}

void BAKRectSplit(CGRect rect, CGFloat amount, CGRect *previousRect, CGRect *newRect, CGRect *nextRect, BAKDirection direction) {
    CGFloat totalAmount = (direction == BAKDirectionHorizontal) ? CGRectGetWidth(rect) : CGRectGetHeight(rect);
    
    CGFloat offset = (totalAmount - amount)/2;
    
    CGRect workingRect = rect;
    
    CGRectEdge edge = (direction == BAKDirectionHorizontal) ? CGRectMinXEdge : CGRectMinYEdge;
    
    CGRectDivide(workingRect, previousRect, &workingRect, offset, edge);
    CGRectDivide(workingRect, newRect, nextRect, amount, edge);
}

CGRect BAKRectInsetToSize(CGRect rect, CGSize newSize) {
    CGFloat horizontalInset = (rect.size.width - newSize.width)/2;
    CGFloat verticalInset = (rect.size.height - newSize.height)/2;
    
    return CGRectInset(rect, horizontalInset, verticalInset);
}
