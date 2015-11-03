//
//  BAKTableViewController.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/6/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAKRemoteDataSource.h"

@interface BAKTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, BAKRemoteDataSourceDelegate>

@property (nonatomic) UITableView *view;
@property (readonly) UITableView *tableView;

@property (nonatomic, readonly) BAKRemoteDataSource *dataSource;

- (void)setUpDataSourceWithTemplate:(id<BAKRequestTemplate>)template cacheName:(NSString *)cacheName;

- (UITableViewCell *)cellWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
- (void)selectedObject:(id)object atIndexPath:(NSIndexPath *)indexPath;

@end
