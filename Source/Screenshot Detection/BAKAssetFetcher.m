//
//  BAKRecentScreenshotFetcher.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKAssetFetcher.h"

@import AssetsLibrary;

@interface BAKAssetFetcher ()

@property (nonatomic) ALAssetsLibrary *assetsLibrary;

@end

@implementation BAKAssetFetcher

- (void)fetchMostRecentScreenshot:(void (^)(NSData *data))completionBlock {
    NSParameterAssert(completionBlock);
    [self enumerateLastGroup:^(ALAssetsGroup *group) {
        [self enumerateMostRecentAssetInGroup:group withBlock:^(ALAsset *asset) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self captureSelfToKeepHoldingAssetsLibrary];
                completionBlock([self dataForAsset:asset]);
            });
        }];
    }];
}

- (void)enumerateMostRecentAssetInGroup:(ALAssetsGroup *)group withBlock:(void (^)(ALAsset * asset))enumerationBlock {
    NSParameterAssert(enumerationBlock);
    [group enumerateAssetsWithOptions:NSEnumerationReverse
                           usingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
                               if (asset == nil) return;
                               enumerationBlock(asset);
                               *stop = YES;
                           }];
}

- (void)enumerateLastGroup:(void (^)(ALAssetsGroup *group))enumerationBlock {
    NSParameterAssert(enumerationBlock);
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                 usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                     if (group.numberOfAssets == 0) return;
                                     [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                                     enumerationBlock(group);
                                     *stop = YES;
                                 } failureBlock:^(NSError *error) {
                                     NSLog(@"error: %@", error);
                                 }];
}

- (void)fetchDataForPhotoURL:(NSURL *)photoURL completion:(void (^)(NSData *data))completionBlock {
    NSParameterAssert(completionBlock);
    [self.assetsLibrary assetForURL:photoURL resultBlock:^(ALAsset *asset) {
        [self captureSelfToKeepHoldingAssetsLibrary];
        completionBlock([self dataForAsset:asset]);
    } failureBlock:nil];
}

- (NSData *)dataForAsset:(ALAsset *)asset {
    ALAssetRepresentation *defaultRepresentation = [asset defaultRepresentation];
    NSUInteger size = (NSUInteger)defaultRepresentation.size;
    Byte *buffer = (Byte *)malloc(size);
    NSUInteger bufferLength = [defaultRepresentation getBytes:buffer fromOffset:0 length:size error:nil];
    NSData *data = [NSData dataWithBytesNoCopy:buffer length:bufferLength freeWhenDone:YES];
    return data;
}

- (ALAssetsLibrary *)assetsLibrary {
    if (!_assetsLibrary) {
        self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetsLibrary;
}

- (void)captureSelfToKeepHoldingAssetsLibrary {
    
}

@end
