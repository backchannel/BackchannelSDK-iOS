//
//  BAKAttachment.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/5/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKAttachment.h"

@implementation BAKAttachment

+ (NSCache *)imageCache {
    static dispatch_once_t onceToken;
    static NSCache *imageCache;
    dispatch_once(&onceToken, ^{
        imageCache = [NSCache new];
    });
    return imageCache;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self) return nil;
    
    _ID = dictionary[@"ID"];
    _URL = [NSURL URLWithString:dictionary[@"full"][@"URL"]];
    _type = dictionary[@"type"];

    return self;
}

- (void)fetchImageWithSuccessBlock:(void (^)(void))successBlock failureBlock:(void (^)(NSError *error))failureBlock {
    if (![self.type isEqualToString:@"image"]) {
        if (failureBlock) {
            failureBlock([NSError errorWithDomain:@"io.backchannel.Backchannel" code:99 userInfo:@{NSLocalizedDescriptionKey: @"Can't load non-image attachment types."}]);
        }
        return;
    }
    if (!self.URL) {
        if (failureBlock) {
            failureBlock([NSError errorWithDomain:@"io.backchannel.Backchannel" code:99 userInfo:@{NSLocalizedDescriptionKey: @"Couldn't load image from a blank URL."}]);
        }
        return;
    }
    UIImage *cachedImage = [[self.class imageCache] objectForKey:self.URL];
    if (cachedImage) {
        self.image = cachedImage;
        if (successBlock) {
            dispatch_async(dispatch_get_main_queue(), successBlock);
        }
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul), ^{
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:self.URL options:0 error:&error];
        if (error) {
            if (failureBlock) failureBlock(error);
        } else {
            UIImage *image = [UIImage imageWithData:data];
            if (!image) {
                if (failureBlock) {
                    failureBlock([NSError errorWithDomain:@"io.backchannel.Backchannel" code:98 userInfo:@{NSLocalizedDescriptionKey: @"Couldn't load image; data malformed."}]);
                }
                return;
            }
            [[self.class imageCache] setObject:image forKey:self.URL];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = image;
                if (successBlock) successBlock();
            });
        }
    });
}

- (BOOL)imageLoaded {
    return self.image != nil;
}

@end

@implementation BAKAttachment (NSCoding)

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) return nil;
    
    _ID = [decoder decodeObjectOfClass:[NSString class] forKey:@"ID"];
    _URL = [decoder decodeObjectOfClass:[NSURL class] forKey:@"URL"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.ID forKey:@"ID"];
    [encoder encodeObject:self.URL forKey:@"URL"];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
