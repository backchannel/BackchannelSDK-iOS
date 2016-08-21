//
//  BAKEmailContext.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/20/16.
//  Copyright © 2016 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAKEmailContext : NSObject

- (instancetype)initWithEmailAddress:(NSString *)emailAddress;

@property (nonatomic) NSString *emailAddress;

@property (nonatomic, readonly) NSURL *emailURL;

@end
