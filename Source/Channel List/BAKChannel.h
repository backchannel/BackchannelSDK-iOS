//
//  BAKChannel.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/25/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BAKAttachment;

@interface BAKChannel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic) NSString *ID;
@property (nonatomic) NSString *name;
@property (nonatomic) BAKAttachment *icon;

@end

@interface BAKChannel (NSCoding) <NSSecureCoding>

@end
