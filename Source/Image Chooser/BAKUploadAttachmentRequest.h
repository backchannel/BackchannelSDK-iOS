//
//  BAKUploadAttachmentRequest.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/4/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAKRequestTemplate.h"
#import "BAKRemoteConfiguration.h"

@interface BAKUploadAttachmentRequest : NSObject <BAKRequestTemplate>

- (instancetype)initWithConfiguration:(BAKRemoteConfiguration *)configuration;

@property (readonly) BAKRemoteConfiguration *configuration;

@end
