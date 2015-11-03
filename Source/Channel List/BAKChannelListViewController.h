//
//  BAKChannelListViewController.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/12/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BAKChannelListViewController, BAKChannel, BAKRemoteConfiguration;

@protocol BAKChannelListDelegate <NSObject>

- (void)channelList:(BAKChannelListViewController *)channelList didSelectChannel:(BAKChannel *)channel;

@end

@interface BAKChannelListViewController : UIViewController
- (instancetype)initWithConfiguration:(BAKRemoteConfiguration *)configuration;

@property (readonly) BAKRemoteConfiguration *configuration;

@property (nonatomic) UITableView *view;
@property (readonly) UITableView *tableView;

@property (nonatomic, weak) id<BAKChannelListDelegate> delegate;

@end
