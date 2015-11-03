//
//  BAKDraft.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/6/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAKDraft : NSObject

@property (nonatomic) NSString *subject;
@property (nonatomic) NSString *body;
@property (nonatomic) NSArray *attachments;
@property (readonly) NSArray *attachmentIDs;

@end
