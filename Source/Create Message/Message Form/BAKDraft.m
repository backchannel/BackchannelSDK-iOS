//
//  BAKDraft.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/6/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKDraft.h"

@implementation BAKDraft

- (NSArray *)attachmentIDs {
    return [self.attachments valueForKey:@"ID"];
}

@end
