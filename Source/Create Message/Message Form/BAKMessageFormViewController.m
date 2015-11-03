//
//  BAKDisucssionFormViewController.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/25/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKMessageFormViewController.h"
#import "BAKThread.h"
#import "BAKAttachmentsViewController.h"
#import "BAKDraft.h"
#import "BAKAttachmentContainer.h"
#import "BAKChannel.h"
#import "BAKChannelPickerViewController.h"
#import "BAKChannelsStore.h"

@interface BAKMessageFormViewController () <BAKAttachmentsViewControllerDelegate, BAKChannelPickerDelegate>

@property (nonatomic) BAKAttachmentsViewController *attachmentsViewController;
@property (nonatomic) BAKChannelPickerViewController *channelPickerViewController;
@property (nonatomic) CGFloat currentKeyboardHeight;
@property (nonatomic) BAKChannelsStore *channelsStore;

@end

@implementation BAKMessageFormViewController

@dynamic view;

- (instancetype)initWithChannelsStore:(BAKChannelsStore *)channelsStore {
    self = [super init];
    if (!self) return nil;
    
    _channelsStore = channelsStore;
    self.messageForm.shouldShowChannelPicker = YES;
    [self setChannelInPicker:self.channelsStore.channels.firstObject];
    self.title = @"New Thread";
   
    return self;
}

- (instancetype)initForNewThread {
    self = [super init];
    if (!self) return nil;
    
    self.title = @"New Thread";
    
    return self;
}

- (instancetype)initForExistingThread:(BAKThread *)thread {
    self = [super init];
    if (!self) return nil;
    
    self.title = @"New Message";
    [self.messageForm setSubjectFieldAsDisabledWithText:thread.subject];
    
    return self;
}

- (void)loadView {
    self.view = [[BAKMessageFormView alloc] init];
}

- (BAKMessageFormView *)messageForm {
    return self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(informDelegateOfCancellation)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStyleDone target:self action:@selector(informDelegateOfPost)];
    
    self.messageForm.attachmentsView = self.attachmentsViewController.view;
    
    [self.messageForm.paperclipButton addTarget:self action:@selector(informDelegateOfAttachmentButtonPress) forControlEvents:UIControlEventTouchUpInside];
    self.messageForm.channelField.inputView = self.channelPickerViewController.view;
    
    self.currentKeyboardHeight = 0;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppeared:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDisappeared:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self updateLayoutInsets];
}

- (BOOL)automaticallyAdjustsScrollViewInsets {
    return NO;
}

- (BOOL)hasChanges {
    return ((self.messageForm.subjectField.enabled
             && self.messageForm.subjectField.text.length != 0)
            ||self.messageForm.bodyField.text.length !=0);
}

- (void)showKeyboard {
    if (self.messageForm.subjectField.enabled) {
        [self.messageForm.subjectField becomeFirstResponder];
    } else {
        [self.messageForm.bodyField becomeFirstResponder];
    }
}

- (void)updateLayoutInsets {
    CGFloat bottomLayoutInset = MAX(self.currentKeyboardHeight, [self.bottomLayoutGuide length]);
    self.messageForm.layoutInsets = UIEdgeInsetsMake([self.topLayoutGuide length], 0, bottomLayoutInset, 0);
}

- (void)keyboardAppeared:(NSNotification *)note {
    CGRect keyboardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.currentKeyboardHeight = keyboardRect.size.height;
    [self updateLayoutInsets];
}

- (void)keyboardDisappeared:(NSNotification *)note {
    self.currentKeyboardHeight = 0;
    [self updateLayoutInsets];
}

- (BAKAttachmentsViewController *)attachmentsViewController {
    if (!_attachmentsViewController) {
        BAKAttachmentsViewController *attachmentsViewController = [[BAKAttachmentsViewController alloc] initAsEditable:YES itemSize:30];
        attachmentsViewController.delegate = self;
        [self addChildViewController:attachmentsViewController];
        [attachmentsViewController didMoveToParentViewController:self];
        
        self.attachmentsViewController = attachmentsViewController;
    }
    return _attachmentsViewController;
}

- (void)setAttachmentContainers:(NSArray *)attachmentContainers {
    self.attachmentsViewController.attachmentContainers = attachmentContainers;
    self.messageForm.shouldShowAttachmentsField = (self.attachmentContainers.count > 0);
}

- (NSArray *)attachmentContainers {
    return self.attachmentsViewController.attachmentContainers;
}

- (BAKChannelPickerViewController *)channelPickerViewController {
    if (!_channelPickerViewController) {
        BAKChannelPickerViewController *channelPicker = [[BAKChannelPickerViewController alloc] initWithChannels:self.channelsStore.channels];
        [self addChildViewController:channelPicker];
        [channelPicker didMoveToParentViewController:self];
        channelPicker.delegate = self;
        self.channelPickerViewController = channelPicker;
    }
    return _channelPickerViewController;
}

- (void)channelPicker:(BAKChannelPickerViewController *)channelPicker didPickChannel:(BAKChannel *)channel {
    [self setChannelInPicker:channel];
    if ([self.delegate respondsToSelector:@selector(messageForm:didSetChannel:)]) {
        [self.delegate messageForm:self didSetChannel:channel];
    }
}

- (void)setChannelInPicker:(BAKChannel *)channel {
    self.messageForm.channelField.text = channel.name;
}

- (void)refreshChannels {
    self.channelPickerViewController.channels = self.channelsStore.channels;
}

- (void)informDelegateOfCancellation {
    if ([self.delegate respondsToSelector:@selector(messageFormDidTapCancel:)]) {
        [self.delegate messageFormDidTapCancel:self];
    }
}

- (void)informDelegateOfPost {
    BAKDraft *draft = [BAKDraft new];
    draft.body = self.messageForm.bodyField.text ?: @"";
    draft.subject = self.messageForm.subjectField.text ?: @"";
    if ([self.delegate respondsToSelector:@selector(messageForm:didTapPostWithDraft:)]) {
        [self.delegate messageForm:self didTapPostWithDraft:draft];
    }
}

- (void)attachmentsViewControllerDidTapAttachmentButton:(BAKAttachmentsViewController *)attachmentsViewController {
    [self informDelegateOfAttachmentButtonPress];
}

- (void)attachmentsViewController:(BAKAttachmentsViewController *)attachmentsViewController didTapAttachmentInContainer:(BAKAttachmentContainer *)container {
    if ([self.delegate respondsToSelector:@selector(messageForm:didTapAttachmentInContainer:)]) {
        [self.delegate messageForm:self didTapAttachmentInContainer:container];
    }
}

- (void)informDelegateOfAttachmentButtonPress {
    if ([self.delegate respondsToSelector:@selector(messageFormDidTapNewAttachmentButton:)]) {
        [self.delegate messageFormDidTapNewAttachmentButton:self];
    }
}

@end
