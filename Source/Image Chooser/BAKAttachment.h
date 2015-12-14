//
//  BAKAttachment.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/5/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface BAKAttachment : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic) NSString *ID;
@property (nonatomic) NSURL *URL;
@property (nonatomic) NSString *type;

@property (nonatomic) UIImage *image;

- (void)fetchImageWithSuccessBlock:(void (^)(void))successBlock failureBlock:(void (^)(NSError *error))failureBlock;

@property (readonly) BOOL imageLoaded;

@end

@interface BAKAttachment (NSCoding) <NSSecureCoding>

@end