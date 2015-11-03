//
//  BAKRequestBuilder.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/21/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKRequestBuilder.h"
#import "BAKRequestTemplate.h"
#import "BAKSafeRequestTemplate.h"

@interface BAKRequestBuilder ()

@property (nonatomic) BAKSafeRequestTemplate *safeTemplate;

@end

@implementation BAKRequestBuilder

- (instancetype)initWithRequestTemplate:(id<BAKRequestTemplate>)template {
    self = [super init];
    if (!self) return nil;
    
    _safeTemplate = [[BAKSafeRequestTemplate alloc] initWithTemplate:template];
    
    return self;
}

- (id<BAKRequestTemplate>)template {
    return self.safeTemplate.unsafeTemplate;
}

- (NSData *)HTTPBody {
    if (!self.safeTemplate.parameters || self.safeTemplate.isGETRequest) {
        return nil;
    }
    return [NSJSONSerialization dataWithJSONObject:self.safeTemplate.parameters options:0 error:nil];
}

- (NSURL *)URL {
    NSURLComponents *URLComponents = [NSURLComponents componentsWithURL:self.safeTemplate.configuration.baseURL resolvingAgainstBaseURL:YES];
    NSString *path = [URLComponents.path stringByAppendingString:self.safeTemplate.path];
    URLComponents.path = path;
    if (self.safeTemplate.isGETRequest) {
        URLComponents.queryItems = [[self parametersAsQueryItems] arrayByAddingObjectsFromArray:URLComponents.queryItems];
    }
    return URLComponents.URL;
}

- (NSArray *)parametersAsQueryItems {
    NSMutableArray *queryItems = [NSMutableArray array];
    [self.safeTemplate.parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:obj]];
    }];
    return queryItems;
}

- (NSDictionary *)allHeaders {
    NSMutableDictionary *headers = [self.safeTemplate.baseHeaders mutableCopy];
    [headers addEntriesFromDictionary:self.safeTemplate.headers];
    return [headers copy];
}

- (NSURLRequest *)URLRequest {
    NSMutableURLRequest *mutableURLRequest = [[NSMutableURLRequest alloc] init];
    mutableURLRequest.HTTPMethod = self.safeTemplate.method;
    mutableURLRequest.HTTPBody = [self HTTPBody];
    mutableURLRequest.URL = [self URL];
    [self.allHeaders enumerateKeysAndObjectsUsingBlock:^(NSString *fieldName, NSString *value, BOOL *stop) {
        [mutableURLRequest addValue:value forHTTPHeaderField:fieldName];
    }];
    return [mutableURLRequest copy];
}

@end
