//
//  BAKShortDate.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/17/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAKShortDate : NSObject

- (instancetype)initWithDate:(NSDate *)date;

@property (nonatomic, readonly) NSDate *date;

@property (nonatomic, readonly) NSString *displayString;

@end

@interface BAKShortDate (NSCoding) <NSSecureCoding>

@end