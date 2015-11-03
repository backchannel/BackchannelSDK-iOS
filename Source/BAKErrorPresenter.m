//
//  BAKErrorPresenter.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/10/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKErrorPresenter.h"

@implementation BAKErrorPresenter

- (instancetype)initWithError:(NSError *)error viewController:(UIViewController *)viewController {
    self = [super init];
    if (!self) return nil;
    
    _error = error;
    _viewController = viewController;
    
    return self;
}

- (UIAlertAction *)okayAction {
    return [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
}

- (UIAlertController *)alert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.error.localizedDescription message:self.error.localizedFailureReason preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:self.okayAction];
    return alert;
}

- (void)present {
    [self.viewController presentViewController:self.alert animated:YES completion:nil];
}

@end
