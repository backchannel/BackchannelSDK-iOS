//
//  BAKMappedArray.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 10/7/15.
//  Copyright © 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAKMappedArray : NSArray

- (instancetype)initWithArray:(NSArray *)array transformationBlock:(id (^)(id object))block;

@end
