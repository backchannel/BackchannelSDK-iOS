//
//  BAKGeometry.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/20/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef NS_ENUM(NSInteger, BAKDirection) {
    BAKDirectionHorizontal,
    BAKDirectionVertical,
};


CGRect BAKRectTrim(CGRect rect, CGFloat amount, CGRectEdge edge);
void BAKRectSplit(CGRect rect, CGFloat amount, CGRect *previousRect, CGRect *newRect, CGRect *nextRect, BAKDirection direction);
CGRect BAKRectInsetToSize(CGRect rect, CGSize newSize);