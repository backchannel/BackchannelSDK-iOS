//
//  BAKUser.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/29/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BAKAttachment;

@interface BAKUser : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic) NSString *ID;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *bio;
@property (nonatomic) NSString *displayName;
@property (nonatomic) BAKAttachment *avatar;

@end

@interface BAKUser (NSCoding) <NSSecureCoding>

@end
