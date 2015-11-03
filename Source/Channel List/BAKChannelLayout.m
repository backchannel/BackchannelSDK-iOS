//
//  BAKChannelLayout.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/7/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

@import CoreGraphics;
@import UIKit;

#import "BAKChannelLayout.h"
#import "BAKGeometry.h"

@implementation BAKChannelLayout

- (instancetype)initWithWorkingRect:(CGRect)workingRect {
    self = [super init];
    if (!self) return nil;
    
    CGRect imageRect = CGRectZero, textRect = CGRectZero, chevronRect = CGRectZero;
    
    CGRectDivide(workingRect, &imageRect, &workingRect, self.totalImageWidth, CGRectMinXEdge);
    imageRect = CGRectInset(imageRect, self.imageInset, self.imageInset);
    CGRectDivide(workingRect, &chevronRect, &workingRect, self.totalChevronWidth, CGRectMaxXEdge);
    
    textRect = workingRect;
    
    _imageRect = imageRect;
    _textRect = textRect;
    _chevronRect = chevronRect;
    
    return self;
}

- (CGFloat)leftPadding {
    return 7;
}

- (CGFloat)totalImageWidth {
    return 44;
}

- (CGFloat)totalChevronWidth {
    return 30;
}

- (CGFloat)imageInset {
    return 8;
}

@end
