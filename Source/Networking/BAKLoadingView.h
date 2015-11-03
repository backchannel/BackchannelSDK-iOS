//
//  BAKLoadingView.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/6/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAKLoadingView : UIView

- (void)startAnimating;
- (void)stopAnimating;

@property (nonatomic, readonly) UILabel *label;

@end
