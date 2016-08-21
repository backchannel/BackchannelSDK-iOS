//
//  BAKThread.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/25/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BAKMessage;

@interface BAKThread : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic) NSString *ID;
@property (nonatomic) NSString *subject;
@property (nonatomic) BAKMessage *newestMessage;
@property (nonatomic) NSString *postEmail;


@end

@interface BAKThread (NSCoding) <NSSecureCoding>

@end
