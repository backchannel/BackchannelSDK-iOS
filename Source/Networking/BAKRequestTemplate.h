//
//  BAKRequestTemplate.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/20/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BAKResponse <NSObject>

- (instancetype)initWithResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *)error;

@property (nonatomic, readonly) NSURLResponse *response;
@property (nonatomic, readonly) NSData *data;
@property (nonatomic, readonly) NSInteger statusCode;

@property (nonatomic) id result;
@property (nonatomic) NSError *error;

@end


@protocol BAKRemoteConfiguration <NSObject>

@property (nonatomic, readonly) NSURL *baseURL;
@property (nonatomic, readonly) NSDictionary *baseHeaders;

@end


@protocol BAKRequestTemplate <NSObject>

@property (readonly) id<BAKRemoteConfiguration> configuration;

@optional
@property (readonly) NSString *method;
@property (readonly) NSString *path;
@property (readonly) NSDictionary *parameters;
@property (readonly) NSDictionary *headers;
@property (readonly) NSString *boundary;

- (void)finalizeWithResponse:(id<BAKResponse>)response;

@end


@protocol BAKRequestBuilder <NSObject>

@property (nonatomic, readonly) id<BAKRequestTemplate> template;

@property (readonly) NSURLRequest *URLRequest;

@end

