//
//  BAKSendableRequest.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/20/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BAKRequestTemplate, BAKRequestBuilder;

@interface BAKSendableRequest : NSObject

- (instancetype)initWithRequestTemplate:(id<BAKRequestTemplate>)template;
- (instancetype)initWithRequestBuilder:(id<BAKRequestBuilder>)requestBuilder;

@property (nonatomic) id<BAKRequestTemplate> template;

- (void)sendRequestWithSuccessBlock:(void (^)(id result))successBlock failureBlock:(void (^)(NSError *error))failureBlock;

@end
