//
//  BAKUnsentMessage.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/4/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@class BAKAttachmentUploader, BAKRemoteConfiguration, BAKAttachmentContainer, BAKAttachment;

@protocol BAKAttachmentUploaderDelegate <NSObject>

- (void)uploader:(BAKAttachmentUploader *)attachmentUploader updatedAttachments:(NSArray *)attachmentContainers;

@end

@interface BAKAttachmentUploader : NSObject

- (instancetype)initWithConfiguration:(BAKRemoteConfiguration *)configuration;

@property (readonly) BAKRemoteConfiguration *configuration;

- (void)uploadAttachmentWithData:(NSData *)data placeholderImage:(UIImage *)image;

- (void)retryUploading:(BAKAttachmentContainer *)container;

- (void)removeAttachment:(BAKAttachment *)attachment;

@property (nonatomic, weak) id<BAKAttachmentUploaderDelegate> delegate;

- (void)waitForAttachmentUploads:(void (^)(NSArray *attachments))block;

@end
