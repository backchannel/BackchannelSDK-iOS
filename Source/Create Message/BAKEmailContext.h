//
//  BAKEmailContext.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 8/20/16.
//  Copyright © 2016 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BAKEmailContext <NSObject>

@property (nonatomic, readonly) BOOL canSendMail;
@property (nonatomic, readonly) NSString *emailAddress;
@property (nonatomic, readonly) NSString *subject;

@property (nonatomic, readonly) NSArray *toRecipients;


@end

@interface BAKEmailContext : NSObject<BAKEmailContext>

- (instancetype)initWithEmailAddress:(NSString *)emailAddress subject:(NSString *)subject;


@end

@interface BAKNullEmailContext : NSObject<BAKEmailContext>

@end
