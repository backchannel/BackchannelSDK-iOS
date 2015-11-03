//
//  BAKMessageFormView.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/26/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKMessageFormView.h"
#import "BAKGeometry.h"
#import "BAKMessageFormLayout.h"
#import "BAKFormField.h"
#import "BAKLoadingView.h"
#import "BAKColor.h"

@interface BAKMessageFormView ()

@property (nonatomic) BAKFormField *subjectFormField;
@property (nonatomic) BAKFormField *attachmentsFormField;
@property (nonatomic) BAKFormField *channelPickerFormField;
@property (nonatomic) UITextView *bodyField;
@property (nonatomic) BAKLoadingView *loadingView;

@end

@implementation BAKMessageFormView

- (BAKFormField *)subjectFormField {
    if (!_subjectFormField) {
        BAKFormField *subjectFormField = [[BAKFormField alloc] init];
        subjectFormField.labelText = @"Subject:";
        subjectFormField.labelTextColor = [UIColor lightGrayColor];
        subjectFormField.contentView = [self newSubjectField];
        subjectFormField.accessoryView = [self newPaperclipButton];
        [self.bodyField addSubview:subjectFormField];
        self.subjectFormField = subjectFormField;
    }
    return _subjectFormField;
}

- (UITextField *)newSubjectField {
    UITextField *subjectField = [[UITextField alloc] init];
    subjectField.borderStyle = UITextBorderStyleNone;
    subjectField.font = [UIFont systemFontOfSize:14.0f];
    subjectField.backgroundColor = [UIColor whiteColor];
    return subjectField;
}

- (UIButton *)newPaperclipButton {
    UIButton *paperclipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *paperclipImage = [[UIImage imageNamed:@"paperclip"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [paperclipButton setImage:paperclipImage forState:UIControlStateNormal];
    paperclipButton.tintColor = [BAKColor primaryTintColor];
    return paperclipButton;
}

- (UITextField *)subjectField {
    return (UITextField *)self.subjectFormField.contentView;
}

- (UIButton *)paperclipButton {
    return (UIButton *)self.subjectFormField.accessoryView;
}

- (BAKFormField *)attachmentsFormField {
    if (!_attachmentsFormField) {
        BAKFormField *attachmentsFormField = [[BAKFormField alloc] init];
        attachmentsFormField.labelText = @"Attachments:";
        attachmentsFormField.labelTextColor = [UIColor lightGrayColor];
        [self.bodyField addSubview:attachmentsFormField];
        self.attachmentsFormField = attachmentsFormField;
    }
    return _attachmentsFormField;
}

- (BAKFormField *)channelPickerFormField {
    if (!_channelPickerFormField) {
        BAKFormField *channelPickerFormField = [[BAKFormField alloc] init];
        channelPickerFormField.labelText = @"Channel:";
        channelPickerFormField.labelTextColor = [UIColor lightGrayColor];
        UITextField *textField = [channelPickerFormField setTextFieldAsContentView];
        textField.tintColor = [UIColor whiteColor];
        textField.textColor = [BAKColor primaryTintColor];
        [self.bodyField addSubview:channelPickerFormField];
        self.channelPickerFormField = channelPickerFormField;
    }
    return _channelPickerFormField;
}

- (UITextField *)channelField {
    return (UITextField *)self.channelPickerFormField.contentView;
}

- (UITextView *)bodyField {
    if (!_bodyField) {
        UITextView *bodyField = [[UITextView alloc] init];
        bodyField.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        bodyField.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        bodyField.alwaysBounceVertical = YES;
        bodyField.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:bodyField];
        
        self.originalTextContainerInset = bodyField.textContainerInset;
        self.bodyField = bodyField;
    }
    return _bodyField;
}

- (void)setLayoutInsets:(UIEdgeInsets)layoutInsets {
    _layoutInsets = layoutInsets;
    self.bodyField.contentInset = self.layoutInsets;
    self.bodyField.scrollIndicatorInsets = self.layoutInsets;
}

- (void)setAttachmentsView:(UIView *)attachmentsView {
    self.attachmentsFormField.contentView = attachmentsView;
}

- (UIView *)attachmentsView {
    return self.attachmentsFormField.contentView;
}

- (void)setSubjectFieldAsDisabledWithText:(NSString *)text {
    self.subjectField.text = text;
    self.subjectField.enabled = NO;
}

- (BAKLoadingView *)loadingView {
    if (!_loadingView) {
        BAKLoadingView *loadingView = [[BAKLoadingView alloc] init];
        loadingView.hidden = YES;
        loadingView.label.text = @"Posting...";
        [self addSubview:loadingView];
        self.loadingView = loadingView;
    }
    return _loadingView;
}

- (void)showLoadingView {
    self.loadingView.hidden = NO;
    [self.loadingView startAnimating];
}

- (void)hideLoadingView {
    self.loadingView.hidden = YES;
    [self.loadingView stopAnimating];
}

- (void)setShouldShowAttachmentsField:(BOOL)shouldShowAttachmentsField {
    _shouldShowAttachmentsField = shouldShowAttachmentsField;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    BAKMessageFormLayout *layout = [[BAKMessageFormLayout alloc]
                                    initWithWorkingRect:self.bounds
                                    layoutInsets:self.layoutInsets
                                    originalTextContainerInset:self.originalTextContainerInset
                                    shouldShowAttachmentsField:self.shouldShowAttachmentsField
                                    shouldShowChannelPicker:self.shouldShowChannelPicker];
    
    self.loadingView.frame = layout.loadingRect;
    self.bodyField.frame = layout.bodyRect;
    self.bodyField.textContainerInset = layout.bodyInset;
    self.subjectFormField.frame = layout.subjectRect;
    self.attachmentsFormField.frame = layout.attachmentsRect;
    self.channelPickerFormField.frame = layout.channelsRect;
    self.paperclipButton.hidden = self.shouldShowAttachmentsField;
}

@end
