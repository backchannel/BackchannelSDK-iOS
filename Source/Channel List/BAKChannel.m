//
//  BAKChannel.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/25/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKChannel.h"
#import "BAKAttachment.h"

@implementation BAKChannel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self) return nil;
    
    _ID = dictionary[@"ID"];
    _name = dictionary[@"name"];
    _icon = [[BAKAttachment alloc] initWithDictionary:dictionary[@"icon"]];
    
    return self;
}

@end

@implementation BAKChannel (NSCoding)

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) return nil;
    
    _ID = [decoder decodeObjectOfClass:[NSString class] forKey:@"ID"];
    _name = [decoder decodeObjectOfClass:[NSString class] forKey:@"name"];
    _icon = [decoder decodeObjectOfClass:[BAKAttachment class] forKey:@"icon"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.ID forKey:@"ID"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.icon forKey:@"icon"];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
