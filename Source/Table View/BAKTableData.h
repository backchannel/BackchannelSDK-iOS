//
//  BAKTableData.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/17/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@class BAKTableData, BAKRemoteDataSource;

@protocol BAKTableDataDelegate <NSObject>

- (UITableViewCell *)tableData:(BAKTableData *)tableData cellForObject:(id)object atIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)tableData:(BAKTableData *)tableData selectedObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
- (NSString *)noResultsTextForTableData:(BAKTableData *)tableData;
- (CGFloat)tableData:(BAKTableData *)tableData heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
- (void)tableData:(BAKTableData *)tableData willEndDisplayingObject:(id)object inCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableData:(BAKTableData *)tableData canDeleteObject:(id)object;
- (void)tableData:(BAKTableData *)tableData commitDeletionForObject:(id)object;

@end

@interface BAKTableData : NSObject <UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithTableView:(UITableView *)tableView dataSource:(BAKRemoteDataSource *)dataSource;

@property (nonatomic, readonly) UITableView *tableView;
@property (nonatomic, readonly) BAKRemoteDataSource *dataSource;

@property (nonatomic, weak) id<BAKTableDataDelegate> delegate;

- (void)reload;

@end
