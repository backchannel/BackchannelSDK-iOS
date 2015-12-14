//
//  BAKChannelPickerViewController.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/13/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKChannelPickerController.h"
#import "BAKChannel.h"
#import "BAKColor.h"
#import "BAKGeometry.h"

@interface BAKChannelPickerController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) UIPickerView *pickerView;
@property (nonatomic) UIView *separatorView;
@property (nonatomic) UIView *view;


@end

@implementation BAKChannelPickerController

- (instancetype)initWithChannels:(NSArray *)channels {
    self = [super init];
    if (!self) return nil;
    
    _channels = channels;
    self.view.backgroundColor = [UIColor whiteColor];
    [self applyLayout];

    return self;
}

- (UIView *)view {
    if (!_view) {
        self.view = [[UIView alloc] init];
    }
    return _view;
}

- (UIView *)separatorView {
    if (!_separatorView) {
        UIView *separatorView = [[UIView alloc] init];
        separatorView.backgroundColor = [BAKColor separatorColor];
        [self.view addSubview:separatorView];
        self.separatorView = separatorView;
    }
    return _separatorView;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        UIPickerView *pickerView = [[UIPickerView alloc] init];
        pickerView.dataSource = self;
        pickerView.delegate = self;
        
        [self.view addSubview:pickerView];
        self.pickerView = pickerView;
    }
    return _pickerView;
}

- (void)setChannels:(NSArray *)channels {
    _channels = channels;
    [self.pickerView reloadAllComponents];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.channels.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    BAKChannel *channel = self.channels[row];
    return channel.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if ([self.delegate respondsToSelector:@selector(channelPicker:didPickChannel:)]) {
        BAKChannel *channel = self.channels[row];
        [self.delegate channelPicker:self didPickChannel:channel];
    }
}

- (void)applyLayout {
    self.view.frame = CGRectMake(0, 0, 200, 200);
    CGRect separatorRect = self.view.bounds;
    separatorRect.size.height = 1.0/[UIScreen mainScreen].scale;
    self.separatorView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;

    self.separatorView.frame = separatorRect;
    self.pickerView.frame = self.view.bounds;
    self.pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

@end
