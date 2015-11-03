//
//  BAKThread.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/25/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKThread.h"
#import "BAKMessage.h"

@implementation BAKThread

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self) return nil;
    
    _ID = dictionary[@"ID"];
    _subject = dictionary[@"subject"];
    _newestMessage = [[BAKMessage alloc] initWithDictionary:dictionary[@"newestMessage"]];
    
    return self;
}

@end

@implementation BAKThread (NSCoding)

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) return nil;
    
    _ID = [decoder decodeObjectOfClass:[NSString class] forKey:@"ID"];
    _subject = [decoder decodeObjectOfClass:[NSString class] forKey:@"subject"];
    _newestMessage = [decoder decodeObjectOfClass:[BAKMessage class] forKey:@"newestMessage"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.ID forKey:@"ID"];
    [encoder encodeObject:self.subject forKey:@"subject"];
    [encoder encodeObject:self.newestMessage forKey:@"newestMessage"];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end