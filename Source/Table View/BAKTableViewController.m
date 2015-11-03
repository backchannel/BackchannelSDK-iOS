//
//  BAKTableViewController.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/6/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKTableViewController.h"
#import "BAKRemoteDataSource.h"
#import "BAKLoadingCell.h"
#import "BAKSection.h"

static NSString *const BAKLoadingCellIdentifier = @"BAKLoadingCellIdentifier";
static NSString *const BAKErrorCellIdentifier = @"BAKErrorCellIdentifier";

@interface BAKTableViewController ()

@property (nonatomic) BAKRemoteDataSource *dataSource;
@property (nonatomic) UIRefreshControl *refreshControl;

@end

@implementation BAKTableViewController

@dynamic view;

- (void)loadView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.view = tableView;
}

- (UITableView *)tableView {
    return self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[BAKLoadingCell class] forCellReuseIdentifier:BAKLoadingCellIdentifier];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:BAKErrorCellIdentifier];
    
    [self.tableView addSubview:self.refreshControl];
}

- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
        [refreshControl addTarget:self action:@selector(reload:) forControlEvents:UIControlEventValueChanged];
        self.refreshControl = refreshControl;
    }
    return _refreshControl;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:NO];
}

- (void)setUpDataSourceWithTemplate:(id<BAKRequestTemplate>)template cacheName:(NSString *)cacheName {
    self.dataSource = [[BAKRemoteDataSource alloc] initWithRequestTemplate:template cacheName:cacheName];
    self.dataSource.delegate = self;
    [self.dataSource fetchData];
}

- (void)remoteDataSourceUpdated:(BAKRemoteDataSource *)remoteDataSource {
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfObjectsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = [self.dataSource objectAtIndexPath:indexPath];
    return [self cellWithObject:object atIndexPath:indexPath];
}

- (UITableViewCell *)cellWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    BAKSection *section = [self.dataSource sectionAtIndex:indexPath.section];
    if (section.isLoadingSection) {
        [self.dataSource fetchNextPage];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BAKSection *section = [self.dataSource sectionAtIndex:indexPath.section];
    if (section.isContentSection) {
        id object = [self.dataSource objectAtIndexPath:indexPath];
        [self selectedObject:object atIndexPath:indexPath];
    }
}

- (void)selectedObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    //no-op
}

- (void)reload:(id)sender {
    [self.dataSource reload];
}

@end
