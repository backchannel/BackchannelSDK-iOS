//
//  BAKScreenshotDetectionCoordinator.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/13/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKScreenshotDetectionCoordinator.h"
#import "BAKCreateMessageCoordinator.h"
#import "BAKChannelsStore.h"
#import "BAKAssetFetcher.h"
#import "BAKSession.h"
#import "BAKAuthenticationCoordinator.h"

@interface BAKScreenshotDetectionCoordinator () <BAKAuthenticationDelegate, BAKCreateMessageDelegate>

@property (nonatomic) NSMutableArray *childCoordinators;
@property (nonatomic) BAKChannelsStore *channelsStore;
@property (nonatomic, readonly) UINavigationController *navigationController;

@end

@implementation BAKScreenshotDetectionCoordinator

- (instancetype)initWithViewController:(UIViewController *)viewController configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _navigationController = [[UINavigationController alloc] init];
    _navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    _viewController = viewController;
    _configuration = configuration;
    _channelsStore = [[BAKChannelsStore alloc] initWithConfiguration:self.configuration];
    [_channelsStore updateFromAPI];
    
    return self;
}

- (NSString *)alertMessage {
    return ([self isLoggedIn] ?
            @"Would you like to post this for discussion on Backchannel?" :
            @"Would you like to post this for discussion on the beta feedback forum Backchannel?");
}

- (void)start {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Screenshot Detected" message:self.alertMessage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Post" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self startCoordinator];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self.viewController presentViewController:alertController animated:YES completion:nil];
}

- (void)startCoordinator {
    [self.viewController presentViewController:self.navigationController animated:YES completion:nil];
    if ([self isLoggedIn]) {
        [self showMessageForm];
    } else {
        [self showAuthentication];
    }
}

- (BOOL)isLoggedIn {
    return [BAKSession currentSession].isLoggedIn;
}

- (void)showMessageForm {
    BAKCreateMessageCoordinator *coordinator = [[BAKCreateMessageCoordinator alloc] initWithChannelsStore:self.channelsStore navigationController:self.navigationController configuration:self.configuration];
    coordinator.delegate = self;
    [self.childCoordinators addObject:coordinator];
    [coordinator start];
    [self getAndAttachLastScreenshotToCoordinator:coordinator];
}

- (void)createMessageCancelled:(BAKCreateMessageCoordinator *)createMessage {
    [self finalizeWithCoordinator:createMessage];
}

- (void)createMessageCompleted:(BAKCreateMessageCoordinator *)createMessage {
    [self finalizeWithCoordinator:createMessage];
}

- (void)createMessageCompleted:(BAKCreateMessageCoordinator *)createMessage onNewThread:(BAKThread *)thread {
    [self finalizeWithCoordinator:createMessage];
}

- (void)finalizeWithCoordinator:(id)coordinator {
    [self.childCoordinators removeObject:coordinator];
    if ([self.delegate respondsToSelector:@selector(screenshotDetectionCoordinatorCompleted:)]) {
        [self.delegate screenshotDetectionCoordinatorCompleted:self];
    }
}

- (void)showAuthentication {
    BAKAuthenticationCoordinator *authCoordinator = [[BAKAuthenticationCoordinator alloc] initWithNavigationViewController:self.navigationController configuration:self.configuration];
    authCoordinator.delegate = self;
    [authCoordinator start];
    [self.childCoordinators addObject:authCoordinator];
}

- (void)coordinatorDidAuthenticate:(BAKAuthenticationCoordinator *)coordinator {
    [self.childCoordinators removeObject:coordinator];
    [self showMessageForm];
}

- (void)coordinatorDidRequestDismissal:(BAKAuthenticationCoordinator *)coordinator {
    [self finalizeWithCoordinator:coordinator];
}

- (void)getAndAttachLastScreenshotToCoordinator:(BAKCreateMessageCoordinator *)coordinator {
    [[BAKAssetFetcher new] fetchMostRecentScreenshot:^(NSData *data) {
        [coordinator attachImageWithData:data placeholderImage:[UIImage imageWithData:data]];
    }];
}

- (NSMutableArray *)childCoordinators {
    if (!_childCoordinators) {
        self.childCoordinators = [NSMutableArray array];
    }
    return _childCoordinators;
}

@end
