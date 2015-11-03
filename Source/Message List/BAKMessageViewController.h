//
//  BAKMessageViewController.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/10/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAKMessageView.h"

@class BAKMessageViewController, BAKAttachment;

@protocol BAKMessageViewControllerDelegate <NSObject>

- (void)messageViewController:(BAKMessageViewController *)messageViewController didTapAttachment:(BAKAttachment *)attachment;

@end

@class BAKMessage, BAKMessageView;

@interface BAKMessageViewController : UIViewController

@property (nonatomic) BAKMessage *message;
@property (nonatomic) BAKMessageView *view;

@property (nonatomic, weak) id<BAKMessageViewControllerDelegate> delegate;

@end
