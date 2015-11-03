//
//  BAKAttachmentViewController.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/17/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAKAttachmentView.h"

@class BAKAttachment, BAKAttachmentViewController;

@protocol BAKAttachmentViewControllerDelegate <NSObject>

- (void)attachmentViewController:(BAKAttachmentViewController *)attachmentViewController didTapRemoveForAttachment:(BAKAttachment *)attachment;

@end

@interface BAKAttachmentViewController : UIViewController

- (instancetype)initWithAttachment:(BAKAttachment *)attachment;

@property (nonatomic, readonly) BAKAttachment *attachment;

@property (nonatomic) BAKAttachmentView *view;

@property (readonly) BAKAttachmentView *attachmentView;

@property (nonatomic) BOOL showRemoveButton;

@property (nonatomic, weak) id<BAKAttachmentViewControllerDelegate> delegate;


@end
