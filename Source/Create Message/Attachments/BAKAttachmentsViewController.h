//
//  BAKAttachmentsViewController.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/5/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@class BAKAttachmentsViewController, BAKAttachmentContainer;

@protocol BAKAttachmentsViewControllerDelegate <NSObject>

- (void)attachmentsViewController:(BAKAttachmentsViewController *)attachmentsViewController didTapAttachmentInContainer:(BAKAttachmentContainer *)attachmentContainer;

@optional
- (void)attachmentsViewControllerDidTapAttachmentButton:(BAKAttachmentsViewController *)attachmentsViewController;

@end

@interface BAKAttachmentsViewController : UIViewController

- (instancetype)initAsEditable:(BOOL)editable itemSize:(CGFloat)itemSize;
- (instancetype)initAsEditable:(BOOL)editable totalWidth:(CGFloat)itemSize;

@property (nonatomic, readonly) BOOL editable;
@property (nonatomic, readonly) CGFloat itemSize;

@property (nonatomic) NSArray *attachmentContainers;

@property (nonatomic) UICollectionView *view;

@property (nonatomic, weak) id<BAKAttachmentsViewControllerDelegate> delegate;

@property (readonly) UICollectionView *collectionView;

@end
