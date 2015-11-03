//
//  BAKChannelLayout.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/7/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAKChannelLayout : NSObject

- (instancetype)initWithWorkingRect:(CGRect)workingRect;

@property (nonatomic, readonly) CGRect imageRect;
@property (nonatomic, readonly) CGRect textRect;
@property (nonatomic, readonly) CGRect chevronRect;

@end
