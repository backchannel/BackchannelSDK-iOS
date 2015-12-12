//
//  BAKMessagesCoordinator.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/25/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKMessagesCoordinator.h"
#import "BAKChannelListViewController.h"
#import "BAKThreadListViewController.h"
#import "BAKMessageListViewController.h"
#import "BAKAuthenticatingCreateMessageCoordinator.h"
#import "BAKAttachmentViewController.h"
#import "BAKEditProfileCoordinator.h"
#import "BAKCurrentUserStore.h"
#import "BAKSession.h"
#import "BAKAuthenticationCoordinator.h"
#import "BAKCache.h"
#import "BAKSendableRequest.h"
#import "BAKLogoutRequest.h"

@interface BAKMessagesCoordinator () <BAKAuthenticationDelegate, BAKChannelListDelegate, BAKThreadListDelegate, BAKMessageListDelegate, BAKAuthenticatingCreateMessageCoordinatorDelegate, BAKEditProfileDelegate, BAKCurrentUserStoreDelegate>

@property (nonatomic) NSMutableArray *childCoordinators;
@property (nonatomic) BAKCurrentUserStore *currentUserStore;
@property (nonatomic) BAKChannelListViewController *channelList;

@end

@implementation BAKMessagesCoordinator

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _navigationController = navigationController;
    _configuration = configuration;
    _currentUserStore = [[BAKCurrentUserStore alloc] initWithConfiguration:self.configuration];
    _currentUserStore.delegate = self;
    [_currentUserStore updateFromAPI];
    
    return self;
}

- (BOOL)isLoggedIn {
    return [BAKSession currentSession].isLoggedIn;
}

- (void)start {
    BAKChannelListViewController *channelList = [[BAKChannelListViewController alloc] initWithConfiguration:self.configuration];
    channelList.delegate = self;
    channelList.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStylePlain target:self action:@selector(dismissBackchannel:)];
    self.channelList = channelList;
    [self setUpRightBarButton];

    [self.navigationController pushViewController:channelList animated:NO];
}

- (void)currentUserStoreFailedToValidateAuthToken:(BAKCurrentUserStore *)currentUserStore {
    [self logOutCurrentUser];
    [self setUpRightBarButton];
}

- (void)setUpRightBarButton {
    if ([self isLoggedIn]) {
        self.channelList.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Profile" style:UIBarButtonItemStylePlain target:self action:@selector(showEditProfile:)];
    } else {
        self.channelList.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign In" style:UIBarButtonItemStylePlain target:self action:@selector(showAuthentication:)];
    }
}

- (void)channelList:(BAKChannelListViewController *)channelList didSelectChannel:(BAKChannel *)channel {
    BAKThreadListViewController *threadList = [[BAKThreadListViewController alloc] initWithChannel:channel configuration:self.configuration];
    threadList.delegate = self;
    [self.navigationController pushViewController:threadList animated:YES];
}

- (void)threadList:(BAKThreadListViewController *)threadList didSelectThread:(BAKThread *)thread {
    BAKMessageListViewController *messageList = [[BAKMessageListViewController alloc] initWithThread:thread configuration:self.configuration];
    messageList.delegate = self;
    [self.navigationController pushViewController:messageList animated:YES];
}

- (void)threadListDidTapCompose:(BAKThreadListViewController *)threadList {
    BAKAuthenticatingCreateMessageCoordinator *createThread = [[BAKAuthenticatingCreateMessageCoordinator alloc] initForNewThreadInChannel:threadList.channel viewController:self.navigationController configuration:self.configuration];
    createThread.delegate = self;
    [self.childCoordinators addObject:createThread];
    [createThread start];
}

- (void)messageListDidTapCompose:(BAKMessageListViewController *)messageList {
    BAKAuthenticatingCreateMessageCoordinator *createMessage = [[BAKAuthenticatingCreateMessageCoordinator alloc] initForExistingThread:messageList.thread viewController:self.navigationController configuration:self.configuration];
    createMessage.delegate = self;
    [self.childCoordinators addObject:createMessage];
    [createMessage start];
}

- (void)messageList:(BAKMessageListViewController *)messageList didTapAttachment:(BAKAttachment *)attachment {
    BAKAttachmentViewController *attachmentViewController = [[BAKAttachmentViewController alloc] initWithAttachment:attachment];
    [self.navigationController pushViewController:attachmentViewController animated:YES];
}

- (void)dismissBackchannel:(id)sender {
    if ([self.delegate respondsToSelector:@selector(messageCoordinatorRequestsDismissal:)]) {
        [self.delegate messageCoordinatorRequestsDismissal:self];
    }
}

- (void)editProfileCoordinatorRequestLogOut:(BAKEditProfileCoordinator *)editProfileCoordinator {
    [self logOutCurrentUser];
    [self.childCoordinators removeObject:editProfileCoordinator];
    [self setUpRightBarButton];
}

- (void)logOutCurrentUser {
    BAKLogoutRequest *logoutRequest = [[BAKLogoutRequest alloc] initWithConfiguration:self.configuration];
    [[[BAKSendableRequest alloc] initWithRequestTemplate:logoutRequest] sendRequestWithSuccessBlock:nil failureBlock:nil];
    [BAKCache clearAllCaches];
    [BAKSession closeSession];
}

- (void)showEditProfile:(id)sender {
    BAKEditProfileCoordinator *editProfile = [[BAKEditProfileCoordinator alloc] initWithViewController:self.navigationController currentUserStore:self.currentUserStore configuration:self.configuration];
    editProfile.delegate = self;
    [self.childCoordinators addObject:editProfile];
    [editProfile start];
}

- (void)editProfileCoordinator:(BAKEditProfileCoordinator *)editProfileCoordinator didUpdateUser:(BAKUser *)user {
    [self.childCoordinators removeObject:editProfileCoordinator];
}

- (void)editProfileCoordinatorDidCancel:(BAKEditProfileCoordinator *)editProfileCoordinator {
    [self.childCoordinators removeObject:editProfileCoordinator];
}

- (void)createMessageCancelled:(BAKAuthenticatingCreateMessageCoordinator *)createMessage {
    [self.childCoordinators removeObject:createMessage];
}

- (void)createMessageCompleted:(BAKAuthenticatingCreateMessageCoordinator *)createMessage onNewThread:(BAKThread *)thread {
    [self.childCoordinators removeObject:createMessage];
    BAKMessageListViewController *messageList = [[BAKMessageListViewController alloc] initWithThread:thread configuration:self.configuration];
    messageList.delegate = self;
    [self.navigationController pushViewController:messageList animated:NO];
}

- (void)createMessageCompleted:(BAKAuthenticatingCreateMessageCoordinator *)createMessage {
    [self.childCoordinators removeObject:createMessage];
}

- (void)showAuthentication:(id)sender {
    UINavigationController *navigationController = [UINavigationController new];
    BAKAuthenticationCoordinator *authCoordinator = [[BAKAuthenticationCoordinator alloc] initWithNavigationViewController:navigationController configuration:self.configuration];
    authCoordinator.delegate = self;
    [authCoordinator start];
    [self.childCoordinators addObject:authCoordinator];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

- (void)coordinatorDidAuthenticate:(BAKAuthenticationCoordinator *)coordinator {
    [coordinator.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.childCoordinators removeObject:coordinator];
    [self.currentUserStore updateFromAPI];
    [self setUpRightBarButton];
}

- (void)coordinatorDidRequestDismissal:(BAKAuthenticationCoordinator *)coordinator {
    [coordinator.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.childCoordinators removeObject:coordinator];
}

- (NSMutableArray *)childCoordinators {
    if (!_childCoordinators) {
        self.childCoordinators = [NSMutableArray array];
    }
    return _childCoordinators;
}

@end
