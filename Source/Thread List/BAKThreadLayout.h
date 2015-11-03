//
//  BAKThreadLayout.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/2/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreGraphics;

@interface BAKThreadLayout : NSObject

- (instancetype)initWithWorkingRect:(CGRect)workingRect chevronSize:(CGSize)chevronSize messageHeight:(CGFloat)messageHeight;


@property (nonatomic, readonly) CGRect avatarRect;
@property (nonatomic, readonly) CGFloat avatarCornerRadius;
@property (nonatomic, readonly) CGRect subjectRect;
@property (nonatomic, readonly) CGRect chevronRect;
@property (nonatomic, readonly) CGRect authorRect;
@property (nonatomic, readonly) CGRect timeStampRect;
@property (nonatomic, readonly) CGRect messagePreviewRect;


@end
