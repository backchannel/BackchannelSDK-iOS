//
//  BAKRemoteDataSource.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/24/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAKRequestTemplate.h"

@class BAKRemoteDataSource, BAKSection;

@protocol BAKRemoteDataSourceDelegate <NSObject>

- (void)remoteDataSourceUpdated:(BAKRemoteDataSource *)remoteDataSource;

@end

@interface BAKRemoteDataSource : NSObject

- (instancetype)initWithRequestTemplate:(id<BAKRequestTemplate>)template;
- (instancetype)initWithRequestTemplate:(id<BAKRequestTemplate>)template cacheName:(NSString *)cacheName;

@property (nonatomic, readonly) id<BAKRequestTemplate> template;

- (void)fetchData;
- (void)fetchNextPage;

@property (nonatomic, weak) id<BAKRemoteDataSourceDelegate> delegate;

@property (nonatomic, assign) NSInteger numberOfSections;
- (BAKSection *)sectionAtIndex:(NSInteger)sectionIndex;
- (NSInteger)numberOfObjectsInSection:(NSInteger)sectionIndex;
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

- (void)reload;

@end
