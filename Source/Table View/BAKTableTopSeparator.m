//
//  BAKTopTableSeparator.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/31/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKTableTopSeparator.h"
#import "BAKColor.h"
#import "BAKGeometry.h"

@interface BAKTableTopSeparator ()

@property (nonatomic) UIView *separatorView;

@end

@implementation BAKTableTopSeparator

- (instancetype)initWithFrame:(CGRect)frame inset:(CGFloat)inset color:(UIColor *)color {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    UIView *separatorView = [[UIView alloc] init];
    separatorView.backgroundColor = color;
    [self addSubview:separatorView];
    self.separatorView = separatorView;

    _inset = inset;
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect workingRect = self.bounds;
    CGRect separatorRect = BAKRectTrim(workingRect, self.inset, CGRectMinXEdge);
    separatorRect.size.height = 1.0/[UIScreen mainScreen].scale;
    self.separatorView.frame = separatorRect;
}

@end
