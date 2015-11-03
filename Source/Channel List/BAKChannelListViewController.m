//
//  BAKChannelListViewController.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/12/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKChannelListViewController.h"
#import "BAKChannelsRequest.h"
#import "BAKChannel.h"
#import "BAKAttachment.h"
#import "BAKChannelCell.h"
#import "BAKTableData.h"
#import "BAKRemoteDataSource.h"
#import "BAKChannelHeaderView.h"
#import "BAKAppData.h"
#import "BAKColor.h"

static NSString *const BAKChannelCellIdentifier = @"BAKChannelCellIdentifier";

@interface BAKChannelListViewController () <BAKTableDataDelegate>

@property (nonatomic) BAKTableData *tableData;
@property (nonatomic) BAKChannelHeaderView *headerView;

@end

@implementation BAKChannelListViewController

@dynamic view;

- (instancetype)initWithConfiguration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _configuration = configuration;
    
    return self;
}

- (void)loadView {
    self.view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
}

- (UITableView *)tableView {
    return self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[BAKChannelCell class] forCellReuseIdentifier:BAKChannelCellIdentifier];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [BAKColor grayBackgroundColor];

    self.title = @"Backchannel";
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 44, 0, 0);
    
    self.tableView.tableHeaderView = self.headerView;
    
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    BAKChannelsRequest *template = [[BAKChannelsRequest alloc] initWithConfiguration:self.configuration];
    NSString *cacheName = [NSString stringWithFormat:@"io.backchannel.channels.%@", bundleIdentifier];
    BAKRemoteDataSource *dataSource = [[BAKRemoteDataSource alloc] initWithRequestTemplate:template cacheName:cacheName];
    self.tableData = [[BAKTableData alloc] initWithTableView:self.view dataSource:dataSource];
    self.tableData.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:NO];
}

- (UITableViewCell *)tableData:(BAKTableData *)tableData cellForObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    BAKChannelCell *cell = [self.tableView dequeueReusableCellWithIdentifier:BAKChannelCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell withChannel:object atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(BAKChannelCell *)cell withChannel:(BAKChannel *)channel atIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = channel.name;
    if (channel.icon.imageLoaded) {
        cell.avatarImageView.image = channel.icon.image;
    } else {
        [channel.icon fetchImageWithSuccessBlock:^{
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        } failureBlock:nil];
    }
}

- (void)tableData:(BAKTableData *)tableData selectedObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(channelList:didSelectChannel:)]) {
        [self.delegate channelList:self didSelectChannel:object];
    }
}

- (BAKChannelHeaderView *)headerView {
    if (!_headerView) {
        BAKChannelHeaderView *headerView = [[BAKChannelHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, 150)];
        BAKAppData *appData = [BAKAppData new];
        headerView.iconView.image = appData.icon;
        headerView.nameLabel.text = appData.nameAndVersion;
        self.headerView = headerView;
    }
    return _headerView;
}

@end
