//
//  BAKKeychain.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/24/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAKKeychain : NSObject

- (void)storeAuthToken:(NSString *)authToken error:(NSError *__autoreleasing *)error;
- (NSString *)fetchAuthTokenWithError:(NSError *__autoreleasing *)error;
- (void)deleteAuthToken:(NSError *__autoreleasing *)error;

@end
