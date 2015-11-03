//
//  BAKMessageListViewController.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/25/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKMessageListViewController.h"
#import "BAKThread.h"
#import "BAKMessagesRequest.h"
#import "BAKMessage.h"
#import "BAKMessageCell.h"
#import "BAKUser.h"
#import "BAKAttachment.h"
#import "BAKMessageViewController.h"
#import "BAKViewControllerRecycler.h"
#import "BAKMessageView.h"
#import "BAKMessageLayout.h"
#import "BAKMessageCreator.h"
#import "BAKSection.h"
#import "BAKRemoteDataSource.h"
#import "BAKTableData.h"
#import "BAKTableTopSeparator.h"
#import "BAKSendableRequest.h"
#import "BAKDeleteMessageRequest.h"
#import "BAKErrorPresenter.h"

static NSString *const BAKMessageCellIdentifier = @"BAKMessageCellIdentifier";
static NSString *const BAKLoadingCellIdentifier = @"BAKLoadingCellIdentifier";

@interface BAKMessageListViewController () <BAKTableDataDelegate, BAKMessageViewControllerDelegate>

@property (nonatomic) BAKThread *thread;
@property (nonatomic) BAKViewControllerRecycler *recycler;
@property (nonatomic) BAKTableData *tableData;

@end

@implementation BAKMessageListViewController

@dynamic view;

- (instancetype)initWithThread:(BAKThread *)thread configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _thread = thread;
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
    
    self.tableView.tableFooterView = [UIView new];
    self.title = self.thread.subject;
    
    self.tableView.rowHeight = 100;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 21, 0, 0);
   
    self.tableView.tableHeaderView = [[BAKTableTopSeparator alloc] initWithFrame:CGRectMake(0, 0, 0, 1) inset:self.tableView.separatorInset.left color:self.tableView.separatorColor];

    BAKMessagesRequest *template = [[BAKMessagesRequest alloc] initWithThreadID:self.thread.ID configuration:self.configuration];
    NSString *cacheName = [NSString stringWithFormat:@"io.backchannel.messages.threadID=%@", self.thread.ID];
    BAKRemoteDataSource *dataSource = [[BAKRemoteDataSource alloc] initWithRequestTemplate:template cacheName:cacheName];
    self.tableData = [[BAKTableData alloc] initWithTableView:self.view dataSource:dataSource];
    self.tableData.delegate = self;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(informDelegateOfComposeTap)];
    
    [self.tableView registerClass:[BAKMessageCell class] forCellReuseIdentifier:BAKMessageCellIdentifier];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(threadWasModified:) name:BAKThreadWasModifiedNotification object:nil];
}

- (UITableViewCell *)tableData:(BAKTableData *)tableData cellForObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    BAKMessageCell *cell = [self.tableView dequeueReusableCellWithIdentifier:BAKMessageCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BAKMessageViewController *viewController = [self.recycler recycledOrNewViewController];
    viewController.message = object;
    [self.recycler hangOnToViewController:viewController atIndexPath:indexPath];
    cell.hostedView = viewController.view;
    return cell;
}

- (BAKViewControllerRecycler *)recycler {
    if (!_recycler) {
        self.recycler = [[BAKViewControllerRecycler alloc] initWithViewControllerClass:[BAKMessageViewController class] parentViewController:self];
    }
    return _recycler;
}

- (void)tableData:(BAKTableData *)tableData willEndDisplayingObject:(id)object inCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[BAKMessageCell class]]) {
        [self.recycler recycleViewControllerAtIndexPath:indexPath];
    }
}

- (CGFloat)tableData:(BAKTableData *)tableData heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    BAKMessage *message = object;
    BAKMessageViewController *messageViewController = [self.recycler recycledOrNewViewController];
    messageViewController.delegate = self;
    BAKMessageLayout *layout = [BAKMessageLayout new];
    CGFloat width = self.tableView.frame.size.width-layout.totalHorizontalMessagePadding;
    return [layout heightWithTextSize:[message textSizeWithWidth:width]
                                         hasAttachments:message.hasAttachments];
}

- (void)messageViewController:(BAKMessageViewController *)messageViewController didTapAttachment:(BAKAttachment *)attachment {
    if ([self.delegate respondsToSelector:@selector(messageList:didTapAttachment:)]) {
        [self.delegate messageList:self didTapAttachment:attachment];
    }
}

- (BOOL)tableData:(BAKTableData *)tableData canDeleteObject:(id)object {
    return [object canBeDeleted];
}

- (void)tableData:(BAKTableData *)tableData commitDeletionForObject:(BAKMessage *)message {
    NSString *oldMessageBody = message.body;
    [message setTextToDeleted];
    [self.tableView reloadData];
    BAKDeleteMessageRequest *deleteMessageRequest = [[BAKDeleteMessageRequest alloc] initWithMessageID:message.ID configuration:self.configuration];
    BAKSendableRequest *sendableRequest = [[BAKSendableRequest alloc] initWithRequestTemplate:deleteMessageRequest];
    [sendableRequest sendRequestWithSuccessBlock:^(id result) {
        
    } failureBlock:^(NSError *error) {
        [message updateWithBody:oldMessageBody];
        [self.tableView reloadData];
        [[[BAKErrorPresenter alloc] initWithError:error viewController:self] present];
    }];
}

- (void)threadWasModified:(NSNotification *)note {
    BAKThread *thread = note.object;
    if ([thread.ID isEqual:self.thread.ID]) {
        [self.tableData reload];
    }
}

- (void)informDelegateOfComposeTap {
    if ([self.delegate respondsToSelector:@selector(messageListDidTapCompose:)]) {
        [self.delegate messageListDidTapCompose:self];
    }
}

@end
