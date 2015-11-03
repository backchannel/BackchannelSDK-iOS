//
//  BAKThreadListViewController.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/25/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BAKThreadListViewController, BAKThread, BAKChannel, BAKRemoteConfiguration;

@protocol BAKThreadListDelegate <NSObject>

- (void)threadList:(BAKThreadListViewController *)threadList didSelectThread:(BAKThread *)thread;
- (void)threadListDidTapCompose:(BAKThreadListViewController *)threadList;

@end

@interface BAKThreadListViewController : UIViewController

- (instancetype)initWithChannel:(BAKChannel *)channel configuration:(BAKRemoteConfiguration *)configuration;

@property (readonly) BAKRemoteConfiguration *configuration;

@property (nonatomic) UITableView *view;
@property (readonly) UITableView *tableView;

@property (nonatomic, readonly) BAKChannel *channel;

@property (nonatomic, weak) id<BAKThreadListDelegate> delegate;


@end
