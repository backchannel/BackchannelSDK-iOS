//
//  BAKAuthenticationButton.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKAuthenticationButton.h"
#import "BAKColor.h"

@implementation BAKAuthenticationButton

+ (id)buttonWithType:(UIButtonType)buttonType {
    UIButton *button = [super buttonWithType:buttonType];
    button.backgroundColor = [UIColor whiteColor];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    button.layer.borderColor = [BAKColor separatorColor].CGColor;
    button.layer.borderWidth = 1.0/[UIScreen mainScreen].scale;
    return (BAKAuthenticationButton *)button;
}

@end
