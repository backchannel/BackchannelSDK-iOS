//
//  BAKViewControllerRecycler.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface BAKViewControllerRecycler : NSObject

- (instancetype)initWithViewControllerClass:(Class)viewControllerClass parentViewController:(UIViewController *)parentViewController;

@property (nonatomic) Class viewControllerClass;
@property (nonatomic) UIViewController *parentViewController;


- (id)recycledOrNewViewController;
- (void)recycleViewControllerAtIndexPath:(NSIndexPath *)indexPath;
- (void)hangOnToViewController:(id)viewController atIndexPath:(NSIndexPath *)indexPath;

@end
