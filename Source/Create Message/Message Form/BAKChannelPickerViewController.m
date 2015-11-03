//
//  BAKChannelPickerViewController.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/13/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKChannelPickerViewController.h"
#import "BAKChannel.h"
#import "BAKColor.h"
#import "BAKGeometry.h"

@interface BAKChannelPickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) UIPickerView *pickerView;
@property (nonatomic) UIView *separatorView;

@end

@implementation BAKChannelPickerViewController

- (instancetype)initWithChannels:(NSArray *)channels {
    self = [super init];
    if (!self) return nil;
    
    _channels = channels;
    self.view.backgroundColor = [UIColor whiteColor];
    
    return self;
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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect separatorRect = self.view.bounds;
    separatorRect.size.height = 1.0/[UIScreen mainScreen].scale;
    self.separatorView.frame = separatorRect;
    self.pickerView.frame = self.view.bounds;
}

@end
