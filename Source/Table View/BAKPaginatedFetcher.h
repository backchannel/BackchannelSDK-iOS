//
//  BAKPaginatedFetcher.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/7/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAKRequestTemplate.h"

@interface BAKPaginatedFetcher : NSObject

- (instancetype)initWithRequestTemplate:(id<BAKRequestTemplate>)template;

- (void)fetchWithSuccessBlock:(void (^)(id result))successBlock failureBlock:(void (^)(NSError *error))failureBlock;

@property (nonatomic, readonly) BOOL hasMorePages;

- (void)reset;
- (void)bumpPage;

@end
