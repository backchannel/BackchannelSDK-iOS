//
//  BAKMessageMetadata.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/13/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKMessageMetadata.h"
#import "BAKAppData.h"
#import <sys/utsname.h>

@interface BAKMessageMetadata ()

@property (nonatomic) BAKAppData *appData;


@end

@implementation BAKMessageMetadata

- (BAKAppData *)appData {
    if (!_appData) {
        self.appData = [BAKAppData new];
    }
    return _appData;
}

- (NSDictionary *)metadataDictionary {
    return @{
             @"app_name": self.appData.name,
             @"app_version": self.appData.version,
             @"app_build_number": self.appData.buildNumber,
             @"os_version": self.osVersion,
             @"hardware": self.hardware,
             @"time_zone": self.timeZone,
             @"locale": self.locale,
             };
}

- (NSString *)osVersion {
    return [UIDevice currentDevice].systemVersion;
}

- (NSString *)hardware {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

- (NSString *)timeZone {
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    return [NSString stringWithFormat:@"%@ %@", [localTimeZone name], [localTimeZone isDaylightSavingTime] ? @"(Daylight)" : @""];
}

- (NSString *)locale {
    return [[NSLocale currentLocale] localeIdentifier];
}

@end
