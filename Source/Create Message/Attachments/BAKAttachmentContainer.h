//
//  BAKAttachmentPlaceholder.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/17/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@class BAKAttachment;

@interface BAKAttachmentContainer : NSObject

- (instancetype)initWithPlaceholderImage:(UIImage *)placeholderImage data:(NSData *)data;

@property (nonatomic, readonly) NSData *data;
@property (readonly) BOOL shouldShowLoadingIndicator;
@property (readonly) BOOL hadError;
@property (readonly) BOOL attachmentSuccessfullyUploaded;
@property (readonly) UIImage *image;

- (void)updateWithAttachment:(BAKAttachment *)attachment;
- (void)updateWithError:(NSError *)error;
- (void)resetError;

@property (nonatomic, readonly) BAKAttachment *attachment;

@end
