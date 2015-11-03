//
//  BAKMultipartRequestBuilder.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/4/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAKRequestTemplate.h"

@interface BAKMultipartRequestBuilder : NSObject <BAKRequestBuilder>

- (instancetype)initWithRequestTemplate:(id<BAKRequestTemplate>)template data:(NSData *)data;

@property (nonatomic, readonly) NSData *data;
@property (nonatomic, readonly) id<BAKRequestTemplate> template;

@property (readonly) NSURLRequest *URLRequest;

@end
