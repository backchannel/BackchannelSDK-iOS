//
//  BAKFormGroup.m
//  BackchannelSDK
//
//  Created by Soroush Khanlou on 7/16/15.
//  Copyright (c) 2015 Backchannel. All rights reserved.
//

#import "BAKFormGroup.h"
#import "BAKGeometry.h"
#import "BAKColor.h"

@interface BAKFormGroup ()

@property (nonatomic) NSMutableArray *formFields;

@end

@implementation BAKFormGroup

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [BAKColor separatorColor].CGColor;
    self.layer.borderWidth = 1.0/[UIScreen mainScreen].scale;
    
    return self;
}

- (void)addFormField:(BAKFormField *)formField {
    [self addSubview:formField];
    [self.formFields addObject:formField];
}

- (NSMutableArray *)formFields {
    if (!_formFields) {
        self.formFields = [NSMutableArray array];
    }
    return _formFields;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    __block CGRect workingRect = self.bounds;
    workingRect = BAKRectTrim(workingRect, 16, CGRectMinXEdge);
    workingRect.size.height = CGFLOAT_MAX;
    
    [self.formFields enumerateObjectsUsingBlock:^(BAKFormField *formField, NSUInteger idx, BOOL *stop) {
        CGRect formRect = CGRectZero;
        CGRectDivide(workingRect, &formRect, &workingRect, 44, CGRectMinYEdge);
        formField.frame = formRect;
    }];
}

@end
