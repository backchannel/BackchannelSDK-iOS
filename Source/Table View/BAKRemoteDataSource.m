//
//  BAKRemoteDataSource.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/24/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

@import UIKit;

#import "BAKRemoteDataSource.h"
#import "BAKPaginatedFetcher.h"
#import "BAKSection.h"
#import "BAKCache.h"
#import "BAKResponseHandler.h"

@interface BAKRemoteDataSource ()

@property (nonatomic) BAKPaginatedFetcher *fetcher;
@property (nonatomic) NSArray *sections;
@property (nonatomic) BOOL shouldReplaceCurrentContent;
@property (nonatomic) BAKCache *cache;

@end

@implementation BAKRemoteDataSource

- (instancetype)initWithRequestTemplate:(id<BAKRequestTemplate>)template {
    return [self initWithRequestTemplate:template cacheName:nil];
}

- (instancetype)initWithRequestTemplate:(id<BAKRequestTemplate>)template cacheName:(NSString *)cacheName {
    self = [super init];
    if (!self) return nil;
    
    _fetcher = [[BAKPaginatedFetcher alloc] initWithRequestTemplate:template];
    _cache = [[BAKCache alloc] initWithName:cacheName];
    [self setupSections];
    
    return self;
}

- (void)setupSections {
    id cachedSections = [self.cache fetchObject];
    if (cachedSections) {
        self.shouldReplaceCurrentContent = YES;
        self.sections = cachedSections;
    } else {
        [self resetSections];
    }
}

- (NSIndexSet *)contentSectionIndexes {
    return [self.sections indexesOfObjectsPassingTest:^BOOL(BAKSection *section, NSUInteger idx, BOOL *stop) {
        return section.isContentSection;
    }];
}

- (NSIndexSet *)errorSectionIndexes {
    return [self.sections indexesOfObjectsPassingTest:^BOOL(BAKSection *section, NSUInteger idx, BOOL *stop) {
        return section.isErrorSection;
    }];
}

- (NSArray *)contentSections {
    return [self.sections objectsAtIndexes:self.contentSectionIndexes];
}

- (NSArray *)errorSections {
    return [self.sections objectsAtIndexes:self.errorSectionIndexes];
}

- (BAKSection *)loadingSection {
    if (self.fetcher.hasMorePages) {
        return [BAKLoadingSection new];
    }
    return [BAKEmptySection new];
}

- (void)addContentSection:(BAKSection *)contentSection {
    NSMutableArray *mutableSections = [self.contentSections mutableCopy];
    [mutableSections addObject:contentSection];
    [mutableSections addObjectsFromArray:self.errorSections];
    [mutableSections addObject:self.loadingSection];
    self.sections = [mutableSections copy];
}

- (void)addErrorSection:(BAKSection *)errorSection {
    NSMutableArray *mutableSections = [self.contentSections mutableCopy];
    [mutableSections addObject:errorSection];
    [mutableSections addObject:self.loadingSection];
    self.sections = [mutableSections copy];
}

- (void)addNoResultsSection {
    if (self.contentSectionIndexes.count == 0) {
        self.sections = @[[BAKNoResultsSection new]];
    }
}

- (void)fetchNextPage {
    [self fetchData];
}

- (void)fetchData {
    [self.fetcher fetchWithSuccessBlock:^(NSArray *result) {
        if (self.shouldReplaceCurrentContent) {
            [self resetSections];
            self.shouldReplaceCurrentContent = NO;
        }
        if (result.count == 0) {
            [self addNoResultsSection];
        } else {
            [self addContentSection:[[BAKContentSection alloc] initWithObjects:result]];
        }
        [self.cache saveObject:self.contentSections];
        [self informDelegateOfUpdate];
    } failureBlock:^(NSError *error) {
        BOOL errorSignificant = !!(error.userInfo[BAKSignificantErrorKey]);
        if (errorSignificant || !self.shouldReplaceCurrentContent) {
            if (errorSignificant) {
                [self.cache removeCache];
                [self resetSections];
            }
            [self addErrorSection:[[BAKErrorSection alloc] initWithError:error]];
            [self informDelegateOfUpdate];
        }
    }];
}

- (void)reload {
    self.shouldReplaceCurrentContent = YES;
    [self.fetcher reset];
    [self fetchData];
}

- (void)resetSections {
    self.sections = @[[BAKLoadingSection new]];
}

- (NSInteger)numberOfSections {
    return self.sections.count;
}

- (BAKSection *)sectionAtIndex:(NSInteger)sectionIndex {
    return self.sections[sectionIndex];
}

- (NSInteger)numberOfObjectsInSection:(NSInteger)sectionIndex {
    BAKSection *section = [self sectionAtIndex:sectionIndex];
    return section.numberOfObjects;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
    BAKSection *section = [self sectionAtIndex:indexPath.section];
    return [section objectAtIndex:indexPath.row];
}

- (void)informDelegateOfUpdate {
    if ([self.delegate respondsToSelector:@selector(remoteDataSourceUpdated:)]) {
        [self.delegate remoteDataSourceUpdated:self];
    }
}

@end
