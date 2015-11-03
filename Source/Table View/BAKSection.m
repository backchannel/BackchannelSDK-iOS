//
//  BAKSection.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/7/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKSection.h"

@implementation BAKSection

- (BOOL)isContentSection {
    return NO;
}

- (BOOL)isErrorSection {
    return NO;
}

- (BOOL)isLoadingSection {
    return NO;
}

- (BOOL)isNoResultsSection {
    return NO;
}

- (NSInteger)numberOfObjects {
    return 0;
}

- (id)objectAtIndex:(NSInteger)index {
    NSAssert(NO, nil);
    return nil;
}

@end


@implementation BAKContentSection

- (instancetype)initWithObjects:(NSArray *)objects {
    self = [super init];
    if (!self) return nil;
    
    _objects = objects;
    
    return self;
}

- (BOOL)isContentSection {
    return YES;
}

- (NSInteger)numberOfObjects {
    return self.objects.count;
}

- (id)objectAtIndex:(NSInteger)index {
    return index < self.objects.count ? self.objects[index] : nil;
}

@end

@implementation BAKContentSection (NSCoding)

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) return nil;
    
    _objects = [decoder decodeObjectOfClass:[NSArray class] forKey:@"objects"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.objects forKey:@"objects"];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end


@implementation BAKErrorSection

- (instancetype)initWithError:(NSError *)error {
    self = [super init];
    if (!self) return nil;
    
    _errors = @[error];
    
    return self;
}

- (BOOL)isErrorSection {
    return YES;
}

- (NSInteger)numberOfObjects {
    return self.errors.count;
}

- (id)objectAtIndex:(NSInteger)index {
    return self.errors[index];
}

@end

@implementation BAKNoResultsSection

- (BOOL)isNoResultsSection {
    return YES;
}

- (NSInteger)numberOfObjects {
    return 1;
}

- (id)objectAtIndex:(NSInteger)index {
    return @"No results.";
}

@end



@implementation BAKLoadingSection

- (NSInteger)numberOfObjects {
    return 1;
}

- (BOOL)isLoadingSection {
    return YES;
}

@end

@implementation BAKEmptySection

- (NSInteger)numberOfObjects {
    return 0;
}

@end