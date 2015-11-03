//
//  BAKUploadAttachmentRequest.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/4/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKUploadAttachmentRequest.h"
#import "BAKRequestTemplate.h"
#import "BAKAttachment.h"

@implementation BAKUploadAttachmentRequest

- (instancetype)initWithConfiguration:(BAKRemoteConfiguration *)configuration {
    self = [super init];
    if (!self) return nil;
    
    _configuration = configuration;
    
    return self;
}

- (NSString *)method {
    return @"POST";
}

- (NSString *)path {
    return @"api/v1/attachments";
}

- (NSDictionary *)headers {
    return @{
             @"Accept": @"application/json",
             @"Content-Type": self.contentType,
             };
}

- (NSString *)contentType {
    return [NSString stringWithFormat:@"multipart/form-data; boundary=\"%@\"", self.boundary];
}

- (NSString *)boundary {
    return @"BackchannelNczcJGcxe";
}

- (void)finalizeWithResponse:(id<BAKResponse>)response {
    if (!response.error) {
        response.result = [[BAKAttachment alloc] initWithDictionary:response.result[@"attachment"]];
    }
}

@end
