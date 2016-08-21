//
//  BAKEmailContext.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/20/16.
//  Copyright © 2016 Backchannel. All rights reserved.
//

#import "BAKEmailContext.h"

@implementation BAKEmailContext

- (instancetype)initWithEmailAddress:(NSString *)emailAddress subject:(NSString *)subject {
    self = [super init];
    if (!self) return nil;
    
    _emailAddress = emailAddress;
    _subject = subject;
    
    return self;
}

- (NSArray *)toRecipients {
    return @[self.emailAddress];
}

@end
