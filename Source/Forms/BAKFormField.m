//
//  BAKTextFormField.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/2/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKFormField.h"
#import "BAKGeometry.h"
#import "BAKColor.h"

@interface BAKFormField ()

@property (nonatomic) UILabel *label;
@property (nonatomic) UIView *separator;

@end

@implementation BAKFormField

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.clipsToBounds = YES;
    
    return self;
}

- (UIView *)separator {
    if (!_separator) {
        UIView *separator = [[UIView alloc] init];
        separator.backgroundColor = [BAKColor separatorColor];
        [self addSubview:separator];
        
        self.separator = separator;
    }
    return _separator;
}

- (UILabel *)label {
    if (!_label) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:label];
        self.label = label;
    }
    return _label;
}

- (void)setContentView:(UIView *)contentView {
    if (self.contentView.superview == self) {
        [self.contentView removeFromSuperview];
    }
    _contentView = contentView;
    [self addSubview:self.contentView];
}

- (void)setAccessoryView:(UIView *)accessoryView {
    if (self.accessoryView.superview == self) {
        [self.accessoryView removeFromSuperview];
    }
    _accessoryView = accessoryView;
    [self addSubview:self.accessoryView];
}

- (NSString *)labelText {
    return self.label.text;
}

- (void)setLabelText:(NSString *)labelText {
    self.label.text = labelText;
}

- (void)setLabelTextColor:(UIColor *)labelTextColor {
    self.label.textColor = labelTextColor;
}

- (UIColor *)labelTextColor {
    return self.label.textColor;
}

- (BOOL)shouldShowSeparator {
    return !self.separator.hidden;
}

- (void)setShouldShowSeparator:(BOOL)shouldShowSeparator {
    self.separator.hidden = !shouldShowSeparator;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect workingRect = self.bounds;
    
    CGRect labelRect = CGRectZero, contentRect = CGRectZero, separatorRect = CGRectZero, accessoryRect = CGRectZero;
    
    CGRectDivide(workingRect, &separatorRect, &workingRect, 1, CGRectMaxYEdge);
    separatorRect.size.height /= [UIScreen mainScreen].scale;
    
    CGFloat labelWidth = self.labelWidth;
    if (labelWidth == 0) {
        CGSize labelSize = [self.label sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
        if (labelSize.width != 0) {
            labelWidth = labelSize.width + 5;
        }
    }

    CGRectDivide(workingRect, &labelRect, &workingRect, labelWidth, CGRectMinXEdge);
    
    if (self.accessoryView) {
        CGRectDivide(workingRect, &accessoryRect, &workingRect, self.bounds.size.height, CGRectMaxXEdge);
    }
    
    contentRect = workingRect;
    
    self.label.frame = labelRect;
    self.contentView.frame = contentRect;
    self.separator.frame = separatorRect;
    self.accessoryView.frame = accessoryRect;
}

- (UITextField *)setTextFieldAsContentView {
    UITextField *textField = [self newTextField];
    self.contentView = textField;
    return textField;
}

- (UITextField *)newTextField {
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleNone;
    textField.font = [UIFont systemFontOfSize:14.0f];
    textField.backgroundColor = [UIColor whiteColor];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    return textField;
}


@end
