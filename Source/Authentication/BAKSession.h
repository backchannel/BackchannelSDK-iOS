//
//  BAKSession.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/22/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BAKUser;

@interface BAKSession : NSObject

+ (instancetype)currentSession;
+ (instancetype)openSessionWithDictionary:(NSDictionary *)dictionary;
+ (void)closeSession;

@property (nonatomic, readonly) NSString *authToken;
@property (nonatomic, readonly) BAKUser *user;

@property (readonly) BOOL isLoggedIn;
@property (readonly) BOOL isLoggedOut;

@end
