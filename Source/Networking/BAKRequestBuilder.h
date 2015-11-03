//
//  BAKRequestBuilder.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/21/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAKRequestTemplate.h"

@class BAKSafeRequestTemplate;

@interface BAKRequestBuilder : NSObject <BAKRequestBuilder>

- (instancetype)initWithRequestTemplate:(id<BAKRequestTemplate>)template;

@property (nonatomic, readonly) id<BAKRequestTemplate> template;

@property (readonly) NSURLRequest *URLRequest;

@end
