//
//  BAKMessageLayout.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreGraphics;
@import UIKit;

@interface BAKMessageLayout : NSObject

- (instancetype)initWithWorkingRect:(CGRect)workingRect showAttachments:(BOOL)showAttachments;

- (CGFloat)heightWithTextSize:(CGSize)textSize hasAttachments:(BOOL)hasAttachments;

@property (nonatomic) CGRect avatarRect;
@property (nonatomic) CGFloat avatarRadius;
@property (nonatomic) CGRect authorRect;
@property (nonatomic) CGRect timeStampRect;
@property (nonatomic) CGRect messageBodyRect;
@property (nonatomic) CGRect attachmentsRect;

@property (readonly) CGFloat leftPadding;
@property (readonly) CGFloat rightPadding;
@property (readonly) CGFloat horizontalMessagePadding;
@property (readonly) CGFloat totalHorizontalMessagePadding;

@end
