//
//  BAKMappedArray.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 10/7/15.
//  Copyright © 2015 Backchannel. All rights reserved.
//

#import "BAKMappedArray.h"

@interface BAKMappedArray ()

@property (nonatomic) NSArray *backingArray;

@end

@implementation BAKMappedArray

- (instancetype)initWithArray:(NSArray *)array transformationBlock:(id (^)(id object))block {
    self = [super init];
    if (!self) return nil;
    
    NSMutableArray *mappedArray = [NSMutableArray arrayWithCapacity:array.count];
    for (NSInteger i = 0; i < array.count; i++) {
        [mappedArray addObject:block(array[i]) ?: [NSNull null]];
    }
    _backingArray = [mappedArray copy];
    
    return self;
}

- (NSUInteger)count {
    return self.backingArray.count;
}

- (id)objectAtIndex:(NSUInteger)index {
    return [self.backingArray objectAtIndex:index];
}

@end
