//
//  BAKTopTableSeparator.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/31/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAKTableTopSeparator : UIView

- (instancetype)initWithFrame:(CGRect)frame inset:(CGFloat)inset color:(UIColor *)color;

@property (nonatomic, readonly) CGFloat inset;

@end
