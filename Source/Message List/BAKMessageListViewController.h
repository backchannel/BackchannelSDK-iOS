//
//  BAKMessageListViewController.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/25/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BAKMessageListViewController, BAKMessage, BAKThread, BAKAttachment, BAKRemoteConfiguration;

@protocol BAKMessageListDelegate <NSObject>

- (void)messageListDidTapCompose:(BAKMessageListViewController *)messageList;
- (void)messageList:(BAKMessageListViewController *)messageList didTapAttachment:(BAKAttachment *)attachment;

@end

@interface BAKMessageListViewController : UIViewController

- (instancetype)initWithThread:(BAKThread *)thread configuration:(BAKRemoteConfiguration *)configuration;

@property (readonly) BAKRemoteConfiguration *configuration;

@property (nonatomic, readonly) BAKThread *thread;

@property (nonatomic) UITableView *view;
@property (readonly) UITableView *tableView;

@property (nonatomic, weak) id<BAKMessageListDelegate> delegate;

@end
