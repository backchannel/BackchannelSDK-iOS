//
//  BAKAttachmentCell.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 6/5/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAKAttachmentCell : UICollectionViewCell

@property (nonatomic, readonly) UIActivityIndicatorView *activityIndicator;

- (void)fadeImageToOpaque;

- (void)updateWithImage:(UIImage *)image;

@property (nonatomic) BOOL loadingIndicatorAnimating;
@property (nonatomic) BOOL errorViewVisible;

@property (nonatomic) BOOL imageTranslucent;

@end
