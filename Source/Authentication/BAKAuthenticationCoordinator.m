//
//  BAKAuthenticationController.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/17/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKAuthenticationCoordinator.h"
#import "BAKCreateProfileCoordinator.h"
#import "BAKFirstRunViewController.h"
#import "BAKAuthenticationViewController.h"
#import "BAKSendableRequest.h"
#import "BAKSignInRequest.h"
#import "BAKCreateAccountRequest.h"
#import "BAKSession.h"
#import "BAKErrorPresenter.h"
#import "BAKLoadableView.h"
#import "BAKAuthenticationData.h"
#import "BAKForgotPasswordViewController.h"
#import "BAKForgotPasswordRequest.h"
#import "BAKCurrentUserStore.h"
#import "BAKEmailContext.h"
#import <MessageUI/MessageUI.h>

NSString *BAKAuthenticationCoordinatorDidLogUserIn = @"BAKAuthenticationCoordinatorDidLogUserIn";

@interface BAKAuthenticationCoordinator () <BAKFirstRunViewControllerDelegate, BAKAuthenticationViewControllerDelegate, BAKCreateProfileDelegate, BAKForgotPasswordViewControllerDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic) NSMutableArray *childCoordinators;
@property (nonatomic) BOOL requestInProgress;

@end

@implementation BAKAuthenticationCoordinator

- (instancetype)initWithNavigationViewController:(UINavigationController *)navigationController emailContext:(id<BAKEmailContext>)emailContext configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _navigationController = navigationController;
    _emailContext = emailContext;
    _configuration = configuration;
    
    return self;
}

- (void)start {
    BAKFirstRunViewController *firstRunViewcontroller = [[BAKFirstRunViewController alloc] initWithEmailButtonShowing:self.emailContext.canSendMail];
    firstRunViewcontroller.delegate = self;
    firstRunViewcontroller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStylePlain target:self action:@selector(dismissBackchannel:)];
    [self.navigationController pushViewController:firstRunViewcontroller animated:NO];
}

- (void)firstRunViewControllerDidTapCreateAccount:(BAKFirstRunViewController *)firstRunViewController {
    BAKAuthenticationViewController *createAccountViewController = [[BAKAuthenticationViewController alloc] initWithAuthenticationData:[BAKAuthenticationData createAccountData]];
    [createAccountViewController showKeyboard];
    createAccountViewController.delegate = self;
    [self.navigationController pushViewController:createAccountViewController animated:YES];
}

- (void)firstRunViewControllerDidTapSignIn:(BAKFirstRunViewController *)firstRunViewController {
    BAKAuthenticationViewController *signInViewController = [[BAKAuthenticationViewController alloc] initWithAuthenticationData:[BAKAuthenticationData signInData]];
    [signInViewController showKeyboard];
    signInViewController.delegate = self;
    [self.navigationController pushViewController:signInViewController animated:YES];
}

- (void)firstRunViewControllerDidTapPostViaEmail:(BAKFirstRunViewController *)firstRunViewController {
    MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
    [mailComposeViewController setToRecipients:self.emailContext.toRecipients];
    [mailComposeViewController setSubject:self.emailContext.subject];
        mailComposeViewController.mailComposeDelegate = self;
    [firstRunViewController presentViewController:mailComposeViewController animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)authenticationViewController:(BAKAuthenticationViewController *)authenticationViewController didTapForgotPasswordButtonWithEmail:(NSString *)email {
    BAKForgotPasswordViewController *forgotPasswordViewController = [[BAKForgotPasswordViewController alloc] initWithEmail:email];
    forgotPasswordViewController.delegate = self;
    [authenticationViewController.navigationController pushViewController:forgotPasswordViewController animated:YES];
}

- (void)forgotPasswordViewController:(BAKForgotPasswordViewController *)forgotPasswordViewController didTapResetWithEmail:(NSString *)email {
    BAKForgotPasswordRequest *request = [[BAKForgotPasswordRequest alloc] initWithEmail:email configuration:self.configuration];
    BAKSendableRequest *sendableRequest = [[BAKSendableRequest alloc] initWithRequestTemplate:request];
    [sendableRequest sendRequestWithSuccessBlock:^(id result) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Password reset email sent" message:@"Check your email for a link to reset your password." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [forgotPasswordViewController presentViewController:alert animated:YES completion:nil];
    } failureBlock:^(NSError *error) {
        [[[BAKErrorPresenter alloc] initWithError:error viewController:forgotPasswordViewController] present];
    }];
}

- (void)authenticationViewController:(BAKAuthenticationViewController *)authenticationViewController didTapActionButtonWithEmail:(NSString *)email password:(NSString *)password {
    if (authenticationViewController.data.authenticationType == BAKAuthenticationTypeCreateAccount) {
        [self createAccountFromViewController:authenticationViewController withEmail:email password:password];
    } else {
        [self signInFromViewController:authenticationViewController withEmail:email password:password];
    }
}

- (void)signInFromViewController:(BAKAuthenticationViewController *)viewController withEmail:(NSString *)email password:(NSString *)password {
    BAKSignInRequest *signInRequest = [[BAKSignInRequest alloc] initWithEmail:email password:password configuration:self.configuration];
    [self signInOrCreateAccountWithRequest:signInRequest onLoadableView:viewController.authenticationForm completion:^(BAKSession *session){
        [self informDelegateOfSuccess];
    }];
}

- (void)createAccountFromViewController:(BAKAuthenticationViewController *)viewController withEmail:(NSString *)email password:(NSString *)password {
    BAKCreateAccountRequest *createAccountRequest = [[BAKCreateAccountRequest alloc] initWithEmail:email password:password configuration:self.configuration];
    [self signInOrCreateAccountWithRequest:createAccountRequest onLoadableView:viewController.authenticationForm completion:^(BAKSession *session){
        BAKCreateProfileCoordinator *createProfileCoordinator = [[BAKCreateProfileCoordinator alloc] initWithUser:session.user navigationController:viewController.navigationController configuration:self.configuration];
        createProfileCoordinator.delegate = self;
        [self.childCoordinators addObject:createProfileCoordinator];
        [createProfileCoordinator start];
    }];
}

- (void)createProfileCoordinator:(BAKCreateProfileCoordinator *)profileCoordinator didUpdateUser:(BAKUser *)user {
    [self.navigationController popViewControllerAnimated:NO];
    [self.childCoordinators removeObject:profileCoordinator];
    [self informDelegateOfSuccess];
}

- (void)createProfileCoordinatorDidSkip:(BAKCreateProfileCoordinator *)createProfileCoordinator {
    [self.navigationController popViewControllerAnimated:NO];
    [self.childCoordinators removeObject:createProfileCoordinator];
    [self informDelegateOfSuccess];
}

- (void)signInOrCreateAccountWithRequest:(id<BAKRequestTemplate>)request onLoadableView:(id<BAKLoadableView>)loadableView completion:(void (^)(BAKSession *session))completion {
    if (self.requestInProgress == YES) {
        return;
    }
    self.requestInProgress = YES;
    [loadableView showLoadingView];
    BAKSendableRequest *signInRequest = [[BAKSendableRequest alloc] initWithRequestTemplate:request];
    [signInRequest sendRequestWithSuccessBlock:^(BAKSession *session) {
        [loadableView hideLoadingView];
        BAKCurrentUserStore *currentUserStore = [[BAKCurrentUserStore alloc] initWithConfiguration:self.configuration];
        currentUserStore.currentUser = session.user;
        self.requestInProgress = NO;
        if (completion) {
            completion(session);
        }
    } failureBlock:^(NSError *error) {
        [loadableView hideLoadingView];
        self.requestInProgress = NO;
        [[[BAKErrorPresenter alloc] initWithError:error viewController:self.navigationController] present];
    }];
}

- (void)informDelegateOfSuccess {
    [self.navigationController popViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:BAKAuthenticationCoordinatorDidLogUserIn object:[BAKSession currentSession]];
    if ([self.delegate respondsToSelector:@selector(coordinatorDidAuthenticate:)]) {
        [self.delegate coordinatorDidAuthenticate:self];
    }
}

- (void)dismissBackchannel:(id)sender {
    if ([self.delegate respondsToSelector:@selector(coordinatorDidRequestDismissal:)]) {
        [self.delegate coordinatorDidRequestDismissal:self];
    }
}


- (NSMutableArray *)childCoordinators {
    if (!_childCoordinators) {
        self.childCoordinators = [NSMutableArray array];
    }
    return _childCoordinators;
}

@end
