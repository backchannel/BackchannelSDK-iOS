//
//  BAKAttachmentViewController.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/17/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKAttachmentViewController.h"
#import "BAKAttachment.h"

@interface BAKAttachmentViewController () <UIScrollViewDelegate>

@end

@implementation BAKAttachmentViewController

@dynamic view;

- (instancetype)initWithAttachment:(BAKAttachment *)attachment {
    self = [super init];
    if (!self) return nil;
    
    self.view.backgroundColor = [UIColor whiteColor];
    _attachment = attachment;
    
    [self loadAndShowImage];
    
    return self;
}

- (void)loadView {
    self.view = [[BAKAttachmentView alloc] init];
}

- (BAKAttachmentView *)attachmentView {
    return self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.attachmentView.removeButton addTarget:self action:@selector(informDelegateOfRemoveButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showActivitySheet:)];
}

- (void)showActivitySheet:(id)sender {
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[self.attachment.image] applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (void)loadAndShowImage {
    if (self.attachment.imageLoaded) {
        self.attachmentView.attachmentImageView.image = self.attachment.image;
    } else {
        [self.attachment fetchImageWithSuccessBlock:^{
            [self loadAndShowImage];
        } failureBlock:^(NSError *error) {
            
        }];
    }
}

- (BOOL)showRemoveButton {
    return !self.attachmentView.removeButton.hidden;
}

- (void)setShowRemoveButton:(BOOL)showRemoveButton {
    self.attachmentView.removeButton.hidden = !showRemoveButton;
}

- (BOOL)automaticallyAdjustsScrollViewInsets {
    return NO;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.attachmentView.layoutInsets = UIEdgeInsetsMake([self.topLayoutGuide length], 0, [self.bottomLayoutGuide length], 0);
}

- (void)informDelegateOfRemoveButtonTap:(id)sender {
    if ([self.delegate respondsToSelector:@selector(attachmentViewController:didTapRemoveForAttachment:)]) {
        [self.delegate attachmentViewController:self didTapRemoveForAttachment:self.attachment];
    }
}

@end
