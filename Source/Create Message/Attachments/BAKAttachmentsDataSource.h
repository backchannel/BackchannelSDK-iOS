//
//  BAKAttachmentsDataSource.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/6/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface BAKAttachmentsDataSource : NSObject

- (instancetype)initWithAttachmentContainers:(NSArray *)attachmentContainers editable:(BOOL)editable;

@property (nonatomic, readonly) BOOL editable;

@property (nonatomic, readonly) NSArray *attachmentContainers;

@property (readonly) NSInteger numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

@property (readonly) NSInteger attachmentsSectionIndex;
@property (readonly) NSInteger buttonSectionIndex;

@end
