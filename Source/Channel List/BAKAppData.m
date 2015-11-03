//
//  BAKAppData.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/31/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKAppData.h"

@implementation BAKAppData

- (NSString *)iconName {
    return [[self appInfoDictionary][@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"] lastObject];
}

- (UIImage *)icon {
    return [UIImage imageNamed:[self iconName]];
}

- (NSString *)nameAndVersion {
    return [NSString stringWithFormat:@"%@ %@", [self name], [self version]];
}

- (NSString *)name {
    return [self appInfoDictionary][@"CFBundleName"];
}

- (NSString *)version {
    return [self appInfoDictionary][@"CFBundleShortVersionString"];
}

- (NSString *)buildNumber {
    return [self appInfoDictionary][@"CFBundleVersion"];
}

- (NSDictionary *)appInfoDictionary {
    return [[NSBundle mainBundle] infoDictionary];
}

@end
