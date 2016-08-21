//
//  BAKEmailContext.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/20/16.
//  Copyright © 2016 Backchannel. All rights reserved.
//

#import "BAKEmailContext.h"

@implementation BAKEmailContext

- (instancetype)initWithEmailAddress:(NSString *)emailAddress {
    self = [super init];
    if (!self) return nil;
    
    _emailAddress = emailAddress;
    
    return self;
}

- (NSURL *)emailURL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", self.emailAddress]];
}

@end
