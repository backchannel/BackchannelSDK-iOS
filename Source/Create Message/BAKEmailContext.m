//
//  BAKEmailContext.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/20/16.
//  Copyright © 2016 Backchannel. All rights reserved.
//

#import "BAKEmailContext.h"
#import <MessageUI/MessageUI.h>

@interface BAKEmailContext()

@property (nonatomic) NSString *emailAddress;
@property (nonatomic) NSString *subject;

@end

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

- (BOOL)canSendMail {
    return [MFMailComposeViewController canSendMail];
}

@end


@implementation BAKNullEmailContext

- (NSArray *)toRecipients {
    return @[];
}

- (NSString *)emailAddress {
    return @"";
}

- (NSString *)subject {
    return @"";
}

- (BOOL)canSendMail {
    return NO;
}

@end

