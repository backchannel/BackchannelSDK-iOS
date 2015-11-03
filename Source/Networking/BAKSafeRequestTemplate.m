//
//  BAKSafeRequestTemplate.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/20/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKSafeRequestTemplate.h"

@implementation BAKSafeRequestTemplate

- (instancetype)initWithTemplate:(id<BAKRequestTemplate>)template {
    self = [super init];
    if (!self) return nil;
    
    _unsafeTemplate = template;
    
    return self;
}

- (NSString *)method {
    if ([self.unsafeTemplate respondsToSelector:@selector(method)]) {
        return [self.unsafeTemplate method];
    }
    return @"GET";
}

- (BOOL)isGETRequest {
    return [self.method isEqualToString:@"GET"];
}

- (id<BAKRemoteConfiguration>)configuration {
    if ([self.unsafeTemplate respondsToSelector:@selector(configuration)]) {
        return [self.unsafeTemplate configuration];
    }
    return nil;
}

- (NSDictionary *)baseHeaders {
    if ([self.configuration respondsToSelector:@selector(baseHeaders)]) {
        return [self.configuration baseHeaders];
    }
    return nil;
}

- (NSURL *)baseURL {
    if ([self.configuration respondsToSelector:@selector(baseURL)]) {
        return [self.configuration baseURL];
    }
    return nil;
}


- (NSString *)path {
    if ([self.unsafeTemplate respondsToSelector:@selector(path)]) {
        return [self.unsafeTemplate path];
    }
    return nil;
}

- (NSDictionary *)parameters {
    if ([self.unsafeTemplate respondsToSelector:@selector(parameters)]) {
        return [self.unsafeTemplate parameters];
    }
    return nil;
}

- (NSDictionary *)headers {
    if ([self.unsafeTemplate respondsToSelector:@selector(headers)]) {
        return [self.unsafeTemplate headers];
    }
    return nil;
}

- (NSString *)boundary {
    if ([self.unsafeTemplate respondsToSelector:@selector(boundary)]) {
        return [self.unsafeTemplate boundary];
    }
    return nil;
}

- (void)finalizeWithResponse:(id<BAKResponse>)response {
    if ([self.unsafeTemplate respondsToSelector:@selector(finalizeWithResponse:)]) {
        [self.unsafeTemplate finalizeWithResponse:response];
    }
}

@end
