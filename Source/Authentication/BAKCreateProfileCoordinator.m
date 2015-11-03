//
//  BAKCreateProfileCoordinator.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/22/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKCreateProfileCoordinator.h"
#import "BAKProfileFormViewController.h"
#import "BAKUpdateProfileRequest.h"
#import "BAKSendableRequest.h"
#import "BAKUser.h"
#import "BAKChooseImageCoordinator.h"
#import "BAKAttachmentUploader.h"
#import "BAKProfile.h"
#import "BAKAttachment.h"
#import "BAKErrorPresenter.h"

@interface BAKCreateProfileCoordinator () <BAKProfileFormViewControllerDelegate, BAKImageChooserDelegate, BAKAttachmentUploaderDelegate>

@property (nonatomic) NSMutableArray *childCoordinators;
@property (nonatomic) BAKAttachmentUploader *attachmentUploader;
@property (nonatomic) BAKProfileFormViewController *profileViewController;

@end

@implementation BAKCreateProfileCoordinator

- (instancetype)initWithUser:(BAKUser *)user navigationController:(UINavigationController *)navigationController configuration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _navigationController = navigationController;
    _user = user;
    _profileViewController = [[BAKProfileFormViewController alloc] init];
    [self configureProfileForm];
    _configuration = configuration;
    
    return self;
}

- (void)configureProfileForm {
    self.profileViewController.delegate = self;
    self.profileViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Skip" style:UIBarButtonItemStylePlain target:self action:@selector(skipButtonTapped:)];
    self.profileViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveButtonTapped:)];
}

- (void)start {
    [self.profileViewController updateDisplayName:self.user.displayName];
    [self.navigationController pushViewController:self.profileViewController animated:YES];
}

- (void)saveButtonTapped:(id)sender {
    BAKProfile *profile = self.profileViewController.profile;
    [self.profileViewController.profileForm showLoadingView];
    [self.attachmentUploader waitForAttachmentUploads:^(NSArray *attachments) {
        profile.avatarAttachmentID = [attachments.firstObject ID];
        BAKUpdateProfileRequest *updateProfile = [[BAKUpdateProfileRequest alloc] initWithUserID:self.user.ID profile:profile configuration:self.configuration];
        BAKSendableRequest *sendableRequest = [[BAKSendableRequest alloc] initWithRequestTemplate:updateProfile];
        [sendableRequest sendRequestWithSuccessBlock:^(id result) {
            [self.profileViewController.profileForm hideLoadingView];
            [self informDelegateOfUpdate];
        } failureBlock:^(NSError *error) {
            [self.profileViewController.profileForm hideLoadingView];
            [[[BAKErrorPresenter alloc] initWithError:error viewController:self.profileViewController] present];
        }];
    }];
}

- (void)skipButtonTapped:(BAKProfileFormViewController *)profileViewController {
    if ([self.delegate respondsToSelector:@selector(createProfileCoordinatorDidSkip:)]) {
        [self.delegate createProfileCoordinatorDidSkip:self];
    }
}

- (void)profileViewControllerDidTapAvatarButton:(BAKProfileFormViewController *)profileViewController {
    BAKChooseImageCoordinator *imageChooser = [[BAKChooseImageCoordinator alloc] initWithViewController:self.navigationController];
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
    if ([self.delegate respondsToSelector:@selector(createProfileCoordinator:didUpdateUser:)]) {
        [self.delegate createProfileCoordinator:self didUpdateUser:self.user];
    }
}

- (NSMutableArray *)childCoordinators {
    if (!_childCoordinators) {
        self.childCoordinators = [NSMutableArray array];
    }
    return _childCoordinators;
}

@end
