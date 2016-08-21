//
//  BAKEmailContext.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/20/16.
//  Copyright © 2016 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAKEmailContext : NSObject

- (instancetype)initWithEmailAddress:(NSString *)emailAddress subject:(NSString *)subject;

@property (nonatomic) NSString *emailAddress;
@property (nonatomic) NSString *subject;

@property (nonatomic, readonly) NSArray *toRecipients;

@end
