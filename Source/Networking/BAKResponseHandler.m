//
//  BAKResponseHandler.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/21/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKResponseHandler.h"


NSString *BAKErrorDomain = @"io.backchannel.APIError";
NSString *BAKSignificantErrorKey = @"BAKSignificantErrorKey";

@interface BAKResponseHandler ()

@end

@implementation BAKResponseHandler

- (instancetype)initWithResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *)error {
    self = [super init];
    if (!self) return nil;
    
    _response = response;
    _data = data;
    
    _error = error;
    if (self.data) {
        _result = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:nil];
    }
    
    [self getErrorFromResult];

    return self;
}

- (void)getErrorFromResult {
    NSString *errorMessage = [self.result valueForKeyPath:@"meta.error"];
    BOOL errorSignificant = [[self.result valueForKeyPath:@"errorSignificant"] boolValue];
    if (errorMessage) {
        NSMutableDictionary *errorUserInfo = [@{
                                        NSLocalizedDescriptionKey: @"An error occurred",
                                        NSLocalizedFailureReasonErrorKey: errorMessage,
                                        } mutableCopy];
        if (errorSignificant) {
            errorUserInfo[BAKSignificantErrorKey] = @(YES);
        }
        _error = [NSError errorWithDomain:BAKErrorDomain
                                     code:self.statusCode
                                 userInfo:errorUserInfo];
    }
}

- (NSHTTPURLResponse *)HTTPResponse {
    if ([self.response isKindOfClass:[NSHTTPURLResponse class]]) {
        return (NSHTTPURLResponse *)self.response;
    }
    return nil;
}

- (NSInteger)statusCode {
    return self.HTTPResponse.statusCode;
}

@end
