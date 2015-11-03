//
//  BAKCacher.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/8/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAKCache : NSObject

+ (void)enable;
+ (void)disable;

+ (void)clearAllCaches;

- (instancetype)initWithName:(NSString *)name;

@property (nonatomic, readonly) NSString *name;

- (void)saveObject:(id<NSCoding>)object;

- (id<NSCoding>)fetchObject;

- (void)removeCache;

@end
