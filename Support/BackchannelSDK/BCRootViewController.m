//
//  BCRootViewController.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/10/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BCRootViewController.h"
#import "Backchannel.h"

@implementation BCRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *modalButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [modalButton setTitle:@"Present Backchannel modally" forState:UIControlStateNormal];
    modalButton.frame = CGRectMake(0, 100, self.view.bounds.size.width, 100);
    [modalButton addTarget:self action:@selector(presentBackchannelModally:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:modalButton];
    
    UIButton *screenshotButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [screenshotButton setTitle:@"Fake a screenshot" forState:UIControlStateNormal];
    screenshotButton.frame = CGRectMake(0, 200, self.view.bounds.size.width, 100);
    [screenshotButton addTarget:self action:@selector(fakeAScreenshotNotification:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:screenshotButton];

}

- (void)fakeAScreenshotNotification:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationUserDidTakeScreenshotNotification object:[UIApplication sharedApplication]];
}

- (void)presentBackchannelModally:(id)sender {
    [[Backchannel backchannel] presentModallyOverViewController:self];
}

@end
