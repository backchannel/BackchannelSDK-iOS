//
//  BAKLoadableView.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/13/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

@protocol BAKLoadableView <NSObject>

- (void)showLoadingView;
- (void)hideLoadingView;

@end