//
//  BAKErrorPresenter.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/10/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface BAKErrorPresenter : NSObject

- (instancetype)initWithError:(NSError *)error viewController:(UIViewController *)viewController;

@property (nonatomic, readonly) NSError *error;
@property (nonatomic, readonly) UIViewController *viewController;

- (void)present;

@end
