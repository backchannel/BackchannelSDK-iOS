//
//  BAKEditProfileCoordinator.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/7/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKEditProfileCoordinator.h"
#import "BAKProfileFormViewController.h"
#import "BAKUpdateProfileRequest.h"
#import "BAKSendableRequest.h"
#import "BAKUser.h"
#import "BAKChooseImageCoordinator.h"
#import "BAKAttachmentUploader.h"
#import "BAKProfile.h"
#import "BAKAttachment.h"
#import "BAKErrorPresenter.h"
#import "BAKCurrentUserStore.h"
#import "BAKCache.h"

@interface BAKEditProfileCoordinator () <BAKProfileFormViewControllerDelegate, BAKImageChooserDelegate, BAKAttachmentUploaderDelegate>

@property (nonatomic) NSMutableArray *childCoordinators;
@property (nonatomic) BAKAttachmentUploader *attachmentUploader;
@property (nonatomic) BAKProfileFormViewController *profileViewController;

@end


@implementation BAKEditProfileCoordinator

- (instancetype)initWithViewController:(UIViewController *)viewController currentUserStore:(BAKCurrentUserStore *)currentUserStore configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _viewController = viewController;
    _currentUserStore = currentUserStore;
    _profileViewController = [[BAKProfileFormViewController alloc] init];
    [self configureProfileForm];
    _configuration = configuration;
    
    return self;
}

- (void)configureProfileForm {
    [self fillFormWithData];
    
    self.profileViewController.profileForm.logoutButton.hidden = NO;
    
    self.profileViewController.delegate = self;
    self.profileViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonTapped:)];
    self.profileViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveButtonTapped:)];
    
    [self.profileViewController.profileForm.logoutButton addTarget:self action:@selector(informDelegateOfLogout:) forControlEvents:UIControlEventTouchUpInside];
}

- (BAKUser *)currentUser {
    return self.currentUserStore.currentUser;
}

- (void)fillFormWithData {
    BAKProfileFormView *profileForm = self.profileViewController.profileForm;
    BAKUser *currentUser = self.currentUser;
    profileForm.displayNameField.text = currentUser.displayName;
    profileForm.bioField.text = currentUser.bio;
    if (currentUser.avatar.imageLoaded) {
        [profileForm.avatarButton setImage:currentUser.avatar.image forState:UIControlStateNormal];
    } else {
        [currentUser.avatar fetchImageWithSuccessBlock:^{
            [self fillFormWithData];
        } failureBlock:nil];
    }
}

- (void)start {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.profileViewController];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.viewController presentViewController:navigationController animated:YES completion:nil];
}

- (void)saveButtonTapped:(id)sender {
    BAKProfile *profile = self.profileViewController.profile;
    [self.profileViewController.profileForm showLoadingView];
    [self.attachmentUploader waitForAttachmentUploads:^(NSArray *attachments) {
        profile.avatarAttachmentID = [attachments.firstObject ID];
        BAKUpdateProfileRequest *updateProfile = [[BAKUpdateProfileRequest alloc] initWithUserID:self.currentUserStore.currentUser.ID profile:profile configuration:self.configuration];
        BAKSendableRequest *sendableRequest = [[BAKSendableRequest alloc] initWithRequestTemplate:updateProfile];
        [sendableRequest sendRequestWithSuccessBlock:^(id result) {
            [BAKCache clearAllCaches];
            self.currentUserStore.currentUser = result;
            [self.profileViewController.profileForm hideLoadingView];
            [self informDelegateOfUpdate];
        } failureBlock:^(NSError *error) {
            [self.profileViewController.profileForm hideLoadingView];
            [[[BAKErrorPresenter alloc] initWithError:error viewController:self.profileViewController] present];
        }];
    }];
}

- (void)cancelButtonTapped:(id)sender {
    [self.profileViewController dismissViewControllerAnimated:YES completion:nil];
    if ([self.delegate respondsToSelector:@selector(editProfileCoordinatorDidCancel:)]) {
        [self.delegate editProfileCoordinatorDidCancel:self];
    }
}

- (void)profileViewControllerDidTapAvatarButton:(BAKProfileFormViewController *)profileViewController {
    BAKChooseImageCoordinator *imageChooser = [[BAKChooseImageCoordinator alloc] initWithViewController:self.profileViewController];
    imageChooser.delegate = self;
    [self.childCoordinators addObject:imageChooser];
    [imageChooser start];
}

- (void)imageChooserDidCancel:(BAKChooseImageCoordinator *)imageChooser {
    [self.childCoordinators removeObject:imageChooser];
}

- (void)imageChooser:(BAKChooseImageCoordinator *)imageChooser didChooseImage:(UIImage *)image data:(NSData *)data {
    [self.attachmentUploader uploadAttachmentWithData:data placeholderImage:image];
    [self.childCoordinators removeObject:imageChooser];
}

- (void)uploader:(BAKAttachmentUploader *)attachmentUploader updatedAttachments:(NSArray *)attachments {
    BAKAttachment *attachment = attachments.firstObject;
    [self.profileViewController updateAvatarButtonWithImage:attachment.image];
}

- (BAKAttachmentUploader *)attachmentUploader {
    if (!_attachmentUploader) {
        BAKAttachmentUploader *attachmentUploader = [[BAKAttachmentUploader alloc] initWithConfiguration:self.configuration];
        attachmentUploader.delegate = self;
        
        self.attachmentUploader = attachmentUploader;
    }
    return _attachmentUploader;
}

- (void)informDelegateOfUpdate {
    [self.profileViewController dismissViewControllerAnimated:YES completion:nil];
    if ([self.delegate respondsToSelector:@selector(editProfileCoordinator:didUpdateUser:)]) {
        [self.delegate editProfileCoordinator:self didUpdateUser:self.currentUser];
    }
}

- (void)informDelegateOfLogout:(id)sender {
    [self.profileViewController dismissViewControllerAnimated:YES completion:nil];
    if ([self.delegate respondsToSelector:@selector(editProfileCoordinatorRequestLogOut:)]) {
        [self.delegate editProfileCoordinatorRequestLogOut:self];
    }
}

- (NSMutableArray *)childCoordinators {
    if (!_childCoordinators) {
        self.childCoordinators = [NSMutableArray array];
    }
    return _childCoordinators;
}

@end
