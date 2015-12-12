//
//  BAKAttachmentPlaceholder.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/17/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKAttachmentContainer.h"
#import "BAKAttachment.h"
#import "BAKColor.h"

@interface BAKAttachmentContainer ()

@property (nonatomic) UIImage *placeholderImage;
@property (nonatomic) BAKAttachment *attachment;
@property (nonatomic) NSError *error;

@end

@implementation BAKAttachmentContainer

- (instancetype)initWithPlaceholderImage:(UIImage *)placeholderImage data:(NSData *)data {
    self = [super init];
    if (!self) return nil;
    
    _placeholderImage = placeholderImage;
    _data = data;
    
    return self;
}

- (void)resetError {
    self.error = nil;
}

- (void)updateWithAttachment:(BAKAttachment *)attachment {
    self.attachment = attachment;
}

- (BOOL)shouldShowLoadingIndicator {
    if ((self.attachment && self.attachment.imageLoaded) || self.error) {
        return NO;
    } else {
        return YES;
    }
}

- (void)updateWithError:(NSError *)error {
    self.error = error;
}

- (BOOL)hadError {
    return !!self.error;
}

- (UIImage *)image {
    if (self.attachment && self.attachment.imageLoaded) {
        return self.attachment.image;
    } else {
        return [self placeholderImage];
    }
}

- (BOOL)attachmentSuccessfullyUploaded  {
    return !(self.shouldShowLoadingIndicator || self.hadError);
}

@end
