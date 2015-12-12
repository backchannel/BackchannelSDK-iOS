//
//  BAKTableData.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/17/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKTableData.h"
#import "BAKRemoteDataSource.h"
#import "BAKSection.h"
#import "BAKLoadingCell.h"

static NSString *const BAKLoadingCellIdentifier = @"BAKLoadingCellIdentifier";
static NSString *const BAKErrorCellIdentifier = @"BAKErrorCellIdentifier";
static NSString *const BAKNoResultsCellIdentifier = @"BAKNoResultsCellIdentifier";

@interface BAKTableData () <BAKRemoteDataSourceDelegate>

@property (nonatomic) UIRefreshControl *refreshControl;

@end

@implementation BAKTableData

- (instancetype)initWithTableView:(UITableView *)tableView dataSource:(BAKRemoteDataSource *)dataSource {
    self = [super init];
    if (!self) return nil;
    
    _dataSource = dataSource;
    _tableView = tableView;
    
    self.dataSource.delegate = self;
    [self.dataSource fetchData];
    
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [self.tableView registerClass:[BAKLoadingCell class] forCellReuseIdentifier:BAKLoadingCellIdentifier];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:BAKErrorCellIdentifier];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:BAKNoResultsCellIdentifier];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    return self;
}

- (void)remoteDataSourceUpdated:(BAKRemoteDataSource *)remoteDataSource {
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}

- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
        [refreshControl addTarget:self action:@selector(reload:) forControlEvents:UIControlEventValueChanged];
        self.refreshControl = refreshControl;
    }
    return _refreshControl;
}

- (void)reload:(id)sender {
    [self.dataSource reload];
}

- (void)reload {
    [self.dataSource reload];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfObjectsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BAKSection *section = [self.dataSource sectionAtIndex:indexPath.section];
    if (section.isLoadingSection) {
        BAKLoadingCell *cell = [tableView dequeueReusableCellWithIdentifier:BAKLoadingCellIdentifier forIndexPath:indexPath];
        [cell.activityIndicator startAnimating];
        return cell;
    }
    if (section.isNoResultsSection) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BAKNoResultsCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = self.noResultsText;
        return cell;
    }
    id object = [self.dataSource objectAtIndexPath:indexPath];
    
    if (section.isErrorSection) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BAKErrorCellIdentifier forIndexPath:indexPath];
        NSError *error = object;
        cell.textLabel.text = error.localizedFailureReason ?: error.localizedDescription;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    UITableViewCell *cell;
    if ([self.delegate respondsToSelector:@selector(tableData:cellForObject:atIndexPath:)]) {
        cell = [self.delegate tableData:self cellForObject:object atIndexPath:indexPath];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BAKSection *section = [self.dataSource sectionAtIndex:indexPath.section];
    if (section.isLoadingSection || section.isErrorSection || section.isNoResultsSection) {
        return 44;
    }
    id object = [self.dataSource objectAtIndexPath:indexPath];
    CGFloat height = self.tableView.rowHeight;
    if ([self.delegate respondsToSelector:@selector(tableData:heightForObject:atIndexPath:)]) {
        height = [self.delegate tableData:self heightForObject:object atIndexPath:indexPath];
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BAKSection *section = [self.dataSource sectionAtIndex:indexPath.section];
    if (section.isContentSection) {
        id object = [self.dataSource objectAtIndexPath:indexPath];
        if ([self.delegate respondsToSelector:@selector(tableData:selectedObject:atIndexPath:)]) {
            [self.delegate tableData:self selectedObject:object atIndexPath:indexPath];
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    BAKSection *section = [self.dataSource sectionAtIndex:indexPath.section];
    if (section.isLoadingSection) {
        [self.dataSource fetchNextPage];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    BAKSection *section = [self.dataSource sectionAtIndex:indexPath.section];
    if (!section.isContentSection) {
        return;
    }
    id object = [self.dataSource objectAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(tableData:willEndDisplayingObject:inCell:atIndexPath:)]) {
        [self.delegate tableData:self willEndDisplayingObject:object inCell:cell atIndexPath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    BAKSection *section = [self.dataSource sectionAtIndex:indexPath.section];
    id object = [self.dataSource objectAtIndexPath:indexPath];
    if (section.isContentSection
        && [self.delegate respondsToSelector:@selector(tableData:canDeleteObject:)]
        && [self.delegate tableData:self canDeleteObject:object]) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = [self.dataSource objectAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(tableData:commitDeletionForObject:atIndexPath:)]) {
        [self.delegate tableData:self commitDeletionForObject:object atIndexPath:indexPath];
    }
}

- (NSString *)noResultsText {
    if ([self.delegate respondsToSelector:@selector(noResultsTextForTableData:)]) {
        return [self.delegate noResultsTextForTableData:self];
    }
    return @"No results found.";
}

@end
