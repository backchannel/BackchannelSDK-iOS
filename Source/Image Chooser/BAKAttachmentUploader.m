//
//  BAKUnsentMessage.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/4/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKAttachmentUploader.h"
#import "BAKSendableRequest.h"
#import "BAKMultipartRequestBuilder.h"
#import "BAKUploadAttachmentRequest.h"
#import "BAKAttachment.h"
#import "BAKAttachmentContainer.h"
#import "BAKMappedArray.h"

@interface BAKAttachmentUploader ()

@property (nonatomic) dispatch_group_t dispatchGroup;
@property (nonatomic) NSMutableArray *mutableAttachmentContainers;

@end

@implementation BAKAttachmentUploader

- (instancetype)initWithConfiguration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _configuration = configuration;
    _dispatchGroup = dispatch_group_create();
    _mutableAttachmentContainers = [NSMutableArray array];

    return self;
}

- (void)uploadAttachmentWithData:(NSData *)data placeholderImage:(UIImage *)image {
    BAKAttachmentContainer *attachmentContainer = [[BAKAttachmentContainer alloc] initWithPlaceholderImage:image data:data];
    [self.mutableAttachmentContainers addObject:attachmentContainer];
    [self uploadAttachmentInContainer:attachmentContainer];
}

- (void)retryUploading:(BAKAttachmentContainer *)container {
    if (!container.hadError) {
        return;
    }
    [container resetError];
    [self uploadAttachmentInContainer:container];
}

- (void)uploadAttachmentInContainer:(BAKAttachmentContainer *)container {
    dispatch_group_enter(self.dispatchGroup);
    BAKUploadAttachmentRequest *requestTemplate = [[BAKUploadAttachmentRequest alloc] initWithConfiguration:self.configuration];
    BAKMultipartRequestBuilder *requestBuilder = [[BAKMultipartRequestBuilder alloc] initWithRequestTemplate:requestTemplate data:container.data];
    BAKSendableRequest *request = [[BAKSendableRequest alloc] initWithRequestBuilder:requestBuilder];
    [self informDelegateOfAttachmentUpdate];
    [request sendRequestWithSuccessBlock:^(BAKAttachment *attachment) {
        if (attachment) {
            [container updateWithAttachment:attachment];
            [attachment fetchImageWithSuccessBlock:^{
                [self informDelegateOfAttachmentUpdate];
            } failureBlock:nil];
        }
        dispatch_group_leave(self.dispatchGroup);
    } failureBlock:^(NSError *error) {
        [container updateWithError:error];
        [self informDelegateOfAttachmentUpdate];
        dispatch_group_leave(self.dispatchGroup);
    }];
}

- (void)removeAttachment:(BAKAttachment *)attachment {
    NSInteger indexOfAttachmentContainer = [self.mutableAttachmentContainers indexOfObjectPassingTest:^BOOL(BAKAttachmentContainer *container, NSUInteger idx, BOOL *stop) {
        return container.attachment == attachment;
    }];
    [self.mutableAttachmentContainers removeObjectAtIndex:indexOfAttachmentContainer];
    [self informDelegateOfAttachmentUpdate];
}

- (void)informDelegateOfAttachmentUpdate {
    if ([self.delegate respondsToSelector:@selector(uploader:updatedAttachments:)]) {
        [self.delegate uploader:self updatedAttachments:[self.mutableAttachmentContainers copy]];
    }
}

- (void)waitForAttachmentUploads:(void (^)(NSArray *attachments))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul), ^{
        dispatch_group_wait(self.dispatchGroup, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block(self.attachments);
            }
        });
    });
}

- (NSArray *)attachments {
    return [[BAKMappedArray alloc] initWithArray:self.mutableAttachmentContainers transformationBlock:^id(BAKAttachmentContainer *container) {
        return container.attachment;
    }];
}

@end
