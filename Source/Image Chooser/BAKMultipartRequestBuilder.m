//
//  BAKMultipartRequestBuilder.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/4/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKMultipartRequestBuilder.h"
#import "BAKRequestTemplate.h"
#import "BAKSafeRequestTemplate.h"
#import "BAKRequestBuilder.h"

@interface BAKMultipartRequestBuilder ()

@property (nonatomic) BAKSafeRequestTemplate *safeTemplate;
@property (nonatomic) BAKRequestBuilder *normalRequestBuilder;

@end

@implementation BAKMultipartRequestBuilder

- (instancetype)initWithRequestTemplate:(id<BAKRequestTemplate>)template data:(NSData *)data {
    self = [super init];
    if (!self) return nil;
    
    _safeTemplate = [[BAKSafeRequestTemplate alloc] initWithTemplate:template];
    _normalRequestBuilder = [[BAKRequestBuilder alloc] initWithRequestTemplate:template];
    _data = data;
    
    return self;
}

- (id<BAKRequestTemplate>)template {
    return self.safeTemplate.unsafeTemplate;
}

- (NSString *)boundary {
    return self.safeTemplate.boundary;
}

- (NSString *)fileParamConstant {
    return @"attachment";
}

- (NSString *)filename {
    return @"filename";
}

- (NSString *)bodyStringBeforeData {
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"--%@\r\n", self.boundary];
    [string appendFormat:@"Content-Disposition: form-data; name=\"attachment\"; filename=\"filename\"\r\n"];
    [string appendFormat:@"Content-Type: %@\r\n\r\n", @"image/jpeg"];
    return string;
}

- (NSString *)bodyStringAfterData {
    return [NSString stringWithFormat:@"\r\n--%@--\r\n", self.boundary];
}

- (NSData *)HTTPBody {
    if (!self.data || self.safeTemplate.isGETRequest) {
        return nil;
    }
    NSMutableData *body = [NSMutableData data];
    [body appendData:[self.bodyStringBeforeData dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:self.data];
    [body appendData:[self.bodyStringAfterData dataUsingEncoding:NSUTF8StringEncoding]];
    return body;
}

- (NSURLRequest *)URLRequest {
    NSMutableURLRequest *mutableURLRequest = [self.normalRequestBuilder.URLRequest mutableCopy];
    mutableURLRequest.HTTPBody = [self HTTPBody];
    return [mutableURLRequest copy];
}

@end
