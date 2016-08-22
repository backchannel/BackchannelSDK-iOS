//
//  BAKAuthenticatingCreateMessageCoordinator.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 10/8/15.
//  Copyright © 2015 Backchannel. All rights reserved.
//

#import "BAKAuthenticatingCreateMessageCoordinator.h"
#import "BAKSession.h"
#import "BAKEmailContext.h"
#import "BAKAuthenticationCoordinator.h"
#import "BAKCreateMessageCoordinator.h"

@interface BAKAuthenticatingCreateMessageCoordinator () <BAKAuthenticationDelegate, BAKCreateMessageDelegate>

@property (nonatomic) NSMutableArray *childCoordinators;
@property (nonatomic) UINavigationController *navigationController;
@property (nonatomic) BAKCreateMessageCoordinator *createMessageCoordinator;

@end

@implementation BAKAuthenticatingCreateMessageCoordinator

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    _navigationController = [[UINavigationController alloc] init];
    _navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    return self;
}

- (instancetype)initForNewThreadInChannel:(BAKChannel *)channel viewController:(UIViewController *)viewController emailContext:(id<BAKEmailContext>)emailContext configuration:(BAKRemoteConfiguration *)configuration {
    self = [self init];
    if (!self) return nil;

    _createMessageCoordinator = [[BAKCreateMessageCoordinator alloc] initForNewThreadInChannel:channel navigationController:self.navigationController configuration:configuration];
    _viewController = viewController;
    _configuration = configuration;
    _emailContext = emailContext;
    
    return self;
}

- (instancetype)initForExistingThread:(BAKThread *)thread viewController:(UIViewController *)viewController emailContext:(id<BAKEmailContext>)emailContext configuration:(BAKRemoteConfiguration *)configuration {
    self = [self init];
    if (!self) return nil;
    
    _createMessageCoordinator = [[BAKCreateMessageCoordinator alloc] initForExistingThread:thread navigationController:self.navigationController configuration:configuration];
    _viewController = viewController;
    _configuration = configuration;
    _emailContext = emailContext;
   
    return self;
}

- (void)start {
    [self.viewController presentViewController:self.navigationController animated:YES completion:nil];
    if ([self isLoggedIn]) {
        [self startCreation];
    } else {
        [self startAuthentication];
    }
}

- (BOOL)isLoggedIn {
    return [BAKSession currentSession].isLoggedIn;
}

- (void)startAuthentication {
    BAKAuthenticationCoordinator *authCoordinator = [[BAKAuthenticationCoordinator alloc] initWithNavigationViewController:self.navigationController emailContext:self.emailContext configuration:self.configuration];
    authCoordinator.delegate = self;
    [authCoordinator start];
    [self.childCoordinators addObject:authCoordinator];
}

- (void)startCreation {
    self.createMessageCoordinator.delegate = self;
    [self.createMessageCoordinator start];
    [self.childCoordinators addObject:self.childCoordinators];
}

- (void)coordinatorDidAuthenticate:(BAKAuthenticationCoordinator *)coordinator {
    [self.childCoordinators removeObject:coordinator];
    [self startCreation];
}

- (void)coordinatorDidRequestDismissal:(BAKAuthenticationCoordinator *)coordinator {
    [self.childCoordinators removeObject:coordinator];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self informDelegateOfCancellation];
}

- (void)createMessageCancelled:(BAKCreateMessageCoordinator *)createMessage {
    [self.childCoordinators removeObject:createMessage];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self informDelegateOfCancellation];
}

- (void)createMessageCompleted:(BAKCreateMessageCoordinator *)createMessage {
    [self.childCoordinators removeObject:createMessage];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    if ([self.delegate respondsToSelector:@selector(createMessageCompleted:)]) {
        [self.delegate createMessageCompleted:self];
    }
}

- (void)createMessageCompleted:(BAKCreateMessageCoordinator *)createMessage onNewThread:(BAKThread *)thread {
    [self.childCoordinators removeObject:createMessage];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    if ([self.delegate respondsToSelector:@selector(createMessageCompleted:onNewThread:)]) {
        [self.delegate createMessageCompleted:self onNewThread:thread];
    }
}

- (void)informDelegateOfCancellation {
    if ([self.delegate respondsToSelector:@selector(createMessageCancelled:)]) {
        [self.delegate createMessageCancelled:self];
    }
}

- (NSMutableArray *)childCoordinators {
    if (!_childCoordinators) {
        self.childCoordinators = [NSMutableArray array];
    }
    return _childCoordinators;
}

@end
