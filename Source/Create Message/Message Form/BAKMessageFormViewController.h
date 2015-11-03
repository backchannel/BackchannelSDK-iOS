//
//  BAKDisucssionFormViewController.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/25/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAKMessageFormView.h"

@class BAKMessageFormViewController, BAKMessageFormView, BAKThread, BAKDraft, BAKAttachmentContainer, BAKChannel, BAKChannelsStore;

@protocol BAKMessageFormDelegate <NSObject>

- (void)messageFormDidTapCancel:(BAKMessageFormViewController *)messageForm;
- (void)messageFormDidTapNewAttachmentButton:(BAKMessageFormViewController *)messageForm;
- (void)messageForm:(BAKMessageFormViewController *)messageForm didTapPostWithDraft:(BAKDraft *)draft;
- (void)messageForm:(BAKMessageFormViewController *)messageForm didTapAttachmentInContainer:(BAKAttachmentContainer *)attachmentContainer;
- (void)messageForm:(BAKMessageFormViewController *)messageForm didSetChannel:(BAKChannel *)channel;

@end

@interface BAKMessageFormViewController : UIViewController

- (instancetype)initWithChannelsStore:(BAKChannelsStore *)channelsStore;
- (instancetype)initForNewThread;
- (instancetype)initForExistingThread:(BAKThread *)thread;

@property (nonatomic, weak) id<BAKMessageFormDelegate> delegate;

@property (nonatomic) NSArray *attachmentContainers;

@property (nonatomic) BAKMessageFormView *view;
@property (readonly) BAKMessageFormView *messageForm;

- (void)showKeyboard;

@property (nonatomic, readonly) BOOL hasChanges;

- (void)setChannelInPicker:(BAKChannel *)channel;
- (void)refreshChannels;

@end
