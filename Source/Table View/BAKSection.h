//
//  BAKSection.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/7/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAKSection : NSObject

@property (readonly) BOOL isContentSection;
@property (readonly) BOOL isNoResultsSection;
@property (readonly) BOOL isErrorSection;
@property (readonly) BOOL isLoadingSection;

@property (readonly) NSInteger numberOfObjects;

- (id)objectAtIndex:(NSInteger)index;

@end


@interface BAKContentSection : BAKSection

- (instancetype)initWithObjects:(NSArray *)objects;

@property (nonatomic, readonly) NSArray *objects;

@end

@interface BAKContentSection (NSCoding) <NSSecureCoding>

@end


@interface BAKErrorSection : BAKSection

- (instancetype)initWithError:(NSError *)error;

@property (nonatomic, readonly) NSArray *errors;

@end


@interface BAKNoResultsSection : BAKSection

@end


@interface BAKLoadingSection : BAKSection

@end


@interface BAKEmptySection : BAKSection

@end