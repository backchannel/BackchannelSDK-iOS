//
//  BAKThreadCell.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 5/28/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAKThreadCell : UITableViewCell

+ (CGFloat)heightForCell;
+ (CGFloat)totalHorizontalPaddingForMessageBodyLabel;

@property (nonatomic, readonly) UIImageView *avatarImageView;
@property (nonatomic, readonly) UILabel *subjectLabel;
@property (nonatomic, readonly) UILabel *authorLabel;
@property (nonatomic, readonly) UILabel *timeStampLabel;
@property (nonatomic, readonly) UILabel *messagePreviewLabel;
@property (nonatomic) CGSize messageBodySize;

@end
