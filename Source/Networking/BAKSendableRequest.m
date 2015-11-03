//
//  BAKSendableRequest.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/20/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKSendableRequest.h"
#import "BAKRequestBuilder.h"
#import "BAKResponseHandler.h"
#import "BAKSafeRequestTemplate.h"

@interface BAKSendableRequest ()

@property (nonatomic) id<BAKRequestBuilder> requestBuilder;

@end

@implementation BAKSendableRequest

- (instancetype)initWithRequestTemplate:(id<BAKRequestTemplate>)template {
    return [self initWithRequestBuilder:[[BAKRequestBuilder alloc] initWithRequestTemplate:template]];
}

- (instancetype)initWithRequestBuilder:(id<BAKRequestBuilder>)requestBuilder {
    self = [super init];
    if (!self) return nil;
    
    _requestBuilder = requestBuilder;
    
    return self;
}

- (id<BAKRequestTemplate>)template {
    return self.requestBuilder.template;
}

- (void)sendRequestWithSuccessBlock:(void (^)(id result))successBlock failureBlock:(void (^)(NSError *error))failureBlock {
    [[[NSURLSession sharedSession] dataTaskWithRequest:self.requestBuilder.URLRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            BAKResponseHandler *responseHandler = [[BAKResponseHandler alloc] initWithResponse:response data:data error:error];
            if ([self.template respondsToSelector:@selector(finalizeWithResponse:)]) {
                [self.template finalizeWithResponse:responseHandler];
            }
            if (responseHandler.error) {
                if (failureBlock) {
                    failureBlock(responseHandler.error);
                }
            } else if (responseHandler.result) {
                if (successBlock) {
                    successBlock(responseHandler.result);
                }
            }
        });
    }] resume];
}

@end
