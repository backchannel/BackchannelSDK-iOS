//
//  BAKPaginatableRequest.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKPaginatableRequest.h"

@implementation BAKPaginatableRequest

- (instancetype)initWithRequestTemplate:(id<BAKRequestTemplate>)template {
    return [self initWithRequestTemplate:template page:1];
}

- (instancetype)initWithRequestTemplate:(id<BAKRequestTemplate>)template page:(NSInteger)page {
    self = [super init];
    if (!self) return nil;
    
    _template = template;
    _page = page;
    
    return self;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.template;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [self.template respondsToSelector:aSelector] || [super respondsToSelector:aSelector];
}

- (id<BAKRemoteConfiguration>)configuration {
    return self.template.configuration;
}

- (NSString *)pageAsString {
    return [NSString stringWithFormat:@"%@", @(self.page)];
}

- (NSDictionary *)parameters {
    NSMutableDictionary *dictionary = [@{@"page": self.pageAsString} mutableCopy];
    if ([self.template respondsToSelector:@selector(parameters)]) {
        [dictionary addEntriesFromDictionary:self.template.parameters];
    }
    return [dictionary copy];
}

- (BAKPaginatableRequest *)requestForNextPage {
    return [[BAKPaginatableRequest alloc] initWithRequestTemplate:self.template page:self.page+1];
}

@end
