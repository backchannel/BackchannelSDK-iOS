//
//  BAKAttachmentsDataSource.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/6/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKAttachmentsDataSource.h"

@implementation BAKAttachmentsDataSource

- (instancetype)initWithAttachmentContainers:(NSArray *)attachmentContainers editable:(BOOL)editable {
    self = [super init];
    if (!self) return nil;
    
    _attachmentContainers = attachmentContainers;
    _editable = editable;
    
    return self;
}

- (BOOL)showButton {
    return self.editable && self.attachmentContainers.count < 5;
}

- (NSInteger)buttonSectionIndex {
    return self.showButton ? 1 : NSNotFound;
}

- (NSInteger)attachmentsSectionIndex {
    return 0;
}

- (NSInteger)numberOfSections {
    return self.showButton ? 2 : 1;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    if (section == self.buttonSectionIndex) {
        return 1;
    }
    return self.attachmentContainers.count;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == self.buttonSectionIndex) {
        return nil;
    }
    return self.attachmentContainers[indexPath.row];
}

@end
