//
//  BAKSafeRequestTemplate.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/20/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAKRequestTemplate.h"

@interface BAKSafeRequestTemplate : NSObject

- (instancetype)initWithTemplate:(id<BAKRequestTemplate>)template;

@property (nonatomic, readonly) id<BAKRequestTemplate> unsafeTemplate;

@property (readonly) id<BAKRemoteConfiguration> configuration;
@property (readonly) NSURL *baseURL;
@property (readonly) NSDictionary *baseHeaders;


@property (readonly) NSString *method;
@property (nonatomic, readonly) BOOL isGETRequest;

@property (readonly) NSString *path;
@property (readonly) NSDictionary *parameters;
@property (readonly) NSDictionary *headers;
@property (readonly) NSString *boundary;

- (void)finalizeWithResponse:(id<BAKResponse>)response;

@end

