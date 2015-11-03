//
//  BAKColor.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKColor.h"

@implementation BAKColor

+ (UIColor *)primaryTintColor {
    return [UIColor colorWithRed:0 green:0.47 blue:1 alpha:1];
}

+ (UIColor *)separatorColor {
    return [UIColor lightGrayColor];
}

+ (UIColor *)grayBackgroundColor {
    return [UIColor colorWithWhite:0.93 alpha:1];
}

+ (UIColor *)imagePlaceholderColor {
    return [UIColor lightGrayColor];
}

+ (UIColor *)logoutColor {
    return [UIColor colorWithRed:0.992 green:0.051 blue:0.106 alpha:1.0f];
}

@end
