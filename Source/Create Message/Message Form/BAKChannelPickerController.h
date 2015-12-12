//
//  BAKChannelPickerViewController.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/13/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BAKChannelPickerController, BAKChannel;

@protocol BAKChannelPickerDelegate <NSObject>

- (void)channelPicker:(BAKChannelPickerController *)channelPicker didPickChannel:(BAKChannel *)channel;

@end

@interface BAKChannelPickerController : NSObject

@property (nonatomic, readonly) UIView *view;


- (instancetype)initWithChannels:(NSArray *)channels;

@property (nonatomic) NSArray *channels;

@property (nonatomic, weak) id<BAKChannelPickerDelegate> delegate;

@end
