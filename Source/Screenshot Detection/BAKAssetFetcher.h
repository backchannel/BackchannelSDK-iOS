//
//  BAKRecentScreenshotFetcher.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface BAKAssetFetcher : NSObject

- (void)fetchMostRecentScreenshot:(void (^)(NSData *data))completionBlock;

- (void)fetchDataForPhotoURL:(NSURL *)photoURL completion:(void (^)(NSData *data))completionBlock;

@end
