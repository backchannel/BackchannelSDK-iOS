//
//  BAKTextFormField.h
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/2/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

@import UIKit;

@interface BAKFormField : UIView

@property (nonatomic, assign) BOOL shouldShowSeparator;

@property (nonatomic) UIView *contentView;
@property (nonatomic) UIView *accessoryView;

@property (nonatomic) NSString *labelText;
@property (nonatomic) CGFloat labelWidth;
@property (nonatomic) UIColor *labelTextColor;


- (UITextField *)setTextFieldAsContentView;

@end
