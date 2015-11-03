//
//  BAKResponseHandler.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/21/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAKRequestTemplate.h"

extern NSString *BAKErrorDomain;
extern NSString *BAKSignificantErrorKey;

@interface BAKResponseHandler : NSObject <BAKResponse>

- (instancetype)initWithResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *)error;

@property (nonatomic, readonly) NSURLResponse *response;
@property (nonatomic, readonly) NSData *data;
@property (nonatomic, readonly) NSInteger statusCode;

@property (nonatomic) id result;
@property (nonatomic) NSError *error;

@end
