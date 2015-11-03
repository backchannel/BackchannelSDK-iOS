//
//  BAKUser.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/29/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKUser.h"
#import "BAKAttachment.h"

@implementation BAKUser

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self) return nil;
    
    _ID = dictionary[@"ID"];
    _email = dictionary[@"email"];
    _bio = dictionary[@"bio"];
    _displayName = dictionary[@"displayName"];
    _avatar = [[BAKAttachment alloc] initWithDictionary:dictionary[@"avatar"]];
    
    return self;
}

@end

@implementation BAKUser (NSCoding)

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) return nil;
    
    self.ID = [decoder decodeObjectOfClass:[NSString class] forKey:@"ID"];
    self.email = [decoder decodeObjectOfClass:[NSString class] forKey:@"email"];
    self.bio = [decoder decodeObjectOfClass:[NSString class] forKey:@"bio"];
    self.displayName = [decoder decodeObjectOfClass:[NSString class] forKey:@"displayName"];
    self.avatar = [decoder decodeObjectOfClass:[BAKAttachment class] forKey:@"avatar"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.ID forKey:@"ID"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.bio forKey:@"bio"];
    [encoder encodeObject:self.displayName forKey:@"displayName"];
    [encoder encodeObject:self.avatar forKey:@"avatar"];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
