//
//  BAKMessageViewController.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/10/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKMessageViewController.h"
#import "BAKMessage.h"
#import "BAKAttachment.h"
#import "BAKAttachmentContainer.h"
#import "BAKUser.h"
#import "BAKMessageView.h"
#import "BAKAttachmentsViewController.h"
#import "BAKMessageLayout.h"

@interface BAKMessageViewController () <BAKAttachmentsViewControllerDelegate>

@property (nonatomic) BAKAttachmentsViewController *attachmentsViewController;

@end

@implementation BAKMessageViewController

@dynamic view;

- (void)loadView {
    self.view = [BAKMessageView new];
}

- (BAKMessageView *)messageView {
    return self.view;
}

- (void)setMessage:(BAKMessage *)message {
    _message = message;
    self.attachmentsViewController.attachmentContainers = self.message.attachmentContainers;
    [self configureView];
}


- (void)configureView {
    self.messageView.authorLabel.text = self.message.author.displayName;
    self.messageView.messageBodyTextView.attributedText = self.message.attributedBody;
    self.messageView.timeStampLabel.text = self.message.dateDisplayString;
    self.messageView.shouldShowAttachments = self.message.hasAttachments;
    
    BAKAttachment *avatar = self.message.author.avatar;
    if (avatar.imageLoaded) {
        self.messageView.avatarImageView.image = avatar.image;
    } else {
        [avatar fetchImageWithSuccessBlock:^{
            [self configureView];
        } failureBlock:nil];
    }
}

- (BAKAttachmentsViewController *)attachmentsViewController {
    if (!_attachmentsViewController) {
        BAKMessageLayout *layout = [BAKMessageLayout new];
        CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width - layout.leftPadding - layout.rightPadding - layout.horizontalMessagePadding;
        BAKAttachmentsViewController *attachmentsViewController = [[BAKAttachmentsViewController alloc] initAsEditable:NO totalWidth:viewWidth];
        [self addChildViewController:attachmentsViewController];
        [attachmentsViewController didMoveToParentViewController:self];
        self.view.attachmentsView = attachmentsViewController.view;
        attachmentsViewController.delegate = self;
        self.attachmentsViewController = attachmentsViewController;
    }
    return _attachmentsViewController;
}

- (void)attachmentsViewController:(BAKAttachmentsViewController *)attachmentsViewController didTapAttachmentInContainer:(BAKAttachmentContainer *)container {
    if ([self.delegate respondsToSelector:@selector(messageViewController:didTapAttachment:)]) {
        [self.delegate messageViewController:self didTapAttachment:container.attachment];
    }
}

@end
