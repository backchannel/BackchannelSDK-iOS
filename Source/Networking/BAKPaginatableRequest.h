//
//  BAKPaginatableRequest.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAKRequestTemplate.h"

@interface BAKPaginatableRequest : NSObject<BAKRequestTemplate>

- (instancetype)initWithRequestTemplate:(id<BAKRequestTemplate>)template;
- (instancetype)initWithRequestTemplate:(id<BAKRequestTemplate>)template page:(NSInteger)page;

@property (nonatomic) id<BAKRequestTemplate> template;
@property (nonatomic) NSInteger page;

@property (readonly) BAKPaginatableRequest *requestForNextPage;

@end
