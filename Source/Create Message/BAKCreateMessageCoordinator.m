//
//  BAKCreateMessageCoordinator.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/28/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKCreateMessageCoordinator.h"
#import "BAKMessageFormViewController.h"
#import "BAKCreateMessageRequest.h"
#import "BAKThread.h"
#import "BAKChannel.h"
#import "BAKSendableRequest.h"
#import "BAKAttachmentUploader.h"
#import "BAKChooseImageCoordinator.h"
#import "BAKMessageCreator.h"
#import "BAKDraft.h"
#import "BAKErrorPresenter.h"
#import "BAKAttachmentContainer.h"
#import "BAKAttachmentViewController.h"
#import "BAKChannelsStore.h"
#import "BAKChannelPickerViewController.h"

@interface BAKCreateMessageCoordinator () <BAKMessageFormDelegate, BAKImageChooserDelegate, BAKAttachmentUploaderDelegate, BAKAttachmentViewControllerDelegate>

@property (nonatomic) id<BAKCreator> creator;
@property (nonatomic) NSMutableArray *childCoordinators;
@property (nonatomic) BAKAttachmentUploader *attachmentUploader;
@property (nonatomic) BAKMessageFormViewController *messageForm;
@property (nonatomic) BAKChannelsStore *channelsStore;

@end

@implementation BAKCreateMessageCoordinator

- (instancetype)initWithChannelsStore:(BAKChannelsStore *)channelsStore navigationController:(UINavigationController *)navigationController configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _channelsStore = channelsStore;
    _navigationController = navigationController;
    _messageForm = [[BAKMessageFormViewController alloc] initWithChannelsStore:self.channelsStore];
    _messageForm.delegate = self;
    _creator = [[BAKThreadCreator alloc] initWithChannel:self.channelsStore.channels.firstObject configuration:configuration];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(channelsStoreUpdated:) name:BAKChannelsStoreUpdatedNotification object:nil];

    return self;
}

- (instancetype)initForNewThreadInChannel:(BAKChannel *)channel navigationController:(UINavigationController *)navigationController configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _navigationController = navigationController;
    _messageForm = [[BAKMessageFormViewController alloc] initForNewThread];
    _messageForm.delegate = self;
    _creator = [[BAKThreadCreator alloc] initWithChannel:channel configuration:configuration];
    
    return self;
}

- (instancetype)initForExistingThread:(BAKThread *)thread navigationController:(UINavigationController *)navigationController configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _navigationController = navigationController;
    _messageForm = [[BAKMessageFormViewController alloc] initForExistingThread:thread];
    _messageForm.delegate = self;
    _creator = [[BAKMessageCreator alloc] initWithThread:thread configuration:configuration];
    
    return self;
}

- (BAKRemoteConfiguration *)configuration {
    return self.creator.configuration;
}

- (void)start {
    [self.navigationController pushViewController:self.messageForm animated:NO];
    [self.messageForm showKeyboard];
}

- (void)messageForm:(BAKMessageFormViewController *)messageForm didTapPostWithDraft:(BAKDraft *)draft {
    [messageForm.messageForm showLoadingView];
    [self.attachmentUploader waitForAttachmentUploads:^(NSArray *attachments) {
        draft.attachments = attachments;
        [self.creator createWithDraft:draft successBlock:^(id product) {
            [messageForm.messageForm hideLoadingView];
            [self informDelegateOfCompletionWithProduct:product];
        } failureBlock:^(NSError *error) {
            [messageForm.messageForm hideLoadingView];
            [[[BAKErrorPresenter alloc] initWithError:error viewController:messageForm] present];
        }];
    }];
}

- (void)messageFormDidTapCancel:(BAKMessageFormViewController *)messageForm {
    if (messageForm.hasChanges) {
        [self showConfirmationActionSheet];
    } else {
        [self finalizeCancellation];
    }
}

- (void)showConfirmationActionSheet {
    UIAlertController *alertController = [[UIAlertController alloc] init];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Delete Post" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self finalizeCancellation];
    }]];
    [self.messageForm presentViewController:alertController animated:YES completion:nil];
}

- (void)finalizeCancellation {
    [self.messageForm dismissViewControllerAnimated:YES completion:nil];
    if ([self.delegate respondsToSelector:@selector(createMessageCancelled:)]) {
        [self.delegate createMessageCancelled:self];
    }
}

- (void)informDelegateOfCompletionWithProduct:(id)product {
    [self.messageForm dismissViewControllerAnimated:YES completion:nil];
    if (self.creator.thread) {
        if ([self.delegate respondsToSelector:@selector(createMessageCompleted:)]) {
            [self.delegate createMessageCompleted:self];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(createMessageCompleted:onNewThread:)]) {
            [self.delegate createMessageCompleted:self onNewThread:product];
        }
    }
}

- (void)messageForm:(BAKMessageFormViewController *)messageForm didTapAttachmentInContainer:(BAKAttachmentContainer *)container {
    if (container.hadError) {
        UIAlertController *alertController = [[UIAlertController alloc] init];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self reuploadAttachmentInContainer:container];
        }]];
        [self.messageForm presentViewController:alertController animated:YES completion:nil];
    } else {
        BAKAttachmentViewController *attachmentViewController = [[BAKAttachmentViewController alloc] initWithAttachment:container.attachment];
        attachmentViewController.delegate = self;
        attachmentViewController.showRemoveButton = YES;
        [self.navigationController pushViewController:attachmentViewController animated:YES];
    }
}

- (void)reuploadAttachmentInContainer:(BAKAttachmentContainer *)container {
    [self.attachmentUploader retryUploading:container];
}

- (void)attachmentViewController:(BAKAttachmentViewController *)attachmentViewController didTapRemoveForAttachment:(BAKAttachment *)attachment {
    [self.attachmentUploader removeAttachment:attachment];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)messageForm:(BAKMessageFormViewController *)messageForm didSetChannel:(BAKChannel *)channel {
    self.creator = [[BAKThreadCreator alloc] initWithChannel:channel configuration:self.configuration];
}

- (void)channelsStoreUpdated:(NSNotification *)note {
    if (self.creator.channel == nil) {
        BAKChannel *firstChannel = self.channelsStore.channels.firstObject;
        [self.messageForm setChannelInPicker:firstChannel];
        self.creator = [[BAKThreadCreator alloc] initWithChannel:firstChannel configuration:self.configuration];
    }
    [self.messageForm refreshChannels];
}

- (void)messageFormDidTapNewAttachmentButton:(BAKMessageFormViewController *)messageForm {
    BAKChooseImageCoordinator *imageChooser = [[BAKChooseImageCoordinator alloc] initWithViewController:messageForm];
    imageChooser.delegate = self;
    [self.childCoordinators addObject:imageChooser];
    [imageChooser start];
}

- (void)imageChooserDidCancel:(BAKChooseImageCoordinator *)imageChooser {
    [self.childCoordinators removeObject:imageChooser];
}

- (void)imageChooser:(BAKChooseImageCoordinator *)imageChooser didChooseImage:(UIImage *)image data:(NSData *)data {
    [self attachImageWithData:data placeholderImage:image];
    [self.childCoordinators removeObject:imageChooser];
}

- (void)attachImageWithData:(NSData *)data placeholderImage:(UIImage *)placeholderImage {
    [self.attachmentUploader uploadAttachmentWithData:data placeholderImage:placeholderImage];
}

- (void)uploader:(BAKAttachmentUploader *)attachmentUploader updatedAttachments:(NSArray *)attachmentContainers {
    self.messageForm.attachmentContainers = attachmentContainers;
}

- (BAKAttachmentUploader *)attachmentUploader {
    if (!_attachmentUploader) {
        BAKAttachmentUploader *attachmentUploader = [[BAKAttachmentUploader alloc] initWithConfiguration:self.configuration];
        attachmentUploader.delegate = self;
        
        self.attachmentUploader = attachmentUploader;
    }
    return _attachmentUploader;
}

- (NSMutableArray *)childCoordinators {
    if (!_childCoordinators) {
        self.childCoordinators = [NSMutableArray array];
    }
    return _childCoordinators;
}

@end
