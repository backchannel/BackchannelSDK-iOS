//
//  BAKPaginatedFetcher.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/7/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKPaginatedFetcher.h"
#import "BAKSendableRequest.h"
#import "BAKPaginatableRequest.h"

static NSInteger BAKPageSize = 20;

@interface BAKPaginatedFetcher ()

@property (nonatomic) BAKSendableRequest *sendableRequest;
@property (nonatomic) BAKPaginatableRequest *paginatableRequest;
@property (nonatomic) BOOL isFetching;
@property (nonatomic) BOOL hasMorePages;

@end

@implementation BAKPaginatedFetcher

- (instancetype)initWithRequestTemplate:(id<BAKRequestTemplate>)template {
    self = [super init];
    if (!self) return nil;
    
    _paginatableRequest = [[BAKPaginatableRequest alloc] initWithRequestTemplate:template];
    
    return self;
}

- (void)fetchWithSuccessBlock:(void (^)(id))successBlock failureBlock:(void (^)(NSError *))failureBlock {
    if (self.isFetching) {
        return;
    }
    self.isFetching = YES;
    [[self newSendableRequest] sendRequestWithSuccessBlock:^(NSArray *result) {
        self.isFetching = NO;
        self.hasMorePages = (result.count == BAKPageSize);
        if (self.hasMorePages) {
            [self bumpPage];
        }
        if (successBlock) {
            successBlock(result);
        }
    } failureBlock:^(NSError *error) {
        self.isFetching = NO;
        self.hasMorePages = NO;
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

- (void)bumpPage {
    self.paginatableRequest = [self.paginatableRequest requestForNextPage];
}

- (void)reset {
    self.paginatableRequest = [[BAKPaginatableRequest alloc] initWithRequestTemplate:self.template];
}

- (id<BAKRequestTemplate>)template {
    return self.paginatableRequest.template;
}

- (BAKSendableRequest *)newSendableRequest {
    return [[BAKSendableRequest alloc] initWithRequestTemplate:self.paginatableRequest];
}

@end
