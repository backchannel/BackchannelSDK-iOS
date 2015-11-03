//
//  BAKProfile.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/22/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKProfile.h"

@implementation BAKProfile

- (NSString *)avatarAttachmentID {
    return _avatarAttachmentID ?: @"";
}

- (NSString *)displayName {
    return _displayName ?: @"";
}

- (NSString *)bio {
    return _bio ?: @"";
}

@end
