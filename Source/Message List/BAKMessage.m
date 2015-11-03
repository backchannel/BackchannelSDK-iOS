//
//  BAKMessage.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/25/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKMessage.h"
#import "BAKUser.h"
#import "BAKAttachment.h"
#import "BAKMappedArray.h"
#import "BAKShortDate.h"
#import "BAKAttachmentContainer.h"

@import UIKit;

@interface BAKMessage ()

@property (nonatomic) CGSize textSize;
@property (nonatomic) BAKShortDate *shortDate;

@end

@implementation BAKMessage

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self) return nil;
    
    _ID = dictionary[@"ID"];
    if (dictionary[@"body"]) {
        [self updateWithBody:dictionary[@"body"]];
    }
    if (dictionary[@"author"]) {
        _author = [[BAKUser alloc] initWithDictionary:dictionary[@"author"]];
    }
    _attachments = [[BAKMappedArray alloc] initWithArray:dictionary[@"attachments"] transformationBlock:^id(id attachmentDictionary) {
        return [[BAKAttachment alloc] initWithDictionary:attachmentDictionary];
    }];
    _shortDate = [[BAKShortDate alloc] initWithDate:[NSDate dateWithTimeIntervalSince1970:[dictionary[@"postedAt"] doubleValue]]];
    _permissions = dictionary[@"permissions"];
    
    return self;
}

- (NSString *)body {
    return self.attributedBody.string;
}

- (CGSize)textSizeWithWidth:(CGFloat)width {
    CGRect boundingRect =
    [self.attributedBody boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                      context:NULL];
    return boundingRect.size;
}

- (void)updateWithBody:(NSString *)body {
    _attributedBody = [[NSAttributedString alloc] initWithString:body attributes:@{ NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody] }];
}

- (void)setTextToDeleted {
    return [self updateWithBody:@"[Deleted]"];
}

- (BOOL)hasAttachments {
    return self.attachments.count != 0;
}

- (NSString *)dateDisplayString {
    return self.shortDate.displayString;
}

- (NSArray *)attachmentContainers {
    return [[BAKMappedArray alloc] initWithArray:self.attachments transformationBlock:^id(BAKAttachment *attachment) {
        BAKAttachmentContainer *container = [[BAKAttachmentContainer alloc] init];
        [container updateWithAttachment:attachment];
        return container;
    }];
}

- (BOOL)canBeDeleted {
    return [self.permissions containsObject:@"delete"];
}

@end

@implementation BAKMessage (NSCoding)

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) return nil;
    
    self.ID = [decoder decodeObjectOfClass:[NSString class] forKey:@"ID"];
    self.author = [decoder decodeObjectOfClass:[NSString class] forKey:@"author"];
    self.attributedBody = [decoder decodeObjectOfClass:[NSAttributedString class] forKey:@"attributedBody"];
    self.attachments = [decoder decodeObjectOfClass:[NSArray class] forKey:@"attachments"];
    self.shortDate = [decoder decodeObjectOfClass:[BAKShortDate class] forKey:@"shortDate"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.ID forKey:@"ID"];
    [encoder encodeObject:self.author forKey:@"author"];
    [encoder encodeObject:self.attributedBody forKey:@"attributedBody"];
    [encoder encodeObject:self.attachments forKey:@"attachments"];
    [encoder encodeObject:self.shortDate forKey:@"shortDate"];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
