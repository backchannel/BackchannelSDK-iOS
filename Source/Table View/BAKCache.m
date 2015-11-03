//
//  BAKCacher.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/8/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKCache.h"
#import <CommonCrypto/CommonCrypto.h>

@interface BAKCache ()

@end

@implementation BAKCache

static BOOL _enabled = NO;

+ (void)enable {
    _enabled = YES;
}

+ (void)disable {
    _enabled = NO;
}

+ (void)clearAllCaches {
    BAKCache *cache = [BAKCache new];
    [[NSFileManager defaultManager] removeItemAtPath:cache.appCacheDirectory error:nil];
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (!_enabled || !name) self = nil;
    if (!self) return nil;
    
    _name = name;
    
    return self;
}

- (void)saveObject:(id<NSCoding>)object {
    [NSKeyedArchiver archiveRootObject:object toFile:self.cacheLocation];
}

- (id<NSCoding>)fetchObject {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:self.cacheLocation];
}

- (void)removeCache {
    [[NSFileManager defaultManager] removeItemAtPath:self.cacheLocation error:nil];
}

- (NSString *)cacheLocation {
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.appCacheDirectory isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:self.appCacheDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [self.appCacheDirectory stringByAppendingPathComponent:self.cacheFilename];
}

- (NSString *)appCacheDirectory {
    return [self.generalCacheDirectory stringByAppendingPathComponent:@"backchannel"];
}

- (NSString *)generalCacheDirectory {
    NSArray *searchPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return searchPath.firstObject;
}

- (NSString *)cacheFilename {
    return [self.hashedName stringByAppendingPathExtension:@"cache"];
}

- (NSString *)hashedName {
    const char *cString = [self.name UTF8String];
    unsigned char digest[16];
    CC_MD5(cString, (int)strlen(cString), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

@end
