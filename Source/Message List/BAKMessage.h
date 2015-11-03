//
//  BAKMessage.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/25/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreGraphics;

@class BAKUser, BAKAttachment;

@interface BAKMessage : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic) NSString *ID;
@property (nonatomic) BAKUser *author;
@property (nonatomic) NSAttributedString *attributedBody;
@property (nonatomic) NSArray *attachments;
@property (nonatomic) NSArray *permissions;

@property (readonly) NSString *body;
@property (readonly) NSString *dateDisplayString;
@property (readonly) BOOL canBeDeleted;

- (CGSize)textSizeWithWidth:(CGFloat)width;

- (void)updateWithBody:(NSString *)body;
- (void)setTextToDeleted;

@property (readonly) BOOL hasAttachments;

@property (readonly) NSArray *attachmentContainers;

@end

@interface BAKMessage (NSCoding) <NSSecureCoding>

@end
