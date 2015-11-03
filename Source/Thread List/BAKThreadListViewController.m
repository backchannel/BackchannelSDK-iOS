//
//  BAKThreadListViewController.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/25/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKThreadListViewController.h"
#import "BAKChannel.h"
#import "BAKThreadsRequest.h"
#import "BAKThread.h"
#import "BAKMessage.h"
#import "BAKUser.h"
#import "BAKThreadCell.h"
#import "BAKAttachment.h"
#import "BAKMessageCreator.h"
#import "BAKTableData.h"
#import "BAKRemoteDataSource.h"
#import "BAKTableTopSeparator.h"

static NSString *const BAKThreadCellIdentifier = @"BAKThreadCellIdentifier";
static NSString *const BAKLoadingCellIdentifier = @"BAKLoadingCellIdentifier";

@interface BAKThreadListViewController () <BAKTableDataDelegate>

@property (nonatomic) BAKChannel *channel;
@property (nonatomic) BAKTableData *tableData;

@end

@implementation BAKThreadListViewController

@dynamic view;

- (instancetype)initWithChannel:(BAKChannel *)channel configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _channel = channel;
    _configuration = configuration;
    
    return self;
}

- (void)loadView {
    self.view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
}

- (UITableView *)tableView {
    return self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.channel.name;
    
    [self.tableView registerClass:[BAKThreadCell class] forCellReuseIdentifier:BAKThreadCellIdentifier];
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.rowHeight = [BAKThreadCell heightForCell];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 44, 0, 0);
    
    self.tableView.tableHeaderView = [[BAKTableTopSeparator alloc] initWithFrame:CGRectMake(0, 0, 0, 1) inset:self.tableView.separatorInset.left color:self.tableView.separatorColor];

    BAKThreadsRequest *template = [[BAKThreadsRequest alloc] initWithChannelID:self.channel.ID configuration:self.configuration];
    NSString *cacheName = [NSString stringWithFormat:@"io.backchannel.threads.channelID=%@", self.channel.ID];
    BAKRemoteDataSource *dataSource = [[BAKRemoteDataSource alloc] initWithRequestTemplate:template cacheName:cacheName];
    self.tableData = [[BAKTableData alloc] initWithTableView:self.view dataSource:dataSource];
    self.tableData.delegate = self;

    
    UIImage *composeImage = [UIImage imageNamed:@"compose"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:composeImage landscapeImagePhone:composeImage style:UIBarButtonItemStylePlain target:self action:@selector(informDelegateOfComposeTap)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(channelWasModified:) name:BAKChannelWasModifiedNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:NO];
}

- (UITableViewCell *)tableData:(BAKTableData *)tableData cellForObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    BAKThreadCell *cell = [self.tableView dequeueReusableCellWithIdentifier:BAKThreadCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell withThread:object atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(BAKThreadCell *)cell withThread:(BAKThread *)thread atIndexPath:(NSIndexPath *)indexPath {
    cell.subjectLabel.text = thread.subject;
    cell.authorLabel.text = thread.newestMessage.author.displayName;
    cell.timeStampLabel.text = thread.newestMessage.dateDisplayString;
    cell.messagePreviewLabel.text = thread.newestMessage.body;
    cell.messageBodySize = [thread.newestMessage textSizeWithWidth:self.tableView.bounds.size.width - [BAKThreadCell totalHorizontalPaddingForMessageBodyLabel]];
    
    BAKAttachment *avatar = thread.newestMessage.author.avatar;
    if (avatar.imageLoaded) {
        cell.avatarImageView.image = avatar.image;
    } else {
        [avatar fetchImageWithSuccessBlock:^{
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        } failureBlock:nil];        
    }
}

- (void)channelWasModified:(NSNotification *)note {
    BAKChannel *channel = note.object;
    if ([channel.ID isEqual:self.channel.ID]) {
        [self.tableData reload];
    }
}

- (void)tableData:(BAKTableData *)tableData selectedObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(threadList:didSelectThread:)]) {
        [self.delegate threadList:self didSelectThread:object];
    }
}

- (NSString *)noResultsTextForTableData:(BAKTableData *)tableData {
    return @"No threads found.";
}

- (void)informDelegateOfComposeTap {
    if ([self.delegate respondsToSelector:@selector(threadListDidTapCompose:)]) {
        [self.delegate threadListDidTapCompose:self];
    }
}

@end
